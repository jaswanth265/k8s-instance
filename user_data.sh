   #!/bin/bash
        sudo su -
        sudo ssh-keygen
        sudo cd /usr/local/bin/
        sudo wget https://github.com/kubernetes/kops/releases/download/v1.28.0/kops-linux-amd64
        sudo mv kops-linux-amd64 kops
        sudo chmod 777 kops
        sudo curl -LO https://dl.k8s.io/release/v1.29.1/bin/linux/amd64/kubectl
        sudo chmod 777 kubectl
