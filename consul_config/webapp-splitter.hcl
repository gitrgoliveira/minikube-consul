Kind = "service-splitter"
Name = "webapp"
Splits = [
  {
    Weight  = 100
    Service = "webapp"
    ServiceSubset = "v1"
  },
  {
    Weight  = 0
    Service = "webapp"
    ServiceSubset = "v2"
  },
]