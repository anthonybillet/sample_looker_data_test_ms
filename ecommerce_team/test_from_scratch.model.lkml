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
}
