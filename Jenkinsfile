pipeline {
    agent any

    environment {
        CI  = true
    }

    stages {

        stage('Build') {
            steps {
                sh 'cd frontend && npm install'
                echo 'Build not implemented.'
            }
        }

        stage('Test') {
            steps {
                sh 'cd frontend && npm test'
                echo 'Test not implemented.'
            }
        }

        stage('Deploy devl') {
            when { branch 'devl' }
            steps {
                echo 'Deploy not implemented.'
            }
        }

        stage('Deploy master') {
            when { branch 'master' }
            steps {
                echo 'Deploy not implemented.'
            }
        }

    }
}

// vim:st=4:sts=4:sw=4:expandtab:syntax=groovy
