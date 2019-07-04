pipeline {
    agent {
        node {
            label 'master'
        }
    }

    parameters {
        booleanParam(name: 'reDockerImage', defaultValue: true
            description: 'Force pipeline to always build a new Docker image')
        booleanParam(name: 'awsBuild', defaultValue: true, 
            description: 'AWS resource up (if false, just docker image will be deployed on registry)')
        choice(
            name: 'deploy_color',
            choices: 'blue\ngreen',
            description: 'deploy alternative'
        )
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
            when {
                expression { params.reDockerImage == true }
            }
            steps{
                sh '''
                docker build -t node_stg:latest .
                docker images
                '''
            }
        }

        stage ('Docker Hub Publish') {
            when {
                expression { params.reDockerImage == true }
            }
            steps {
                sh '''
                docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASS
                docker push psgabriel/node:latest
                '''
            }
        }
        stage ('Terraform Init') {
            when {
                expression { params.awsBuild == true }
            }
            steps{
                dir('terraform') {
                    sh "/usr/local/bin/terraform init"
                }
            }
        }
        stage ('Terraform Plan') {
            when {
                expression { params.awsBuild == true }
            }
            steps{
                dir('terraform') {
                    sh "/usr/local/bin/terraform plan -out node_stg_${deploy_color}.plan"
                }
            }
        }
        stage ('AWS Resource build') {
            when {
                expression { params.awsBuild == true }
            }
            steps{
                dir('terraform') {
                    sh "/usr/local/bin/terraform apply node_stg_${deploy_color}"
                }
            }
        }

    }
}