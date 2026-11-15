view: order_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    description: "Unique identifier for each individual order item line."
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the order item record was created."
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the order item was delivered to the customer."
    sql: ${TABLE}.delivered_at ;;
  }
  dimension: inventory_item_id {
    type: number
    description: "Foreign key referencing the inventory stock item."
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    hidden: yes
    type: number
    description: "Internal database foreign key referencing the parent order."
    sql: ${TABLE}.order_id ;;
  }
  dimension: orderid {
    label: "Order Id"
    description: "This is the correct Order ID to use"
    synonyms: ["Order Number"]
    type: number
    sql: ${TABLE}.order_id + 10000 ;;
  }
  dimension: product_id {
    type: number
    description: "Foreign key referencing the product catalog item."
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the order item return was recorded."
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    description: "Gross price charged to the customer for the item."
    sql: ${TABLE}.SALE_PRICE ;;
  }
  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the order item was dispatched from the warehouse."
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    type: string
    description: "Current fulfillment status of the order item (e.g., Shipped, Complete, Returned, Cancelled)."
    sql: ${TABLE}.status ;;
  }
  dimension: user_id {
    type: number
    description: "Foreign key referencing the customer who placed the order."
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: total_sales {
    label: "Total Sales"
    description: "Total gross revenue from all order items before returns or cancellations."
    synonyms: ["gross revenue", "total gross revenue", "revenue"]
    value_format_name: usd
    type: sum
    sql: ${sale_price} ;;
  }
  measure: total_refunded_sales {
    value_format_name: usd
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "Returned,Cancelled"]
  }
  measure: net_revenue {
    label: "Net Revenue"
    description: "Total revenue excluding returned and cancelled items."
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "-Returned,-Cancelled"]
    value_format_name: usd
  }
  measure: returned_percent {
    value_format_name: percent_1
    type: number
    sql: 1.0*${total_refunded_sales} / NULLIF(${total_sales},0) ;;
  }
  measure: order_count {
    label: "Order Count"
    description: "Distinct count of customer orders."
    synonyms: ["number of orders", "total orders"]
    type: count_distinct
    sql: ${orderid} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name,
  products.name,
  products.id
  ]
  }

}
