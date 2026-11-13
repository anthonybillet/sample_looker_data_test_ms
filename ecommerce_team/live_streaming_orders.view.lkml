view: live_streaming_orders {
  sql_table_name: `cnu-msi-manojkumarthokala1.edh.live_streaming_orders` ;;

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [raw, time, second, minute, hour, date]
    sql: ${TABLE}.event_timestamp ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: amount {
    type: number
    value_format_name: usd
    sql: ${TABLE}.amount ;;
  }

  measure: total_orders {
    type: count
    label: "Live Order Count"
  }

  measure: total_revenue {
    type: sum
    label: "Live Revenue"
    value_format_name: usd
    sql: ${TABLE}.amount ;;
  }

  measure: latest_event_time {
    type: date_time
    label: "Latest Event Timestamp"
    sql: MAX(${TABLE}.event_timestamp) ;;
  }
}
