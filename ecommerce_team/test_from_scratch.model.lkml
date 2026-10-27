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
}
