pipeline {
    agent {
        label 'sasnode01'
        }
    environment {
        UserCredentials = credentials('sasadm')
        }
    stages {
        stage('Environment variables') {
            steps {
                sh """
                #!/bin/bash -xe
                echo "Execution user: " `logname`
                echo "Job name: ${env.JOB_NAME}"
                echo "Workspace name: ${env.WORKSPACE}"
                """
            }
        }
    }  
    post {
        success {
            echo 'Test pipeline'
        }
    }
}
