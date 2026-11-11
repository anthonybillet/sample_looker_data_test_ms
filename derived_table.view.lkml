
view: derived_table {
  derived_table: {
    sql: {% raw %} -- generate a query combining regional tables (UNION ALL), reshaping categories (PIVOT), and cleaning strings (REGEXP_EXTRACT). Paste and run in Looker Develop > SQL Runner.
      SELECT *
      FROM
        (
          -- Let's construct a synthetic dataset simulating regional sales tables combined with UNION ALL,
          -- where we clean categories using REGEXP_EXTRACT and then reshape them using PIVOT.
          SELECT
            state,
            REGEXP_EXTRACT(category_raw, r'^[A-Za-z]+') AS clean_category,
            sales_amount
          FROM
            (
              -- Simulating North Region Sales
              SELECT
                'NY' AS state,
                'Electronics_Prod' AS category_raw,
                5000.00 AS sales_amount
              UNION ALL
              SELECT
                'NY' AS state,
                'Furniture_Prod' AS category_raw,
                3000.00 AS sales_amount
              UNION ALL
              -- Simulating South Region Sales
              SELECT
                'TX' AS state,
                'Electronics_New' AS category_raw,
                7000.00 AS sales_amount
              UNION ALL
              SELECT
                'TX' AS state,
                'Furniture_Old' AS category_raw,
                4000.00 AS sales_amount
            )
        ) PIVOT(SUM(sales_amount) FOR clean_category IN ('Electronics', 'Furniture')) {% endraw %} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: electronics {
    type: number
    sql: ${TABLE}.Electronics ;;
  }

  dimension: furniture {
    type: number
    sql: ${TABLE}.Furniture ;;
  }

  set: detail {
    fields: [
        state,
	electronics,
	furniture
    ]
  }
}
