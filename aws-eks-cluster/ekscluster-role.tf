resource "aws_iam_role" "eks_cluster" {
  name = "ekscluster"
  description = "EKS role to access differrent services in AWS"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}