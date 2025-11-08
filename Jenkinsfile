pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/MR8anem/vulnerable-demo.git', branch: 'main'
            }
        }

        stage('Setup Python') {
            steps {
                sh """
                    python3 -m venv ${VENV_DIR}
                    ./${VENV_DIR}/bin/pip install --upgrade pip
                    ./${VENV_DIR}/bin/pip install bandit semgrep
                """
            }
        }

        stage('Bandit Scan') {
            steps {
                sh """
                    mkdir -p reports/bandit
                    ./${VENV_DIR}/bin/bandit -r . -f json -o reports/bandit/bandit.json
                    ./${VENV_DIR}/bin/bandit -r . -f html -o reports/bandit/bandit.html
                    echo "Bandit reports generated at reports/bandit"
                """
            }
            post {
                always {
                    archiveArtifacts artifacts: 'reports/bandit/**', allowEmptyArchive: true
                }
            }
        }

        stage('Semgrep Scan') {
            steps {
                sh """
                    mkdir -p reports/semgrep
                    ./${VENV_DIR}/bin/semgrep --config=auto . -o reports/semgrep/semgrep.json
                    echo "Semgrep reports generated at reports/semgrep"
                """
            }
            post {
                always {
                    archiveArtifacts artifacts: 'reports/semgrep/**', allowEmptyArchive: true
                }
            }
        }

        stage('Check High Severity Findings') {
            steps {
                echo "You
