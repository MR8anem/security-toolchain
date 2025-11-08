pipeline {
    agent any

    environment {
        REPORT_DIR = 'reports'
        VENV_DIR = '.venv'
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python') {
            steps {
                sh '''
                    python3 -m venv ${VENV_DIR}
                    ${VENV_DIR}/bin/pip install --upgrade pip
                    ${VENV_DIR}/bin/pip install bandit semgrep
                '''
            }
        }

        stage('Bandit Scan') {
            steps {
                sh '''
                    ./scripts/run_bandit.sh src
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: "${REPORT_DIR}/bandit/**", allowEmptyArchive: true
                }
            }
        }

        stage('Semgrep Scan') {
            steps {
                sh '''
                    ./scripts/run_semgrep.sh src semgrep-rules
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: "${REPORT_DIR}/semgrep/**", allowEmptyArchive: true
                }
            }
        }

        stage('Check High Severity Findings') {
            steps {
                echo "This stage can analyze reports and fail build if high severity issues exist."
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Reports are archived."
        }
        failure {
            echo "❌ Build failed due to earlier errors."
        }
    }
}
