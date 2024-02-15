project= "web-project-370718"
region = "us-east1"
vpc_name = "vpc-network"
webapp_subnet = "webapp-subnet"
db_subnet ="db-subnet"
webapp_ip_cidr_range="10.0.0.0/24"
db_ip_cidr_range="10.0.1.0/24"
auto_create_subnetworks=false
delete_default_routes_on_create=true
dest_range="0.0.0.0/0"
next_hop_gateway="default-internet-gateway"
route_mode = "REGIONAL"
webapp_route_name = "webapp-internet-route"