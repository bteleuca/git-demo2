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
        stage('Create CASlib') {
            steps {
                sh '''
                # get namespace and host
                current_namespace=gelenv
                INGRESS_SUFFIX=$(hostname -f)
                INGRESS_URL=https://${current_namespace}.${INGRESS_SUFFIX}
                echo ${INGRESS_URL}
                # get certificates (TLS support)
                export SSL_CERT_FILE=~/.certs/${current_namespace}_trustedcerts.pem
                export REQUESTS_CA_BUNDLE=${SSL_CERT_FILE}
                # go to sas-viya CLI folder
                clidir=/opt/sas/viya/home/bin
                cd $clidir
                # create a profile
                export SAS_CLI_PROFILE=${current_namespace}
                ./sas-viya --profile ${SAS_CLI_PROFILE} profile set-endpoint "${INGRESS_URL}"
                ./sas-viya --profile ${SAS_CLI_PROFILE} profile toggle-color off
                ./sas-viya --profile ${SAS_CLI_PROFILE} profile set-output fulljson
                # Login and create a token
                ./sas-viya --profile ${SAS_CLI_PROFILE} auth login -user $UserCredentials_USR -password $UserCredentials_PSW
                # Execute SAS program in batch
                cd /tmp/
                /opt/sas/viya/home/bin/sas-viya --profile ${SAS_CLI_PROFILE} batch jobs submit-pgm --pgm-path /tmp/workspace/git-demo2_main/Data-Management/scripts/050_CASlib.sas --context default --watch-output --wait-log-list --results-dir /tmp
                '''
            }
        }
    }
    post {
        success {
            echo 'Test pipeline'
        }
    }
}
