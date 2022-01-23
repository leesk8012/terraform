variable "eks_cluster_name" {
    type = string
}
variable "eks_cluster_version" {
    type = string
}
variable "eks_subnet_ids" {
    type = list
}
variable "eks_security_groups" {
    type = list
}
# variable "eks_public_access_cidrs" {
#     type = string
# }
variable "eks_network_ipv4_cidr" {
    type = string
}
variable "eks_network_ip_family" {
    type = string
    default = "ipv4"
}