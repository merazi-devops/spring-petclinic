pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AKIA5537F44VGIK74H4N')
        AWS_SECRET_ACCESS_KEY = credentials('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')
        AWS_DEFAULT_REGION = 'eu-west-3'
        DOCKER_HUB_USERNAME = credentials('merazidevops')
        DOCKER_HUB_PASSWORD = credentials('petclinicapps-docker-hub-password')
        
        EC2_INSTANCE_IP = '13.37.235.113' // Remplacez par l'adresse IP publique de votre instance EC2
    }
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/merazi-devops/spring-petclinic.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Docker Build & Push') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                docker build -t petclinic .
                docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD
                docker tag petclinic $DOCKER_HUB_USERNAME/petclinic
                docker push $DOCKER_HUB_USERNAME/petclinic
                '''
            }
        }
        
        stage('Deploy to EC2') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'petclinicapps-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no -i $SSH_KEY ec2-user@$EC2_INSTANCE_IP << EOF
                    docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD
                    docker pull $DOCKER_HUB_USERNAME/petclinic
                    docker run -d -p 80:8080 $DOCKER_HUB_USERNAME/petclinic
                    EOF
                    '''
                }
            }
        }
    }
    
    post {
        always {
            node {
                junit 'reports/**/*.xml'
            }
        }
    }
}
