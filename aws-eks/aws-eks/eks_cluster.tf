resource "aws_eks_cluster" "leesk_eks" {
  name     = "${var.eks_cluster_name}"
  role_arn = aws_iam_role.leesk-role.arn
  version  = "${var.eks_cluster_version}"

  vpc_config {
    security_group_ids = "${var.eks_security_groups}"
    subnet_ids = "${var.eks_subnet_ids}"
    endpoint_private_access = true
    endpoint_public_access = false
    # public_access_cidrs = "${var.eks_public_access_cidrs}"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.leesk-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.leesk-role-AmazonEKSVPCResourceController,
  ]

  kubernetes_network_config {
    service_ipv4_cidr = "${var.eks_network_ipv4_cidr}"
    ip_family = "${var.eks_network_ip_family}"
  }

  tags = {
    "Environment" = "staging"
    "Owner" = "leesk"
  }
}

output "endpoint" {
  value = aws_eks_cluster.leesk_eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.leesk_eks.certificate_authority[0].data
}