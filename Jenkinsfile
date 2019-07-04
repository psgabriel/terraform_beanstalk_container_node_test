pipeline {
    agent {
        node {
            label 'master'
        }
    }
 
    environment {
        nodeAPPrepo="https://github.com/nodejs/nodejs.org.git"
        slackHook = credentials('SLACK_ENDPOINT')
    }
    parameters {
        booleanParam(name: 'refreshApp', defaultValue: true,
            description: 'Take a new app from repository nodeAPPrepo')
        booleanParam(name: 'reDockerImage', defaultValue: true,
            description: 'Force pipeline to always build a new Docker image')
        booleanParam(name: 'awsBuild', defaultValue: true, 
            description: 'AWS resource up (if false, just docker image will be deployed on registry)')
        booleanParam(name: 'awsDestroy', defaultValue: true, 
            description: 'All Beanstalk resources will be destroyed')
        booleanParam(name: 'slackNotification', defaultValue: true, 
            description: 'Send a message to Slack General chanell ')
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
            when {
                expression { params.refreshApp == true }
            }
            steps {
                sh '''
                rm -rf nodejs.org
                git clone ${nodeAPPrepo}
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
                    sh "/usr/local/bin/terraform apply node_stg_${deploy_color}.plan"
                }
            }
        }
        stage ('AWS Destroy') {
            when {
                expression { params.awsDestroy == true }
            }
            steps{
                dir('terraform') {
                    sh "/usr/local/bin/terraform destroy -auto-approve"
                    sh "/usr/local/bin/terraform output cname"
                }
                environment {
                    CNAME = $("/usr/local/bin/terraform output cname")
                }
            }
        }

    }
    post {
        success {
            when {
                expression { params.slackNotification == true }
            }
            echo "success"
            sh'''
            curl --connect-timeout 10 -X POST --data-urlencode 'payload={
                "attachments": [{
                    "title": "JOB '${JOB_NAME}' IS OK",
                    "color" : "good",
                    "text": "url do site ....",
                    "mrkdwn_in": ["text"]
                }
            ]}' https://hooks.slack.com/services/${slackHook}
            '''
        }
        failure {
            when {
                expression { params.slackNotification == true }
            }
            echo "failed"
            sh'''
            curl --connect-timeout 10 -X POST --data-urlencode 'payload={
                "attachments": [{
                    "title": "JOB '${JOB_NAME}' IS FAIL",
                    "color" : "danger",
                    "text": "Something is wrong. Check Jenkins Log",
                    "mrkdwn_in": ["text"]
                }
            ]}' https://hooks.slack.com/services/${slackHook}
            '''
        }
    }

}