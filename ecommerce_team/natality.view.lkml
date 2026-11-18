view: natality {
  sql_table_name: `bigquery-public-data.samples.natality` ;;

  dimension: year {
    type: number
    value_format_name: id
    sql: ${TABLE}.year ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: is_male {
    type: yesno
    sql: ${TABLE}.is_male ;;
  }
  dimension: lmp {
    type: string
    sql: ${TABLE}.lmp ;;
  }

  measure: total_births {
    type: count
  }

  measure: average_weight_pounds {
    type: average
    sql: ${TABLE}.weight_pounds ;;
    value_format_name: decimal_2
  }
}
