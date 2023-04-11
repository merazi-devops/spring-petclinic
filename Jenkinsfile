pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "petclinic_app"
        DOCKERFILE_GITHUB_REPO = "https://github.com/merazi-devops/spring-petclinic.git"
        DOCKERFILE_GITHUB_BRANCH = "main"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.DOCKERFILE_GITHUB_BRANCH}", url: "${env.DOCKERFILE_GITHUB_REPO}"
            }
        }
        
        stage('Build image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE_NAME}:latest", "--file=./Dockerfile .")
                }
            }
        }
        stage('Run Docker') {
            steps {
                sh "docker rm -f petclinic_container || true"
                sh "docker run -d --name petclinic_container -p 80:8080 ${env.DOCKER_IMAGE_NAME}:latest"
            }
        }
        stage('Tests') {
            steps{
            echo 'Test'
            }
        
        }

    }
    post {
        always {
            sh "docker ps -a"
           
           
        }
    }
}
