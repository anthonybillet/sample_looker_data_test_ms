
view: regional_transactions {
  derived_table: {
    sql: {% raw %} SELECT *
      FROM (
        SELECT
          CONCAT(region, '_', raw_id) AS composite_row_id,
          region,
          REGEXP_EXTRACT(raw_category_string, r'CAT-([A-Za-z0-9]+)') AS clean_category_code,
          LOWER(TRIM(metric_name)) AS metric_name,
          SAFE_CAST(metric_value AS NUMERIC) AS metric_value,
          DATE(transaction_date) AS transaction_date
        FROM (
          SELECT 'US' AS region, * FROM (
            SELECT '1001' AS raw_id, 'ITEM_CAT-A12_US' AS raw_category_string, 'revenue' AS metric_name, '1500.50' AS metric_value, '2026-11-01' AS transaction_date
            UNION ALL SELECT '1001', 'ITEM_CAT-A12_US', 'cost', '800.00', '2026-11-01'
            UNION ALL SELECT '1001', 'ITEM_CAT-A12_US', 'units', '15', '2026-11-01'
            UNION ALL SELECT '1002', 'ITEM_CAT-B99_US', 'revenue', '2300.00', '2026-11-02'
            UNION ALL SELECT '1002', 'ITEM_CAT-B99_US', 'cost', '1100.25', '2026-11-02'
            UNION ALL SELECT '1002', 'ITEM_CAT-B99_US', 'units', '20', '2026-11-02'
          )
          UNION ALL
          SELECT 'EMEA' AS region, * FROM (
            SELECT '2001' AS raw_id, 'PRD_CAT-A12_EU' AS raw_category_string, 'REVENUE' AS metric_name, '1850.00' AS metric_value, '2026-11-01' AS transaction_date
            UNION ALL SELECT '2001', 'PRD_CAT-A12_EU', 'COST', '920.00', '2026-11-01'
            UNION ALL SELECT '2001', 'PRD_CAT-A12_EU', 'UNITS', '18', '2026-11-01'
          )
          UNION ALL
          SELECT 'APAC' AS region, * FROM (
            SELECT '3001' AS raw_id, 'SKU_CAT-C04_AP' AS raw_category_string, ' revenue ' AS metric_name, '3200.75' AS metric_value, '2026-11-03' AS transaction_date
            UNION ALL SELECT '3001', 'SKU_CAT-C04_AP', ' cost ', '1450.50', '2026-11-03'
            UNION ALL SELECT '3001', 'SKU_CAT-C04_AP', ' units ', '32', '2026-11-03'
          )
        ) AS consolidated_staging
        WHERE raw_id IS NOT NULL
      ) AS cleaned_data
      PIVOT (
        SUM(metric_value)
        FOR metric_name IN ('revenue', 'cost', 'units')
      ) {% endraw %} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: composite_row_id {
    type: string
    sql: ${TABLE}.composite_row_id ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: clean_category_code {
    type: string
    sql: ${TABLE}.clean_category_code ;;
  }

  dimension: transaction_date {
    type: date
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: units {
    type: number
    sql: ${TABLE}.units ;;
  }

  set: detail {
    fields: [
        composite_row_id,
  region,
  clean_category_code,
  transaction_date,
  revenue,
  cost,
  units
    ]
  }
}
