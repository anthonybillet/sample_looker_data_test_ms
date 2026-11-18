view: audited_user {
  sql_table_name: bigquery-public-data.thelook_ecommerce.users ;;


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }


  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }


  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }


  measure: count {
    type: count
  }
}
