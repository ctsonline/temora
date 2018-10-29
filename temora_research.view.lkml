view: temora_research {
 view_label: "Temora Research"
  sql_table_name: com1_probes ;;

  dimension: Value{
    hidden: no
    label: "Probe Value"
    type: number
    sql: ${TABLE}.v1 ;;
    value_format_name: decimal_2
  }

  dimension_group: reading {
    type: time
    timeframes: [raw, date, time, hour_of_day]
    sql: cast(TIMESTAMPTZ(${TABLE}.t1) as timestamp);;
  }

  dimension_group: reading_8am {
    description: "A date starts from 8am of that day and ends before 8am of the following day."
    type: time
    timeframes: [date, hour, week, month, year]
    sql: DATEADD(hour,-8,${reading_raw}) ;;
  }

  dimension: name {
    label: "Long Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: area {
    type: string
    sql: split_part(${name}, '.', 2) ;;
  }

  dimension: data_type {
    type: string
    sql: split_part(${name}, '.', 3) ;;
  }

  dimension: location {
    type: string
    sql: split_part(${name}, '.', 4) ;;
  }

  dimension: Probe_Sensor {
    label: "Sensor"
    group_label: "Probe Sensor"
    type: string
    sql: split_part(${location}, ' ', 2) ;;
  }

  dimension: Probe_Sensor_Nu {
    label: "Number"
    group_label: "Probe Sensor"
    type: string
    sql: split_part(${Probe_Sensor}, '-', 1) ;;
  }

  dimension: Probe_Sensor_Depth {
    label: "Depth"
    group_label: "Probe Sensor"
    type: string
    sql: split_part(${Probe_Sensor}, '-', 2) ;;
  }


  dimension: __sheet {
    type: string
    hidden: yes
    sql: ${TABLE}.__sheet ;;
  }

  dimension_group: t1 {
    type: time
    timeframes: [raw, date, time, hour,month,week,year]
    sql: cast(TIMESTAMPTZ(${TABLE}.t1) as timestamp) ;;
    drill_fields: [t1_hour, t1_time,t1_month,t1_week,t1_year]
  }

  dimension: sensor {
    hidden: yes
    type: string
    sql: ${TABLE}.sensor ;;
  }

  dimension: sensor_depth {
    type: number
    sql: right(${sensor}, len(${sensor}) - 5) ;;
  }

  measure: average_value {
    label: "Value - Average"
    type: average
    sql: ${Value} ;;
  }

  measure: probecalc {
    label: "probe calc"
    type: number
    sql:18.13*LN(${average_value})+-41.06;;
    value_format_name: decimal_2
    drill_fields: [t1_month,average_max,average_min]
  }

  measure: average_max {
    label: "average_max"
    type: average
    sql: ${TABLE}.v1 ;;
  }


  measure: average_min {
    label: "Value - Min"
    type: min
    sql: ${TABLE}.v1 ;;
  }


  measure: count_probes {
    type: count_distinct
    sql: ${Probe_Sensor_Nu} ;;
  }

  measure: count_sensors {
    type: count_distinct
    sql: ${sensor} ;;
  }

  measure: average_sensor_per_probes {
    type: number
    sql: 1.0*${count_sensors}/NULLIF(${count_probes},0) ;;
    value_format_name: decimal_1
  }

  measure: count_readings {
    type: count
    drill_fields: [area,Probe_Sensor]
  }
}
