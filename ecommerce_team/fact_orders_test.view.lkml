view: fact_orders_test {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.fact_orders_test`
    ;;

  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
    description: "Unique identifier for each order."
    sql: ${TABLE}.order_id ;;
  }

  dimension: customer_id {
    hidden: yes
    type: number
    description: "Foreign key referencing the customer dimension."
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "The date and time the order was placed."
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_status {
    type: string
    description: "The current status of the order (e.g., Shipped, Pending, Cancelled)."
    sql: ${TABLE}.order_status ;;
  }

  dimension: order_amount {
    type: number
    description: "The total amount of the order."
    sql: ${TABLE}.order_amount ;;
  }

  measure: count {
    type: count
    description: "The total number of orders."
  }

  measure: total_order_amount {
    type: sum
    sql: ${order_amount}
    value_format_name: usd
    description: "The total value of all orders."
    ;;
  }

  measure: average_order_amount {
    type: average
    sql: ${order_amount}
    value_format_name: usd
    description: "The average value of an order."
    ;;
  }
}
