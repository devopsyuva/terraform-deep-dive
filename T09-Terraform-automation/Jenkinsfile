pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    stages {
        stage('Terraform Initialization') {
            steps {
                sh 'terraform init'
                sh 'pwd'
                sh 'ls -al'
                sh 'printenv'
            }
        }
        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Planning') {
            steps {
                sh 'terraform plan -no-color'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Terraform Destroy') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
---
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    stages {
        stage('Terraform Initialization') {
            steps {
                sh 'terraform init'
                sh 'pwd'
                sh 'ls -al'
                sh 'printenv'
            }
        }
        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check || exit 0' #terraform fmt -list=true -write=false -diff=true -check=true
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Planning') {
            steps {
                sh 'terraform plan -no-color'
                input message: "Approve build or Discard?"
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Terraform Destroy') {
            steps {
                sh 'terraform destroy'
                input message: "Do you want to Distory, approve or discard?"
            }
        }
    }
}
/*
def fmtStatus = sh "terraform fmt -list=true -write=false -diff=true -check=true"
if (fmtStatus == 0) {
  echo "All correct"
} else {
  echo "Changes necessary"
}
*/
/*
stage('Deploy to Production') {
    when {
        expression { 
            return params.ENVIRONMENT == 'PROD'
        }
    }
    steps {
        sh """
        echo "deploy to production"
        """
    }
}
*/