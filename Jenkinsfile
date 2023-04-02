pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AKIA5537F44VGIK74H4N')
        AWS_SECRET_ACCESS_KEY = credentials('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')
        AWS_DEFAULT_REGION = 'eu-west-3'
        DOCKER_HUB_USERNAME = credentials('merazidevops')
        DOCKER_HUB_PASSWORD = credentials('petclinicapps-docker-hub-password')
        SSH_KEY = credentials('-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAhM8lvWS5Gj7isrkePxjn41ZTFuqhNuMnGSAgTo4XrGf5i1l6
PoppJSJkcXJ+c69hs7LWgVdp6xwv1ekYQ1yJVZKVhZPV/FMSUVNVEuVbF7Yxy4z5
s9MiypjUGW/QLc+alh+Ugm8rdJUIeZ0phLL2k46W6e16nLx1q0Wx8zpbVXG246ay
qsXQbgXQPxqo8XCJGCvEufsDuuZ87FiJRszrYxwDrlvfYu//zUpbrMSbaEojXDGF
FVMh0xwsainInAGTVbrufdANOgHMp/KmhB2Hh+chTbhspnBZ4fPwY1g/YnpWuBgK
5S4OuqRaQl1gS/QCsbqdjybZFP5st8gzdoIBCwIDAQABAoIBAFtm9WJTX9FgVkUK
gnaKfY1IbAbpk+piixYPtixaPpC5PlVZT3ibaaHU+avaUIzttyAlhNuffZYB4Coo
MjqqBRqPt7gm9q6hvYmbAIHwt7CqA7tDWtcYCGnGpLKc8XmV155aPatHN3EU4LBS
KbDaOjlzeQmmFyynx5QIc2AiWZmDmtE5MmF1yIS+DgP0s+/uJOdUSQrkFZtfkyDO
bZjDnIRzWoU8xb+msJrDvO3r3sO/Mg/9rja507+LPmyqWCNb5sD3Vy5LRL9lrSia
Y3qB7hIad+vj+PwbT+Lqpg8H7kkID9cKXeInleoVVOHOKnT7Yu4ZtkbDpVm2wDSB
CJj5HQECgYEAyMpE5YLAg+D1H4qYBLA5JVIdP8B4GofHPsYioPRPKkvg3m9gsjU6
oYGDG/6KrBxpQbFPEO2flvnwLWrGS3GW646Ro66jThYmteM4XQBWk6J17YSKbNVV
GfY3jiD0mMAEWl4gtOJSyLGLntWq7xKf1kq/1LmvGLTe/YSKciUlaaMCgYEAqVOp
KND55A6d+oYuO25WmgxiVk1BtHDYU6tsZ2svcazMuTiseHt2zBRy7mTkC4qM8Bx+
BoUCwxlKhUOhNsyVpJ4IvDOwrgG99S17d56gfYt9UHJLqtDmgq2PeLnRo9BgOzLb
4fkEjCIY1C0FMYvvU6uP36ADiKG2IGboC3Rn0XkCgYAmH1lDZjbdEyoXKf5A7aB7
+II7J3TmPJ9UyNOsUZZyRmPUd7sZOsf+ABP/ja2QjfhiE6MaaLNjO+MhDGPH0TJB
WRlHxZGV8ti4sgJyjeziLPdM+Fw726lDu57CqnkmQ1bQPYziKxJirmr+5jyFFbkp
O5n+bp7TBwxLgA21LF5VFwKBgFipYc3pfq+Xp8jiMZsU72vCSEuAMINXAy7sd9q/
GRygqqHhtw1vOIkru/JwCaixZ5LimGq5gvS9bXPSMbwL699CkLhbKIw0hU63/gpo
mQij3X4eGtjagZizYIiKY+cu2PSmcNQmG+d0gyO2Xx3OdAaPssoZc0A7zK2ytJYq
4aGhAoGBAMeYePpHsPIb3Sh5bAp3KzdAO7z9LP0PDXJzEu1OFYjfk/eqT+hyd4y5
qSd80vH7XtpqbbTWoaq6Fry1Wo0FiKJncHRBgvhKbAsFxYE9M1zYdHf4qO9l+gEi
NV77a4W/Wc64QmGCRVsu12nynKNKZVwuwwT6uptV34VcWYE3VYmm
-----END RSA PRIVATE KEY-----')
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
            junit 'target/surefire-reports/*.xml'
        }
    }
}
