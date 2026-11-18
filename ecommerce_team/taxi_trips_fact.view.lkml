view: taxi_trips_fact {
  sql_table_name: `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022` ;;

  dimension: vendor_id {
    type: string
    sql: ${TABLE}.vendor_id ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
  }

  dimension_group: pickup {
    type: time
    timeframes: [raw, time, date, week, month, year]
    sql: ${TABLE}.pickup_datetime ;;
  }

  dimension: passenger_count {
    type: number
    sql: ${TABLE}.passenger_count ;;
  }

  measure: total_trips {
    type: count
  }

  measure: total_fare_amount {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.fare_amount ;;
  }

  measure: average_trip_distance {
    type: average
    value_format_name: decimal_2
    sql: ${TABLE}.trip_distance * 100 ;;
  }
}
