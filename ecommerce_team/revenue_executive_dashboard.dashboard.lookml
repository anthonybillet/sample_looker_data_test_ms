- dashboard: revenue_executive_dashboard
  title: "Revenue Executive Dashboard"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Executive revenue performance dashboard tracking total revenue, net revenue, margins, regional trends, and customer segments."

  filters:
  - name: order_date
    title: "Order Date"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: test_from_scratch
    explore: revenue_transactions
    field: revenue_transactions.transaction_date

  - name: sales_region
    title: "Sales Region"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: test_from_scratch
    explore: revenue_transactions
    field: revenue_transactions.region

  - name: customer_segment
    title: "Customer Segment"
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: test_from_scratch
    explore: revenue_transactions
    field: revenue_transactions.segment

  elements:
  # ==========================================
  # Top KPI Row (3 Single-Value BAN Tiles)
  # ==========================================
  - name: total_revenue_kpi
    title: "Total Revenue"
    model: test_from_scratch
    explore: revenue_transactions
    type: single_value
    fields: [revenue_transactions.transaction_date, revenue_transactions.total_revenue]
    hidden_fields: [revenue_transactions.transaction_date]
    filters:
      revenue_transactions.transaction_date: 2 days
    sorts: [revenue_transactions.transaction_date desc]
    limit: 500
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 0
    col: 0
    width: 8
    height: 4

  - name: net_revenue_kpi
    title: "Net Revenue"
    model: test_from_scratch
    explore: revenue_transactions
    type: single_value
    fields: [revenue_transactions.transaction_date, revenue_transactions.net_revenue]
    hidden_fields: [revenue_transactions.transaction_date]
    filters:
      revenue_transactions.transaction_date: 2 days
    sorts: [revenue_transactions.transaction_date desc]
    limit: 500
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 0
    col: 8
    width: 8
    height: 4

  - name: net_margin_pct_kpi
    title: "Net Margin %"
    model: test_from_scratch
    explore: revenue_transactions
    type: single_value
    fields: [revenue_transactions.transaction_date, revenue_transactions.net_margin_pct]
    hidden_fields: [revenue_transactions.transaction_date]
    filters:
      revenue_transactions.transaction_date: 2 days
    sorts: [revenue_transactions.transaction_date desc]
    limit: 500
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 0
    col: 16
    width: 8
    height: 4

  # ==========================================
  # Middle Row (2 Charts Side-by-Side)
  # ==========================================
  - name: monthly_total_revenue_by_sales_region
    title: "Monthly Total Revenue by Sales Region"
    model: test_from_scratch
    explore: revenue_transactions
    type: looker_line
    fields: [revenue_transactions.transaction_month, revenue_transactions.region, revenue_transactions.total_revenue]
    pivots: [revenue_transactions.region]
    filters:
      revenue_transactions.transaction_month: 12 months
    sorts: [revenue_transactions.transaction_month asc]
    limit: 500
    interpolation: monotone
    colors: ["#1A73E8", "#E8710A", "#1E8E3E", "#9334E6"]
    series_colors:
      APAC - revenue_transactions.total_revenue: "#1A73E8"
      EMEA - revenue_transactions.total_revenue: "#E8710A"
      LATAM - revenue_transactions.total_revenue: "#1E8E3E"
      North America - revenue_transactions.total_revenue: "#9334E6"
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 4
    col: 0
    width: 12
    height: 8

  - name: revenue_and_net_margin_by_customer_segment
    title: "Revenue & Net Margin by Customer Segment"
    model: test_from_scratch
    explore: revenue_transactions
    type: looker_column
    fields: [revenue_transactions.segment, revenue_transactions.total_revenue, revenue_transactions.net_revenue]
    sorts: [revenue_transactions.total_revenue desc]
    limit: 500
    stacking: ""
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 4
    col: 12
    width: 12
    height: 8

  # ==========================================
  # Bottom Row (Full-Width Breakdown Table)
  # ==========================================
  - name: regional_and_segment_revenue_summary
    title: "Regional & Segment Revenue Summary"
    model: test_from_scratch
    explore: revenue_transactions
    type: looker_grid
    fields: [
      revenue_transactions.region,
      revenue_transactions.segment,
      revenue_transactions.total_revenue,
      revenue_transactions.net_revenue,
      revenue_transactions.net_margin_pct,
      revenue_transactions.total_units
    ]
    sorts: [revenue_transactions.total_revenue desc]
    limit: 500
    listen:
      order_date: revenue_transactions.transaction_date
      sales_region: revenue_transactions.region
      customer_segment: revenue_transactions.segment
    row: 12
    col: 0
    width: 24
    height: 8
