pipeline {
    agent {
        node {
            label 'master'
        }
    }

    parameters {
        booleanParam(name: 'AWS_BUILD', defaultValue: true, 
            description: 'AWS resource up (if false, just docker image will be deployed on registry)')
        string(name: 'BLUE_GREEN', defaultValue: 'blue', 
            description: 'Seconds to sleep before TF destroy of all infra (if selected)')
        }

    options {
        timeout(time: 20, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Get App') {
            steps {
                sh '''
                rm -rf nodejs.org
                git clone https://github.com/nodejs/nodejs.org.git
                '''
                // deleteDir()
            }
        }
        stage('Docker Image Build') {
            steps{
                sh '''
                docker build -t node_stg:latest .
                docker images
                '''
            }
        }

        stage ('Docker Hub Publish') {
            steps {
                sh '''
                docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASS
                docker push psgabriel/node:latest
                '''
            }
        }
        stage ('Terraform Init') {
            when {
                expression { params.AWS_BUILD == true }
            }
            steps{
                dir('/tmp/terraform') {
                    sh "/usr/local/bin/terraform init"
                }
            }
        }
        stage ('Terraform Plan') {
            when {
                expression { params.AWS_BUILD == true }
            }
            steps{
                dir('/tmp/terraform') {
                    sh "chmod -R 777 *"
                    sh "/usr/local/bin/terraform plan -out node_stg_${BLUE_GREEN}.plan"
                }
            }
        }
        stage ('AWS Resource build') {
            when {
                expression { params.AWS_BUILD == true }
            }
            steps{
                dir('/tmp/terraform') {
                    sh "chmod -R 777 *"
                    sh "/usr/local/bin/terraform apply node_stg_${BLUE_GREEN} -auto-approve"
                }
            }
        }

    }
}