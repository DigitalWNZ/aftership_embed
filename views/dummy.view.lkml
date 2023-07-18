view: dummy {
  derived_table: {
    sql: select 1 as dummy ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dummy {
    type: number
    sql: ${TABLE}.dummy ;;
  }

  set: detail {
    fields: [
      dummy
    ]
  }
}
