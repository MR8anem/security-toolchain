pipeline {
    agent any

    environment {
        VENV = "${WORKSPACE}/.venv"
        PYTHON = "${VENV}/bin/python3"
        PIP = "${VENV}/bin/pip"
        SEMGREP = "${VENV}/bin/semgrep"
        BANDIT = "${VENV}/bin/bandit"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python') {
            steps {
                sh """
                    python3 -m venv ${VENV}
                    source ${VENV}/bin/activate
                    ${PIP} install --upgrade pip
                    ${PIP} install bandit semgrep
                """
            }
        }

        stage('Bandit Scan') {
            steps {
                sh """
                    ./scripts/run_bandit.sh src
                """
                archiveArtifacts artifacts: 'reports/bandit/*', allowEmptyArchive: true
            }
        }

        stage('Semgrep Scan') {
            steps {
                sh """
                    ./scripts/run_semgrep.sh src semgrep-rules
                """
                archiveArtifacts artifacts: 'reports/semgrep/*', allowEmptyArchive: true
            }
        }

        stage('Check High Severity Findings') {
            steps {
                sh """
                    python3 ci_fail_on_findings.py reports/bandit/bandit.json reports/semgrep/semgrep.json || true
                """
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Reports are archived."
        }
    }
}
