# The name of this view in Looker is "Trackings Analytics"
view: trackings_analytics {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: aftership_tracking.trackings_analytics ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Courier Service Type" in Explore.
  dimension: order_to_delivery {
    type: number
    sql: date_diff(first_attempted_datetime_date, ${created_date},DAY) + 1 ;;
  }

  measure: sum_order_to_delivery {
    type: sum
    sql: ${order_to_delivery} ;;
  }

  measure: avg_order_to_delivery {
    type: number
    value_format_name: decimal_1
    sql: ${sum_order_to_delivery}/${count};;
  }

  dimension: order_to_ship {
    type: number
    sql: date_diff(${scheduled_delivery_date}, ${created_date},DAY) + 1 ;;
  }

  measure: sum_order_to_ship {
    type: sum
    sql: ${order_to_pick} ;;
  }

  measure: avg_order_to_ship {
    type: number
    value_format_name: decimal_1
    sql: ${sum_order_to_ship}/${count};;
  }

  dimension: order_to_pick {
    type: number
    sql: date_diff(${shipment_pickup_datetime_date}, ${created_date},DAY) + 1 ;;
  }

  measure: sum_order_to_pick {
    type: sum
    sql: ${order_to_pick} ;;
  }

  measure: avg_order_to_pick {
    type: number
    value_format_name: decimal_1
    sql: ${sum_order_to_pick}/${count};;
  }




  dimension: courier_service_type {
    type: string
    sql: ${TABLE}.courier_service_type ;;
  }

  dimension: courier_transit_days {
    type: number
    sql: ${TABLE}.courier_transit_days ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: total_courier_transit_days {
    type: sum
    sql: ${courier_transit_days} ;;
  }

  measure: average_courier_transit_days {
    type: average
    sql: ${courier_transit_days} ;;  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: custom_fields {
    type: string
    sql: ${TABLE}.custom_fields ;;
    hidden: yes
  }

  dimension: delivery_days {
    type: number
    sql: ${TABLE}.delivery_days ;;
  }

  dimension: destination_city {
    type: string
    group_label: "Destination"
    sql: ${TABLE}.destination_city ;;
  }

  dimension: destination_country {
    type: string
    group_label: "Destination"
    sql: ${TABLE}.destination_country ;;
  }

  dimension: destination_courier_slug {
    type: string
    group_label: "Destination"
    sql: ${TABLE}.destination_courier_slug ;;
  }

  dimension: destination_state {
    type: string
    group_label: "Destination"
    sql: ${TABLE}.destination_state ;;
  }

  dimension_group: estimated_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.estimated_delivery ;;
  }

  dimension_group: first_attempted_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.first_attempted_datetime ;;
  }

  dimension: first_estimated_delivery_source {
    type: string
    sql: ${TABLE}.first_estimated_delivery_source ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.is_deleted ;;
  }

  dimension: last_mile_tracking_carrier {
    type: string
    sql: ${TABLE}.last_mile_tracking_carrier ;;
  }

  dimension: latest_status {
    type: string
    sql: ${TABLE}.latest_status ;;
  }

  dimension: latest_substatus {
    type: string
    sql: ${TABLE}.latest_substatus ;;
  }

  dimension_group: max_promised_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.max_promised_delivery ;;
  }

  dimension_group: min_promised_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.min_promised_delivery ;;
  }

  dimension: on_time_gap {
    type: number
    sql: ${TABLE}.on_time_gap ;;
  }

  dimension: on_time_status {
    type: string
    sql: ${TABLE}.on_time_status ;;
  }

  dimension_group: order {
    type: time
    group_label: "Order"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_id {
    type: string
    group_label: "Order"
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: order_promised_delivery {
    type: time
    group_label: "Order"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_promised_delivery_date ;;
  }

  dimension: origin_city {
    type: string
    group_label: "Origin"
    sql: ${TABLE}.origin_city ;;
  }

  dimension: origin_country {
    type: string
    group_label: "Origin"
    sql: ${TABLE}.origin_country ;;
  }

  dimension: origin_courier_slug {
    type: string
    group_label: "Origin"
    sql: ${TABLE}.origin_courier_slug ;;
  }

  dimension: origin_state {
    type: string
    group_label: "Origin"
    sql: ${TABLE}.origin_state ;;
  }

  dimension: return_to_sender {
    type: yesno
    sql: ${TABLE}.return_to_sender ;;
  }

  dimension_group: scheduled_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.scheduled_delivery_date ;;
  }

  dimension_group: shipment_pickup_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipment_pickup_datetime ;;
  }

  dimension: shipping_method {
    type: string
    sql: ${TABLE}.shipping_method ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension_group: specific_promised_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.specific_promised_delivery ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
  }
}
