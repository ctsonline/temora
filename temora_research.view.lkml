view: temora_research {
 view_label: "Temora Research"
  sql_table_name:"ctsdev" ;;


  dimension: a1 {
    group_label: "Analogs"
    type: number
    sql: ${TABLE}.a1 ;;
  }

  dimension: a2 {
    group_label: "Analogs"
    type: number
    sql: ${TABLE}.a2 ;;
  }

  dimension: a3 {
    group_label: "Analogs"
    type: number
    sql: ${TABLE}.a3 ;;
  }

  dimension: a4 {
    group_label: "Analogs"
    type: number
    sql: ${TABLE}.a4 ;;
  }

  dimension: cid {
    label: "Customer ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.cid ;;
  }

  dimension: d1 {
    group_label: "Digital"
    type: number
    sql: ${TABLE}.d1 ;;
  }

  dimension: d2 {
    group_label: "Digital"
    type: number
    sql: ${TABLE}.d2 ;;
  }

  dimension: r1 {
    group_label: "Relays"
    type: number
    sql: ${TABLE}.r1 ;;
  }

  dimension: r2 {
    group_label: "Relays"
    type: number
    sql: ${TABLE}.r2 ;;
  }

  dimension: r3 {
    group_label: "Relays"
    type: number
    sql: ${TABLE}.r3 ;;
  }

  dimension: r4 {
    group_label: "Relays"
    type: number
    sql: ${TABLE}.r4 ;;
  }

  dimension: sid {
    label: "Site ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.sid ;;
  }


  dimension_group: timestamp {
    type: time
    convert_tz: yes
    timeframes: [raw, time, time_of_day, hour_of_day,hour, date, week, month]
    sql: ${TABLE}.timestamp::timestamp;;
    drill_fields: [timestamp_date, timestamp_hour_of_day,average_value_a3]
  }

  ##dimension_group: timestamp {
  ## type: time
  ##convert_tz: yes
  ##timeframes: [raw, time, time_of_day, date, hour, week, month, minute30  ]
  ##sql: convert_timezone('AEDT','AEDT', ${TABLE}.timestamp::timestamp);;
  # }


#   2017.11.14 AD at 13:31:28 AEDT

  measure: count {
    type: count
    drill_fields: []
  }

  measure: value_a2 {
    type: date_hour
    sql: ${a1} ;;
    drill_fields: [timestamp_hour,a2,value_a2,a2,timestamp_date,timestamp_raw]
  }

  measure: average_value_a1 {
    type: max
    sql: ${a1} ;;
    drill_fields: [timestamp_hour,a2,average_value_a1,a1,timestamp_date,timestamp_raw]
  }

  measure: average_value_a2 {
    type: max
    sql: ${a2} ;;
    drill_fields: [timestamp_hour,average_value_a2,a2,timestamp_date,timestamp_raw]
  }

  measure: average_value_a3 {
    type: max
    sql: ${a3} ;;
    drill_fields: [timestamp_hour,a3,average_value_a3,timestamp_date,timestamp_raw]
  }

  measure: average_value_a4 {
    type: max
    sql: ${a4} ;;
    drill_fields: [timestamp_hour,a4,average_value_a4,timestamp_date,timestamp_raw]
  }

  }
