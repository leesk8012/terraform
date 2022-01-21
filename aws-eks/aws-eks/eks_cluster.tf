# resource "aws_eks_cluster" "oksusu-k8s-prd-01-cluster" {
#   name            = "${var.cluster-name}"
#   role_arn        = "${aws_iam_role.oksusu-k8s-prd-01-cluster-role.arn}"
#   version         = "1.11"

#   vpc_config {
#     security_group_ids = ["${aws_security_group.oksusu-k8s-prd-01-cluster-sg.id}"]
#     subnet_ids         = ["${aws_subnet.oksusu-k8s-DMZ-prd-01-a.id}", "${aws_subnet.oksusu-k8s-DMZ-prd-01-c.id}"]
# #    endpoint_private_access = true
# #    endpoint_public_access = false
#   }

#   depends_on = [
#     "aws_iam_role_policy_attachment.oksusu-k8s-prd-01-cluster-AmazonEKSClusterPolicy",
#     "aws_iam_role_policy_attachment.oksusu-k8s-prd-01-cluster-AmazonEKSServicePolicy",
#   ]
# }

data "aws_subnet" "subnet1" {
  id = "${var.subnet_id1}"
}

data "aws_subnet" "subnet2" {
  id = "${var.subnet_id2}"
}

resource "aws_eks_cluster" "leesk_eks" {
  name     = "${var.cluster_name}"
  role_arn = aws_iam_role.leesk-role.arn
  version  = "${var.cluster_version}"

  vpc_config {
    subnet_ids = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.leesk-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.leesk-role-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.leesk_eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.leesk_eks.certificate_authority[0].data
}