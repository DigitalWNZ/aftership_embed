view: custom_test {
  sql_table_name: `agolis-allen-first.aftership_tracking.custom_test` ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  measure: count {
    type: count
    drill_fields: [name]
  }
  measure: total_rev {
    type: sum
    sql: ${revenue} ;;
  }
}
