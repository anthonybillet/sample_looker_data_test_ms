view: dim_customers_test {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.dim_customers_test`
    ;;

  dimension: customer_id {
    primary_key: yes
    hidden: yes
    type: number
    description: "Unique identifier for each customer."
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    description: "The full name of the customer."
    sql: ${TABLE}.customer_name ;;
  }

  dimension: segment {
    type: string
    description: "The customer segment (e.g., SMB, Enterprise)."
    sql: ${TABLE}.segment ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    description: "The country where the customer is located."
    sql: ${TABLE}.country ;;
  }

  measure: count {
    type: count
    description: "The total number of customers."
  }
}
