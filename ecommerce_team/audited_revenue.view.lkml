view: audited_revenue {
  sql_table_name: bigquery-public-data.thelook_ecommerce.order_items ;;


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }


  dimension_group: created {
    type: time
    timeframes: [raw, date, month, quarter, year, fiscal_quarter, fiscal_year]
    sql: ${TABLE}.created_at ;;
  }


  dimension: currency_code {
    type: string
    sql:
      CASE ${audited_user.country}
        WHEN 'United States' THEN 'USD'
        WHEN 'United Kingdom' THEN 'GBP'
        WHEN 'Germany' THEN 'EUR'
        WHEN 'Japan' THEN 'JPY'
        ELSE 'USD'
      END ;;
  }


  measure: audited_net_revenue_usd {
    type: sum
    label: "Audited Net Revenue (USD)"
    value_format: "$#,##0.00"
    filters: [status: "Complete"]
    sql: ${TABLE}.sale_price ;;
  }


  measure: audited_net_revenue_local {
    type: sum
    label: "Audited Net Revenue (Local Currency)"
    value_format: "#,##0.00"
    filters: [status: "Complete"]
    sql:
      ${TABLE}.sale_price * CASE ${audited_user.country}
        WHEN 'United Kingdom' THEN 0.79
        WHEN 'Germany' THEN 0.92
        WHEN 'Japan' THEN 150.25
        ELSE 1.00
      END ;;
  }
}
