module "leesk-test" {
    source              = "../aws-eks"
    # EKS
    cluster_name        = "leesk-test"
    cluster_version     = "1.21"
    # VPC Network
    subnet_id1          = "abcdef"
    subnet_id2          = "abcdef"
}