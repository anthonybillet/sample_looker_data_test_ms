view: revenue_forecast_bqml {
  derived_table: {
    sql:
      -- Historical Actuals (Last 60 Days)
      SELECT
        DATE(transaction_date) AS forecast_date,
        region,
        SUM(gross_revenue) AS actual_revenue,
        CAST(NULL AS FLOAT64) AS predicted_revenue,
        CAST(NULL AS FLOAT64) AS lower_bound,
        CAST(NULL AS FLOAT64) AS upper_bound,
        'Actual' AS record_type
      FROM `edh-rfp-poc-0793.looker_scratch.revenue_transactions`
      WHERE DATE(transaction_date) >= DATE_SUB(CURRENT_DATE(), INTERVAL 60 DAY)
      GROUP BY 1, 2

      UNION ALL

      -- Real-Time BigQuery ML Inference via Dashboard Parameters
      SELECT
      DATE(forecast_timestamp) AS forecast_date,
      region,
      CAST(NULL AS FLOAT64) AS actual_revenue,
      forecast_value AS predicted_revenue,
      prediction_interval_lower_bound AS lower_bound,
      prediction_interval_upper_bound AS upper_bound,
      'Forecast' AS record_type
      FROM ML.FORECAST(
      MODEL `edh-rfp-poc-0793.looker_scratch.revenue_forecast_arima`,
      STRUCT(
      {% parameter forecast_horizon %} AS horizon,
      {% parameter confidence_interval %} AS confidence_level
      )
      )
      ;;
  }

  parameter: forecast_horizon {
    type: number
    label: "Forecast Horizon (Days)"
    default_value: "30"
    allowed_value: { label: "7 Days" value: "7" }
    allowed_value: { label: "14 Days" value: "14" }
    allowed_value: { label: "30 Days" value: "30" }
    allowed_value: { label: "60 Days" value: "60" }
    allowed_value: { label: "90 Days" value: "90" }
  }

  parameter: confidence_interval {
    type: number
    label: "Confidence Interval"
    default_value: "0.95"
    allowed_value: { label: "80%" value: "0.80" }
    allowed_value: { label: "90%" value: "0.90" }
    allowed_value: { label: "95%" value: "0.95" }
    allowed_value: { label: "99%" value: "0.99" }
  }

  dimension: region {
    type: string
    label: "Sales Region"
    sql: ${TABLE}.region ;;
  }

  dimension: record_type {
    type: string
    label: "Data Type"
    sql: ${TABLE}.record_type ;;
  }

  dimension_group: forecast {
    type: time
    label: "Date"
    timeframes: [raw, date, week, month]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.forecast_date ;;
  }

  measure: total_actual_revenue {
    type: sum
    label: "Actual Revenue"
    value_format_name: usd_0
    sql: ${TABLE}.actual_revenue ;;
  }

  measure: total_predicted_revenue {
    type: sum
    label: "Predicted Revenue (BQML)"
    value_format_name: usd_0
    sql: ${TABLE}.predicted_revenue ;;
  }

  measure: confidence_lower_bound {
    type: sum
    label: "Lower Confidence Bound"
    value_format_name: usd_0
    sql: ${TABLE}.lower_bound ;;
  }

  measure: confidence_upper_bound {
    type: sum
    label: "Upper Confidence Bound"
    value_format_name: usd_0
    sql: ${TABLE}.upper_bound ;;
  }
}
