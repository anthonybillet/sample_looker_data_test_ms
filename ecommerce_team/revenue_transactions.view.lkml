view: revenue_transactions {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.revenue_transactions` ;;

  dimension: transaction_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension_group: transaction {
    type: time
    label: "Order Date"
    description: "Date when the revenue transaction occurred"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: region {
    type: string
    label: "Sales Region"
    description: "Geographic sales territory (North America, EMEA, APAC, LATAM)"
    sql: ${TABLE}.region ;;
  }

  dimension: segment {
    type: string
    label: "Customer Segment"
    description: "Account tier such as Enterprise, Mid-Market, or SMB"
    sql: ${TABLE}.segment ;;
  }

  measure: total_revenue {
    type: sum
    label: "Total Revenue"
    description: "Total gross revenue in USD"
    value_format_name: usd
    sql: ${TABLE}.gross_revenue ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue"
    description: "Total revenue minus discounts in USD"
    value_format_name: usd
    sql: ${TABLE}.gross_revenue - ${TABLE}.discount_amount ;;
  }

  measure: total_units {
    type: sum
    label: "Units Sold"
    description: "Total number of units sold"
    sql: ${TABLE}.units_sold ;;
  }
  measure: net_margin_pct {
    type: number
    label: "Net Margin %"
    description: "Net revenue divided by total gross revenue after discounts"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(${net_revenue}, ${total_revenue}) ;;
  }
}
