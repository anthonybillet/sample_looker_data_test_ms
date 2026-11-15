view: quarterly_perf_test {
  sql_table_name: `looker-private-demo.looker_scratch.quarterly_perf_test`
    ;;

  dimension: quarter {
    description: "The fiscal quarter."
    type: string
    sql: ${TABLE}.quarter ;;
  }

  dimension: region {
    description: "The geographic region."
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: product_line {
    description: "The product line."
    type: string
    sql: ${TABLE}.product_line ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: target_revenue {
    type: number
    sql: ${TABLE}.target_revenue ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
    value_format_name: usd
  }

  measure: total_target {
    type: sum
    sql: ${target_revenue} ;;
    value_format_name: usd
  }

  measure: gross_margin_pct {
    type: number
    sql: (sum(${revenue}) - sum(${cost})) / NULLIF(sum(${revenue}), 0) ;;
    value_format_name: percent_1
  }

  measure: target_attainment_pct {
    type: number
    sql: sum(${revenue}) / NULLIF(sum(${target_revenue}), 0) ;;
    value_format_name: percent_1
  }
}
