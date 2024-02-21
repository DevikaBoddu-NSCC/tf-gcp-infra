project                         = "dev-nscc"
region                          = "us-east1"
vpc_name                        = "vpc-network"
webapp_subnet                   = "webapp"
db_subnet                       = "db"
webapp_ip_cidr_range            = "10.0.0.0/24"
db_ip_cidr_range                = "10.0.1.0/24"
auto_create_subnetworks         = false
delete_default_routes_on_create = true
dest_range                      = "0.0.0.0/0"
next_hop_gateway                = "default-internet-gateway"
route_mode                      = "REGIONAL"
webapp_route_name               = "webapp-internet-route"
webapp_vm_instance              = "webapp-instance"
zone                            = "us-east1-b"
service_account_email           = "packer-service-account@dev-nscc.iam.gserviceaccount.com"
machine_type                    = "e2-medium"
allow_http                      = "allow-http"
deny_ssh                        = "deny-ssh"
protocol                        = "tcp"
port_allow                      = ["3000"]
port_deny                       = ["22"]
source_ranges                   = ["0.0.0.0/0"]
target_tags                     = ["http-server"]
tags                            = ["http-server"]
size                            = 100
type                            = "pd-balanced"
scopes                          = ["https://www.googleapis.com/auth/cloud-platform"]
allow_ssh_from_my_ip            = "allow-ssh-from-my-ip"
image                           = "packer-1708536057"
