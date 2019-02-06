pipeline {
    agent {
        docker {
            image 'node:8-alpine'
            args '-p 3000:3000'
        }
    }

    environment {
        CI               = true
        HOME             = '.'
        npm_config_cache = 'npm-cache'
    }

    stages {

        stage('Build frontend') {
            steps {
                sh 'cd frontend && npm install'
                echo 'Build not implemented.'
            }
        }

        stage('Test frontend') {
            steps {
                sh 'cd frontend && npm test'
                echo 'Test not implemented.'
            }
        }

        stage('Deploy frontend devl') {
            when { branch 'devl' }
            steps {
                echo 'Deploy not implemented.'
            }
        }

        stage('Deploy frontend master') {
            when { branch 'master' }
            steps {
                echo 'Deploy not implemented.'
            }
        }

    }
}

// vim:st=4:sts=4:sw=4:expandtab:syntax=groovy
