- dashboard: sales_conversational_test_dashboard
  title: "Sales Conversational Test Dashboard"
  layout: tile
  tile_size: 100

  elements:
  - name: total_sales
    title: "Total Sales"
    model: test_from_scratch
    explore: sales_conversational_test_2
    type: single_value
    fields: [sales_conversational_test_2.total_sales]
    limit: 1

  - name: total_orders
    title: "Total Orders"
    model: test_from_scratch
    explore: sales_conversational_test_2
    type: single_value
    fields: [sales_conversational_test_2.count]
    limit: 1

  - name: profit_margin
    title: "Profit Margin"
    model: test_from_scratch
    explore: sales_conversational_test_2
    type: single_value
    fields: [sales_conversational_test_2.profit_margin]
    limit: 1

  - name: sales_over_time
    title: "Sales Over Time"
    model: test_from_scratch
    explore: sales_conversational_test_2
    type: line
    fields: [sales_conversational_test_2.total_sales, sales_conversational_test_2.order_month]
    sorts: [sales_conversational_test_2.order_month]

  - name: sales_by_region
    title: "Sales by Region"
    model: test_from_scratch
    explore: sales_conversational_test_2
    type: bar
    fields: [sales_conversational_test_2.total_sales, sales_conversational_test_2.region]
    sorts: ["sales_conversational_test_2.total_sales desc"]
