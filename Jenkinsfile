pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        DOCKER_IMAGE = '211125757734.dkr.ecr.ap-south-1.amazonaws.com/semantic-demo:latest'
        NPM_TOKEN = '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'
    }
    stages {
        stage('Connect to ECR') {
            steps {
                script {
                    // Ensure the AWS CLI and Docker are properly configured on the Jenkins agent
                    sh '''
                    sudo aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | sudo docker login --username AWS --password-stdin 211125757734.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
                    sudo docker images
                    sudo docker push 211125757734.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/semantic-demo:latest
                    '''
                }
            }
        }
        stage('SCM Checkout') {
            steps {
                git branch: 'develop', url: 'https://github.com/sreddy9676/node-app.git'
            }
        }
        stage('Semantic Version') {
            steps { 
                script {
                    // Pull the docker image if it's not already available
                    sh 'sudo docker pull 211125757734.dkr.ecr.ap-south-1.amazonaws.com/semantic-demo:latest'
                    
                    // Use the Docker image to run semantic-release
                    docker.image('211125757734.dkr.ecr.ap-south-1.amazonaws.com/semantic-demo:latest').inside {
                        sh 'npx semantic-release'
                    }
                }
            }
        }                            
    }
    post {
        always {
            // Clean up Docker resources after the build
            sh 'docker system prune -f'
        }
    }
}

