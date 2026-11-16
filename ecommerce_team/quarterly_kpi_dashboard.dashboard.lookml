- dashboard: quarterly_kpi_dashboard
  title: "Quarterly Performance & KPI Dashboard"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Executive overview of quarterly performance, revenue trends, target attainment, margins, and average revenue KPIs."

  filters:
  - name: quarter
    title: "Quarter"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: test_from_scratch
    explore: quarterly_perf_test
    field: quarterly_perf_test.quarter

  - name: region
    title: "Region"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: test_from_scratch
    explore: quarterly_perf_test
    field: quarterly_perf_test.region

  - name: product_line
    title: "Product Line"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: test_from_scratch
    explore: quarterly_perf_test
    field: quarterly_perf_test.product_line

  elements:
  # ==========================================
  # Top Row: KPI BAN Tiles (Single Value)
  # ==========================================
  - name: total_revenue_kpi
    title: "Total Revenue"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: single_value
    fields: [quarterly_perf_test.total_revenue]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 0
    col: 0
    width: 5
    height: 4

  - name: total_target_kpi
    title: "Total Target"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: single_value
    fields: [quarterly_perf_test.total_target]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 0
    col: 5
    width: 5
    height: 4

  - name: target_attainment_kpi
    title: "Target Attainment %"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: single_value
    fields: [quarterly_perf_test.target_attainment_pct]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 0
    col: 10
    width: 5
    height: 4

  - name: average_revenue_kpi
    title: "Average Revenue (New KPI)"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: single_value
    fields: [quarterly_perf_test.average_revenue]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 0
    col: 15
    width: 5
    height: 4

  - name: gross_margin_kpi
    title: "Gross Margin %"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: single_value
    fields: [quarterly_perf_test.gross_margin_pct]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 0
    col: 20
    width: 4
    height: 4

  # ==========================================
  # Middle Row: Quarterly Comparisons & Regional Performance
  # ==========================================
  - name: revenue_vs_target_by_quarter
    title: "Quarterly Revenue vs Target"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_column
    fields: [quarterly_perf_test.quarter, quarterly_perf_test.total_revenue, quarterly_perf_test.total_target]
    sorts: [quarterly_perf_test.quarter asc]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 4
    col: 0
    width: 12
    height: 8

  - name: regional_performance
    title: "Revenue & Gross Margin % by Region"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_column
    fields: [quarterly_perf_test.region, quarterly_perf_test.total_revenue, quarterly_perf_test.gross_margin_pct]
    sorts: [quarterly_perf_test.total_revenue desc]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 4
    col: 12
    width: 12
    height: 8

  # ==========================================
  # Third Row: Product Line Breakdown & Attainment Trend
  # ==========================================
  - name: product_line_performance
    title: "Total Revenue and Average Revenue by Product Line"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_bar
    fields: [quarterly_perf_test.product_line, quarterly_perf_test.total_revenue, quarterly_perf_test.average_revenue]
    sorts: [quarterly_perf_test.total_revenue desc]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 12
    col: 0
    width: 12
    height: 8

  - name: quarterly_attainment_trend
    title: "Quarterly Target Attainment % Trend"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_line
    fields: [quarterly_perf_test.quarter, quarterly_perf_test.target_attainment_pct]
    sorts: [quarterly_perf_test.quarter asc]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 12
    col: 12
    width: 12
    height: 8

  # ==========================================
  # Bottom Row: Detailed Tabular Grid
  # ==========================================
  - name: quarterly_performance_detail_table
    title: "Quarterly Performance Detailed Breakdown"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_grid
    fields: [
      quarterly_perf_test.quarter,
      quarterly_perf_test.region,
      quarterly_perf_test.product_line,
      quarterly_perf_test.total_revenue,
      quarterly_perf_test.total_target,
      quarterly_perf_test.average_revenue,
      quarterly_perf_test.target_attainment_pct,
      quarterly_perf_test.gross_margin_pct
    ]
    sorts: [quarterly_perf_test.quarter desc, quarterly_perf_test.total_revenue desc]
    limit: 500
    listen:
      quarter: quarterly_perf_test.quarter
      region: quarterly_perf_test.region
      product_line: quarterly_perf_test.product_line
    row: 20
    col: 0
    width: 24
    height: 8
