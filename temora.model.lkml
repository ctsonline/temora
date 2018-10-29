connection: "centratechredshift"

# include all the views
include: "*.view"

datagroup: temora_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: temora_default_datagroup

explore: temora_research{
  label: "Temora Research"
}
