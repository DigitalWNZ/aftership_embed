connection: "agolis_allen_first_connection"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: aftership_embed_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: aftership_embed_default_datagroup

explore: trackings_analytics{
  # In the sql-on condition there is field from tracking_analytics and it's the left most table, so tracking analytics will always involved in join even if you only pick field from order.
  sql_always_where:
  1=1
  {% if orders.params_input_org._is_filtered %}
      and ${orders.organization_id}= {% parameter orders.params_input_org %}
  {%  endif %}
  ;;
  join: orders{
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${trackings_analytics.order_id} = ${orders.order_id}
      {% if orders.params_input_org._is_filtered %}
      and ${orders.organization_id}= {% parameter orders.params_input_org %}
      {% else %}
      and 1=1
      {% endif %}
    ;;
  }
  # dummy is for demonstration purpose only.
  # If you pick fieds from tracking_analytics and dummy, then looker will only join tracking analtyics and dummy without order because only field in order appeared in fields or conditions.
  # If you pick fields from order and dummy, tracking analytics will be involved as well because it's the left most table.
  join: dummy {
    type: cross
    relationship: many_to_one
  }
}

# If the "primary datasource" is supposed to be the first table in join and is determined by end_user, I am afraid multiple explore with different tables as the first table needs to be defined in advance.
# Even if you pick fields from tracking analytics and dummy, orders will appear in the join.
explore: dummy {
  join: trackings_analytics {
    type: cross
  }
  join: orders {
    type: cross
  }
}


explore: orders {}

explore: custom_test {}
