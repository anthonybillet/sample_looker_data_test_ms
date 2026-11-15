view: sales_conversational_test {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.sales_conversational_test`
    ;;

  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
    description: "Unique identifier for each order."
    sql: ${TABLE}.order_id ;;
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
    description: "The date the order was placed."
    sql: ${TABLE}.order_date ;;
  }

  dimension: region {
    type: string
    description: "The sales region."
    sql: ${TABLE}.region ;;
  }

  dimension: customer_account {
    type: string
    description: "The customer's account name."
    sql: ${TABLE}.customer_account ;;
  }

  dimension: sales_rep {
    type: string
    description: "The sales representative for the account."
    sql: ${TABLE}.sales_rep ;;
  }

  measure: count {
    type: count
    description: "The total number of sales."
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.sales_amount ;;
    value_format_name: usd
    description: "The total sales amount."
  }

  measure: total_cost {
    type: sum
    sql: ${TABLE}.cost_amount ;;
    value_format_name: usd
    hidden: yes
    description: "The total cost of goods sold."
  }

  measure: profit_margin {
    type: number
    sql: (${total_sales} - ${total_cost}) / NULLIF(${total_sales}, 0) ;;
    value_format_name: percent_1
    description: "The profit margin on sales."
  }
}
