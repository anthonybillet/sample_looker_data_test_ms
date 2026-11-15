view: exec_kpi_monthly_test {
  sql_table_name: `edh-rfp-poc-0793.looker_scratch.exec_kpi_monthly_test`
    ;;

  dimension_group: report_month {
    type: time
    datatype: date
    convert_tz: no
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.report_month ;;
  }

  dimension: region {
    type: string
    description: "The geographic region for the KPI data."
    sql: ${TABLE}.region ;;
  }

  dimension: category {
    type: string
    description: "The product category for the KPI data."
    sql: ${TABLE}.category ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.total_sales ;;
    value_format_name: usd
    description: "The total sales amount for the reporting period."
  }

  measure: gross_margin_pct {
    type: number
    sql: (SUM(${TABLE}.total_sales) - SUM(${TABLE}.total_cost)) / NULLIF(SUM(${TABLE}.total_sales), 0) ;;
    value_format_name: percent_1
    description: "The gross margin percentage, calculated as (Total Sales - Total Cost) / Total Sales."
  }

  measure: order_fill_rate_pct {
    type: number
    sql: SUM(${TABLE}.orders_fulfilled) / NULLIF(SUM(${TABLE}.orders_total), 0) ;;
    value_format_name: percent_1
    description: "The percentage of orders that were successfully fulfilled."
  }

  measure: on_time_delivery_pct {
    type: number
    sql: SUM(${TABLE}.orders_on_time) / NULLIF(SUM(${TABLE}.orders_total), 0) ;;
    value_format_name: percent_1
    description: "The percentage of orders that were delivered on time."
  }

  measure: inventory_turnover {
    type: number
    sql: SUM(${TABLE}.cogs) / NULLIF(SUM(${TABLE}.avg_inventory_value), 0) ;;
    value_format_name: decimal_1
    description: "The number of times inventory is sold or used in a time period."
  }
}
