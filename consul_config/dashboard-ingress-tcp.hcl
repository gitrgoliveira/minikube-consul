Kind = "ingress-gateway"
Name = "dashboard-ingress-gateway"

TLS {
  Enabled = true
}

Listeners = [
 {
   Port = 30443
   Protocol = "tcp"
   Services = [
     {
        Name = "dashboard-service"
     }
   ]
 },
 {
   Port = 30080
   Protocol = "http"
   Services = [
     {
        Name = "webapp"
     }
   ]
 },
 {
   Port = 30088
   Protocol = "http"
   Services = [
     {
        Name = "*"
     }
   ]
 }
]