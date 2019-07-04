pipeline {
    agent {
        node {
            label 'master'
        }
    }

    parameters {
        booleanParam(name: 'AWS_BUILD', defaultValue: true, 
            description: 'AWS resource up (like terraform apply)')
        string(name: 'TERRAFORM_CLEANUP_SLEEP', defaultValue: '300', 
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
                dir('terraform') {
                    sh "/usr/local/bin/terraform init"
                }
            }
        }
        stage ('Terraform Plan') {
            when {
                expression { params.AWS_BUILD == true }
            }
            steps{
                dir('terraform') {
                    sh "terraform plan -out node_stg.plan"
                }
            }
        }
        // stage ('AWS Resource build') {
        //     when {
        //         expression { params.AWS_BUILD == true }
        //     }
        //     steps{
        //         dir('terraform') {
        //             sh "terraform terraform apply -auto-approve"
        //         }
        //     }
        // }

    }
}