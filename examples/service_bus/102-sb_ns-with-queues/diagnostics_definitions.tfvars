diagnostics_definition = {
  servicebus_namespace = {
    name                           = "sb_ns_logs"
    log_analytics_destination_type = "Dedicated"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["OperationalLogs", true, true, 30],
        ["VNetAndIPFilteringLogs", true, true, 30],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 30],
      ]
    }
  }  
}
