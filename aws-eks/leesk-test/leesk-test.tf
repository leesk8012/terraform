module "leesk-test" {
    source              = "../aws-eks"
    # EKS
    eks_cluster_name        = "leesk-test"
    eks_cluster_version     = "1.21"
    # VPC Network
    eks_subnet_ids      = [ "subnet-0000", "subnet-0000" ]
    eks_security_groups = [ "sg-1234", "sg-1234" ]
    # eks_public_access_cidrs = "11.24.141.194/32"
    # Within one of the following private IP address blocks: 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16.
    eks_network_ipv4_cidr = "10.100.0.0/16"
    eks_network_ip_family = "ipv4"
}