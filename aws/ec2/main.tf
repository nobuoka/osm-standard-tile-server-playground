
data "aws_iam_instance_profile" "ecs_instance_profile" {
  # This IAM Role (and IAM Instance Profile) should be created manually.
  # See : https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
  # And CloudWatchAgentServerPolicy should be attached. (for CloudWatch Agent)
  # See : https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent-commandline.html
  name = "ecsInstanceRole"
}

resource "aws_instance" "ecs_container_instance" {
  count = (var.enabled ? 1 : 0)

  # For ap-northeast-1 region
  # See : https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/launch_container_instance.html
  # See : https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
  ami = "ami-04a735b489d2a0320"
  instance_type = "t2.large"
  iam_instance_profile = data.aws_iam_instance_profile.ecs_instance_profile.name
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  monitoring = true
  disable_api_termination = false
  user_data = templatefile("${path.module}/ec2_user_data.template", {
    cluster_name = aws_ecs_cluster.main[0].name
    cloudwatch_agent_json = file("${path.module}/cloudwatch-agent.json")
  })
  tags = {
    Name = "ECS Container Instance"
  }
}
