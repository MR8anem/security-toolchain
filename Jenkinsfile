pipeline {
    agent any
    stages {
        stage('Checkout'){ steps{ checkout scm } }
        stage('Setup Python'){
            steps{
                sh '''
                python3 -m venv .venv
                . .venv/bin/activate
                pip install --upgrade pip
                pip install bandit semgrep
                '''
            }
        }
        stage('Bandit Scan'){
            steps{ sh './scripts/run_bandit.sh src' }
            post{ always{ archiveArtifacts artifacts:'reports/bandit/**', fingerprint:true } }
        }
        stage('Semgrep Scan'){
            steps{ sh './scripts/run_semgrep.sh src semgrep-rules' }
            post{ always{ archiveArtifacts artifacts:'reports/semgrep/**', fingerprint:true } }
        }
        stage('Check High Severity Findings'){
            steps{ sh 'python3 ci_fail_on_findings.py' }
        }
    }
    post{
        success{ echo '✅ Security scans complete.' }
        failure{ echo '❌ High severity issues found — build failed.' }
    }
}
