pipeline {
    agent {
        node {
            label 'master'
        }
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

    }
}