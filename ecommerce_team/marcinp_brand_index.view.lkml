view: marcinp_brand_index {
  # Inline lookup table mapping the 10 brands from your Explore to your 5-point scale
  derived_table: {
    sql:
      SELECT 'Calvin Klein' AS brand, 'i like' AS brand_experience, 4 AS experience_score UNION ALL
      SELECT 'Diesel' AS brand, 'i love' AS brand_experience, 5 AS experience_score UNION ALL
      SELECT 'True Religion' AS brand, 'i do not like' AS brand_experience, 2 AS experience_score UNION ALL
      SELECT 'Carhartt' AS brand, 'i love' AS brand_experience, 5 AS experience_score UNION ALL
      SELECT '7 For All Mankind' AS brand, 'is ok' AS brand_experience, 3 AS experience_score UNION ALL
      SELECT 'Tommy Hilfiger' AS brand, 'i like' AS brand_experience, 4 AS experience_score UNION ALL
      SELECT 'Volcom' AS brand, 'i hate' AS brand_experience, 1 AS experience_score UNION ALL
      SELECT 'The North Face' AS brand, 'i love' AS brand_experience, 5 AS experience_score UNION ALL
      SELECT 'Quiksilver' AS brand, 'is ok' AS brand_experience, 3 AS experience_score UNION ALL
      SELECT 'Columbia' AS brand, 'i like' AS brand_experience, 4 AS experience_score
    ;;
  }

  # Primary key is mandatory so Looker knows each brand appears only once in this view
  dimension: brand {
    primary_key: yes
    type: string
    sql: ${TABLE}.brand ;;
  }

  # Your 5-point qualitative rating
  dimension: brand_experience {
    type: string
    label: "Marcin's Brand Experience"
    # Order by the numeric score so tables/charts sort from 'i love' down to 'i hate' instead of alphabetically
    order_by_field: experience_score
    sql: ${TABLE}.brand_experience ;;
  }

  # Optional numeric score (1–5) for sorting or calculating average brand sentiment
  dimension: experience_score {
    hidden: yes
    type: number
    sql: ${TABLE}.experience_score ;;
  }

  measure: average_brand_score {
    type: average
    value_format_name: decimal_1
    sql: ${experience_score} ;;
  }
}
