connection: "default_bigquery_connection"

include: "/ecommerce_team/*.view.lkml"

label: " Test From Scratch"

explore: order_items {
  label: "From Scratch: Order Items "
  # persist_for: "2 weeks"
  # sql_always_where: ${created_date} BETWEEN CURRENT_DATE() AND DATE('2022-01-01') ;;
  always_filter: {
    filters: [order_items.created_date: "last 30 days"]
  }

  join: users {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    #Left Join only brings in items that have been sold as order_item
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
  }

  join: derived_table {
    type: cross
    relationship: many_to_many
  }
}

access_grant: can_see_pii {
  user_attribute: employee_clearance
  allowed_values: ["secret", "top_secret"]
}

explore: taxi_trips_fact {
  label: "NYC Taxi Trips (10M+ Fact Table)"
}
explore: audited_revenue {
  label: "Audited Financial Revenue"


  join: audited_user {
    type: left_outer
    sql_on: ${audited_revenue.user_id} = ${audited_user.id} ;;
    relationship: many_to_one
  }
}


datagroup: google_trends_incremental_dg {
  label: "Google Trends Daily Incremental"
  description: "Triggers incremental PDT build when a new daily refresh_date partition arrives."
  sql_trigger:
    SELECT MAX(refresh_date)
    FROM `bigquery-public-data.google_trends.top_terms`
    WHERE refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) ;;
  max_cache_age: "24 hours"
}

explore: google_trends_pdt {
  label: "Google Trends Top Terms (Incremental PDT)"
}
