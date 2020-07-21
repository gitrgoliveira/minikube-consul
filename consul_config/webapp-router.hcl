Kind = "service-router"
Name = "webapp"
Routes = [
  {
    Match {
      HTTP {
        QueryParam = [
          {
            Name  = "x-debug"
            Present = "True"
          },
        ]
      }
    }
    Destination {
      Service = "webapp"
      ServiceSubset = "v2"
    }
  }
]