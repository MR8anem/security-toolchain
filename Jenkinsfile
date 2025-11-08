pipeline {
    agent any

    environment {
        PYTHON_VENV = ".venv"
        SRC_DIR = "."                       // Scan the repo root
        BANDIT_REPORT_DIR = "reports/bandit"
        SEMGREP_REPORT_DIR = "reports/semgrep"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout the vulnerable-demo repo directly into workspace
                git url: 'https://github.com/MR8anem/vulnerable-demo', branch: 'main'
            }
        }

        stage('Setup Python') {
            steps {
                sh """
                    python3 -m venv ${PYTHON_VENV}
                    ./${PYTHON_VENV}/bin/pip install --upgrade pip
                    ./${PYTHON_VENV}/bin/pip install bandit semgrep
                """
            }
        }

        stage('Bandit Scan') {
            steps {
                sh """
                    mkdir -p ${BANDIT_REPORT_DIR}
                    echo "Running Bandit scan on ${SRC_DIR}..."
                    ./${PYTHON_VENV}/bin/bandit -r ${SRC_DIR} -f json -o ${BANDIT_REPORT_DIR}/bandit.json
                    ./${PYTHON_VENV}/bin/bandit -r ${SRC_DIR} -f html -o ${BANDIT_REPORT_DIR}/bandit.html
                    echo "Bandit reports generated at ${BANDIT_REPORT_DIR}"
                """
                archiveArtifacts artifacts: "${BANDIT_REPORT_DIR}/*"
            }
        }

        stage('Semgrep Scan') {
            steps {
                sh """
                    mkdir -p ${SEMGREP_REPORT_DIR}
                    echo "Running Semgrep scan on ${SRC_DIR}..."
                    set +e
                    ./${PYTHON_VENV}/bin/semgrep --config=auto ${SRC_DIR} --json > ${SEMGREP_REPORT_DIR}/semgrep.json
                    set -e
                    echo "Semgrep reports generated at ${SEMGREP_REPORT_DIR}"
                """
                archiveArtifacts artifacts: "${SEMGREP_REPORT_DIR}/*"
            }
        }

        stage('Check High Severity Findings') {
            steps {
                echo """
                Optional: Parse Bandit and Semgrep JSON reports to fail build
                if high severity issues exist.
                """
                // You can later add Python/Groovy scripts to parse 'SEVERITY.HIGH'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. All reports are archived."
        }
    }
}
