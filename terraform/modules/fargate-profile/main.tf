resource "aws_iam_role" "fargate" {
  name = "${var.project_name}-fargate-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks-fargate-pods.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_pod_execution" {
  role       = aws_iam_role.fargate.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

resource "aws_eks_fargate_profile" "worker" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = "${var.project_name}-worker-fargate"
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = "worker"
    labels = {
      "app" = "worker"
    }
  }

  tags = {
    Name        = "${var.project_name}-worker-fargate"
    Environment = var.environment
  }
}
