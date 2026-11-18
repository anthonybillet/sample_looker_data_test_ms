- dashboard: ai_test_analysis
  title: "AI Test Analysis & Benchmarking"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Executive and operational insights for AI and ML test evaluation benchmarks."

  elements:
  - name: total_tests
    title: "Total AI Tests"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: single_value
    fields: [AI_Bq_table_test.count]
    limit: 500
    row: 0
    col: 0
    width: 8
    height: 4

  - name: average_score
    title: "Average Benchmark Score"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: single_value
    fields: [AI_Bq_table_test.average_score]
    limit: 500
    row: 0
    col: 8
    width: 8
    height: 4

  - name: max_score
    title: "Top Benchmark Score"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: single_value
    fields: [AI_Bq_table_test.max_score]
    limit: 500
    row: 0
    col: 16
    width: 8
    height: 4

  - name: score_by_test_name
    title: "Evaluation Benchmark Scores by Test"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: looker_bar
    fields: [AI_Bq_table_test.test_name, AI_Bq_table_test.score]
    sorts: [AI_Bq_table_test.score desc]
    limit: 500
    row: 4
    col: 0
    width: 14
    height: 8

  - name: category_distribution
    title: "Test Count by Category"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: looker_pie
    fields: [AI_Bq_table_test.category, AI_Bq_table_test.count]
    sorts: [AI_Bq_table_test.count desc]
    limit: 500
    row: 4
    col: 14
    width: 10
    height: 8

  - name: detailed_test_results
    title: "Detailed Test Benchmarks"
    model: test_from_scratch
    explore: AI_Bq_table_test
    type: looker_grid
    fields: [
      AI_Bq_table_test.id,
      AI_Bq_table_test.test_name,
      AI_Bq_table_test.category,
      AI_Bq_table_test.score,
      AI_Bq_table_test.is_active,
      AI_Bq_table_test.created_date
    ]
    sorts: [AI_Bq_table_test.id]
    limit: 500
    row: 12
    col: 0
    width: 24
    height: 8
