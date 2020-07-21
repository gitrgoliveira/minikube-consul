Kind = "ingress-gateway"
Name = "dashboard-ingress-gateway"

TLS {
  Enabled = true
}

Listeners = [
 {
   Port = 30443
   Protocol = "http"
   Services = [
     {
        Name = "dashboard-service"
        Hosts = [ "dashboard.consul", "dashboard.consul:30443",
                  "dashboard.cluster-1.consul", "dashboard.cluster-1.consul:30443",
                  "dashboard.cluster-2.consul", "dashboard.cluster-2.consul:30443"]
     }
   ]
 }
]