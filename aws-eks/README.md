
# 참고
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster


# 생성시 유의 사항
# 필수 요소
- name
- role-arn
- resources-vpc-config

https://docs.aws.amazon.com/cli/latest/reference/eks/create-cluster.html


# 기타
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#vpc_config
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html
https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
https://www.terraform.io/language/expressions/types