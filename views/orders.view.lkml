# The name of this view in Looker is "Orders"
include: "/views/**/*.view"

view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: aftership_tracking.orders ;;
  extends: [params]

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Amount" in Explore.

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  measure: dynamic_measure_avg {
    type: average
    sql: ${TABLE}.{% parameter field_picker %} ;;
  }

  measure: dynamic_measure_sum {
    type: sum
    sql: ${TABLE}.{% parameter field_picker %}  ;;
  }

  measure: dynamic_measure_picker {
    type: number
    label_from_parameter: aggregation_type
    sql:
    {% if aggregation_type._parameter_value == "'sum'" %}
      ${dynamic_measure_sum}
    {% else %}
      ${dynamic_measure_avg}
    {% endif %}
    ;;
  }


  dimension: substr_sample {
    type: string
    sql: substr(${TABLE}.{% parameter dimension_picker %}, {% parameter start_position %},{% parameter length %}) ;;
  }

  dimension: regex_sample {
    type: string
    sql: regexp_extract(${TABLE}.{% parameter dimension_picker %}, {% parameter pattern %}) ;;
  }

  dimension: sql_sample {
    type: string
    sql:
    {% if operator._parameter_value == "'+'" %}
        ${TABLE}.{% parameter dimension_picker %} + {% parameter factor %}
    {% else %}
      ${TABLE}.{% parameter dimension_picker %} - {% parameter factor %}
    {% endif %}
    ;;
  }

  dimension: dynamic_dimension_picker {
    type: string
    label_from_parameter: dim_parse_type
    sql:
    {% if dim_parse_type._parameter_value == "'substr'" %}
      ${substr_sample}
    {% elsif dim_parse_type._parameter_value == "'regex'" %}
      ${regex_sample}
    {% else %}
      ${sql_sample}
    {% endif %}
    ;;
  }





# Can not use parameter for measure type
  # measure: dynamic_measure {
  #   type:  {% parameter aggregation_type %}
  #   sql: {% parameter field_picker %}  ;;
  # }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;

  }

  measure: average_amount {
    type: average
    sql: ${amount} ;;

  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_created_at ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  filter: str_test {
    type: string
    suggest_dimension: order_id
    sql:  order_id in ('0001') ;;
    default_value: "('0001','0002')"
  }

  filter: str_test1 {
    type: string
    suggest_dimension: order_id
    sql:
      {% if orders.str_test1._is_filtered %}
        {% condition str_test1 %} ${order_id} {% endcondition %}
      {% else %}
        ${order_id} = concat(extract(YEAR from current_date()),"-w", extract(WEEK from current_date())) or ${order_id} = concat(extract(YEAR from date_sub(current_date(), interval 7 day)),"-w", extract(WEEK from date_sub(current_date(),interval 7 day)))
      {% endif %}
    ;;
  }

  # filter: str_test2 {
  #   type: string
  #   suggest_dimension: order_id
  #   sql:
  #     {% if _filters['orders.str_test2'] == NULL %}
  #       ${order_id} = concat("000","1")
  #     {% else %}
  #       ${order_id} = concat("000","2")
  #     {% endif %}
  #   ;;
  # }

  dimension: order_owner_email {
    type: string
    sql: ${TABLE}.order_owner_email ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organization_id ;;
  }

  dimension: tracking_id {
    type: string
    sql: ${TABLE}.tracking_id ;;
  }

  measure: count {
    type: count
  }

  measure: count_for_A {
    type: number
    sql: ${count}/2 ;;
  }

  measure: count_for_B {
    type: number
    sql: ${count}/3 ;;
  }


  # -------dsdfsd-----
  # sdfsdf


}
