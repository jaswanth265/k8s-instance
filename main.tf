# resource "ec2" "k8s" {
#     ami                             = var.ami
#     instance_type                   = var.instance_type
#     ebs_volume                      = var.ebs_volume
#     availability_zone               = var.availability_zone
#     key_pair                        = var.key_pair
#     user_data                       = var.user_data
#     associate_public_ip_address     = var.associate_public_ip_address
#     iam_instance_profile            = var.iam_instance_profile
#     volume_type                     = var.volume_type
  
# }



resource "aws_instance" "k8s" {
    ami                         = var.ami_id
    availability_zone           = var.availability_zone
    instance_type               = var.instance_type
    key_name                    = var.key_name
    subnet_id                   = aws_subnet.public-subnet.id
    vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = var.associate_public_ip_address
    user_data                   = "{./user_data.sh}"
    tags = {
        Name = var.environment
    }
    root_block_device {
        volume_size           = "15"
        volume_type           = "gp2"
        delete_on_termination = "true"
    }
}