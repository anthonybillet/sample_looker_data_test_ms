view: operating_margin_fact {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.operating_margin_fact` ;;

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: week_start {
    type: time
    timeframes: [raw, date, week, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_start ;;
    description: "The start date of the fiscal reporting week."
  }

  # --- 11 Analytical Dimensions for Root-Cause Analysis ---
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    description: "Sales territory region (North, South, East, West)."
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
    description: "Fulfillment and freight delivery method used for the order."
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.sales_channel ;;
  }

  dimension: customer_segment {
    type: string
    sql: ${TABLE}.customer_segment ;;
  }

  dimension: warehouse {
    type: string
    sql: ${TABLE}.warehouse ;;
  }

  dimension: supplier_tier {
    type: string
    sql: ${TABLE}.supplier_tier ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
  }

  # --- Base Financial Measures ---
  measure: total_revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format_name: usd
  }

  measure: total_cogs {
    type: sum
    sql: ${TABLE}.cogs ;;
    value_format_name: usd
  }

  measure: total_operating_expense {
    type: sum
    sql: ${TABLE}.operating_expense ;;
    value_format_name: usd
    description: "Total operating and freight expenses."
  }

  measure: total_operating_profit {
    type: sum
    sql: ${TABLE}.operating_profit ;;
    value_format_name: usd
  }

  # --- Ratio KPI Measure (Crucial for Accurate AI Math) ---
  measure: operating_margin {
    type: number
    sql: SAFE_DIVIDE(${total_operating_profit}, ${total_revenue}) ;;
    value_format_name: percent_2
    description: "Weekly Operating Margin percentage calculated as Total Operating Profit divided by Total Revenue."
  }
}
