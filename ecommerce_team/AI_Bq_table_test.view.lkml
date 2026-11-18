view: AI_Bq_table_test {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.AI_bq_table_test` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    description: "Unique test identifier."
    sql: ${TABLE}.id ;;
  }

  dimension: test_name {
    type: string
    description: "Name of the AI/ML evaluation test."
    sql: ${TABLE}.test_name ;;
  }

  dimension: category {
    type: string
    description: "Test category domain."
    sql: ${TABLE}.category ;;
  }

  dimension: score {
    type: number
    description: "Model evaluation benchmark score."
    sql: ${TABLE}.score ;;
  }

  dimension: is_active {
    type: yesno
    description: "Active status of the test configuration."
    sql: ${TABLE}.is_active ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the record was created."
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    type: count
    description: "Total number of test records."
    drill_fields: [id, test_name, category]
  }

  measure: average_score {
    type: average
    description: "Average evaluation benchmark score."
    sql: ${score} ;;
    value_format_name: decimal_2
  }

  measure: max_score {
    type: max
    description: "Highest evaluation benchmark score."
    sql: ${score} ;;
    value_format_name: decimal_2
  }
}
