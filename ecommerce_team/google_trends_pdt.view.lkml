view: google_trends_pdt {
  derived_table: {
    datagroup_trigger: google_trends_incremental_dg
    increment_key: "event_date"
    increment_offset: 2

    sql:
      SELECT
        refresh_date AS event_date,
        week AS trend_week,
        dma_name,
        dma_id,
        term,
        AVG(score) AS avg_search_score,
        MIN(rank) AS best_rank,
        COUNT(*) AS record_count
      FROM `bigquery-public-data.google_trends.top_terms`
      WHERE refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
      AND {% incrementcondition %} TIMESTAMP(refresh_date) {% endincrementcondition %}
      GROUP BY 1, 2, 3, 4, 5
    ;;
  }

  dimension: event_date {
    type: date
    label: "Refresh / Event Date"
    sql: ${TABLE}.event_date ;;
  }

  dimension: trend_week {
    type: date
    sql: ${TABLE}.trend_week ;;
  }

  dimension: dma_name {
    type: string
    label: "Metro Area (DMA)"
    sql: ${TABLE}.dma_name ;;
  }

  dimension: term {
    type: string
    label: "Search Term"
    sql: ${TABLE}.term ;;
  }

  measure: average_score {
    type: average
    value_format_name: decimal_1
    sql: ${TABLE}.avg_search_score ;;
  }

  measure: top_rank {
    type: min
    sql: ${TABLE}.best_rank ;;
  }

  measure: total_records {
    type: sum
    sql: ${TABLE}.record_count ;;
  }
}
