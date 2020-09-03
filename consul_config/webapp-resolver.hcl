Kind          = "service-resolver"
Name          = "webapp"
DefaultSubset = "v1"
Subsets = {
  "v1" = {
    Filter = "Service.Meta.version == v1"
  }
  "v2" = {
    Filter = "Service.Meta.version == v2"
  }
}
Failover = {
  "*" = {
    Datacenters = ["cluster-1"]
  }
}