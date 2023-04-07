pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "petclinic_app"
        DOCKERFILE_GITHUB_REPO = "https://github.com/Amioss/spring-petclinic.git"
        DOCKERFILE_GITHUB_BRANCH = "main"
        JMETER_TEST_PLAN = "/src/test/jmeter/petclinic_test_plan.jmx"
        JMETER_RESULTS = "test_results.jtl"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.DOCKERFILE_GITHUB_BRANCH}", url: "${env.DOCKERFILE_GITHUB_REPO}"
            }
        }
        
        stage('Build Docker image') {
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
        stage('execute Performance Tests') {
            steps{
            sh '/etc/apache-jmeter-5.4.1/bin/jmeter.sh -n -t /spring-petclinic/src/test/jmeter/petclinic_test_plan.jmx -l test.jml'
            }
        
        }

    }
    post {
        always {
            sh "docker ps -a"
            sh "docker logs petclinic_container"
            sh "docker cp petclinic_container:${env.JMETER_RESULTS} ${env.JMETER_RESULTS}"
        }
    }
}
