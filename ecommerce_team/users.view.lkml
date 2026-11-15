view: users {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    description: "Unique identifier for each user."
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    description: "Age of the user in years."
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    description: "City of residence for the user."
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    description: "Country of residence for the user."
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the user account was created."
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    label: "Customer Email"
    description: "Email address of the user, masked for privacy unless PII access is granted."
    sql:
      {% if _user_attributes['can_view_pii'] == 'yes' %}
        ${TABLE}.email
      {% else %}
        CONCAT(LEFT(${TABLE}.email, 3), '***@***.com')
      {% endif %} ;;
  }
  dimension: first_name {
    type: string
    description: "First name of the user."
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    description: "Gender of the user."
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    description: "Last name or family name of the user."
    sql: ${TABLE}.last_name ;;
  }
  dimension: latitude {
    type: number
    description: "Latitude coordinate of the user's location."
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    type: number
    description: "Longitude coordinate of the user's location."
    sql: ${TABLE}.longitude ;;
  }
  dimension: postal_code {
    type: string
    description: "Postal code or ZIP code of the user's address."
    sql: ${TABLE}.postal_code ;;
  }
  dimension: state {
    type: string
    description: "State or province of the user's address."
    sql: ${TABLE}.state ;;
  }
  dimension: street_address {
    type: string
    description: "Street address of the user's residence."
    sql: ${TABLE}.street_address ;;
  }
  dimension: traffic_source {
    type: string
    description: "Marketing or referral channel through which the user signed up (e.g., Search, Organic, Facebook)."
    sql: ${TABLE}.traffic_source ;;
  }
  dimension: user_geom {
    type: string
    hidden: yes
    description: "Geographic point geometry representing the user's location."
    sql: ${TABLE}.user_geom ;;
  }
  measure: count {
    type: count
    description: "Total number of users."
    drill_fields: [id, last_name, first_name, order_items.count]
  }
  dimension: ssn_tax_id {
    type: string
    label: "SSN / Tax ID"
    required_access_grants: [can_see_pii]
    description: "Masked Social Security Number or Tax ID for the user, restricted to authorized PII viewers."
    sql: CONCAT('***-**-', LPAD(CAST(MOD(ABS(FARM_FINGERPRINT(CAST(${TABLE}.id AS STRING))), 10000) AS STRING), 4, '0')) ;;
  }
}
