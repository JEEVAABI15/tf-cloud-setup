resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0325d027fd604b49a"
  instance_type = "t2.micro"
  key_name      = "keydemo"

  tags = {
    Name = "MyCustomAMIInstance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",

      # Run Jenkins container
      "sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts",

      # Wait for Jenkins to start
      "sleep 30",

      # Fetch and print initial admin password
      "sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword",

      # Run SonarQube container
      "sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/jeeva/.ssh/keydemo.pem")  # Path to your private key
      host        = self.public_ip
    }
  }
}
