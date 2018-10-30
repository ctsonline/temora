connection: "ctsdev"

# include all the views
include: "*.view"

datagroup: temora_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


explore: temora_sewer {
  label: "Temora Sewer"
}


explore: temora_research {
  label: "Temora Research"
}
