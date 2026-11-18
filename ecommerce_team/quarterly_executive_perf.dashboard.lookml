- dashboard: quarterly_executive_perf
  title: "Quarterly Executive Performance"
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: "Total Revenue vs Target by Quarter"
    title: "Total Revenue vs Target by Quarter"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_column
    fields: [quarterly_perf_test.quarter, quarterly_perf_test.total_revenue, quarterly_perf_test.total_target]
    sorts: [quarterly_perf_test.quarter]
    limit: 500
    row: 0
    col: 0
    width: 12
    height: 8

  - name: "Total Revenue and Gross Margin % by Region"
    title: "Total Revenue and Gross Margin % by Region"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_bar
    fields: [quarterly_perf_test.region, quarterly_perf_test.total_revenue, quarterly_perf_test.gross_margin_pct]
    sorts: [quarterly_perf_test.total_revenue desc]
    limit: 500
    row: 0
    col: 12
    width: 12
    height: 8

  - name: "Product Line Performance Summary"
    title: "Product Line Performance Summary"
    model: test_from_scratch
    explore: quarterly_perf_test
    type: looker_grid
    fields: [
      quarterly_perf_test.product_line,
      quarterly_perf_test.total_revenue,
      quarterly_perf_test.target_attainment_pct,
      quarterly_perf_test.gross_margin_pct
    ]
    sorts: [quarterly_perf_test.total_revenue desc]
    limit: 500
    row: 8
    col: 0
    width: 24
    height: 8
