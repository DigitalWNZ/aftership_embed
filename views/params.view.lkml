include: "/views/**/*.view"

view: params {
  # extends: [orders]

  parameter: params_input_org {
    type: string
    suggest_dimension: orders.organization_id
  }

  parameter: aggregation_type {
    type: string
    default_value: "Please Choose Operator"
    allowed_value: {value: "sum"}
    allowed_value: {value: "avg"}
  }


  parameter: field_picker {
    type: unquoted
    allowed_value: {value: "amount"}
  }


  parameter: dim_parse_type {
    type: string
    default_value: "Please Choose Operator"
    allowed_value: {value: "substr"}
    allowed_value: {value: "regex"}
  }

  parameter: dimension_picker {
    type: unquoted
    allowed_value: {value: "order_owner_email"}
    allowed_value: {value: "amount"}
  }

  parameter: start_position {
    type: number
  }

  parameter: length {
    type: number
  }

  parameter: pattern {
    type: string
  }


  parameter: operator {
    type: string
    allowed_value: {value: "+"}
    allowed_value: {value: "-"}
  }

  parameter: factor {
    type: unquoted
  }

}
