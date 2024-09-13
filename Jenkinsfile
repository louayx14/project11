pipeline {
    agent any

    environment {
        NODE_HOME = '/usr/local/bin'
        PATH = "${env.NODE_HOME}:${env.PATH}"
        LOCAL_DIR = 'unit test + metric'  // Ensure LOCAL_DIR is defined
    }

    stages {
        stage('Clone Repository') {
            steps {
                // The repository is already cloned by Jenkins, so this is optional
                git url: 'https://github.com/louayx14/project11.git', branch: 'master'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install npm dependencies
                sh 'npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                // Run Hardhat tests
                sh 'npx hardhat test'
            }
        }

        stage('Run Solidity Code Metrics') {
            steps {
                        // Run solidity-code-metrics on all Solidity files in the contracts directory
                        sh "solidity-code-metrics contracts/*.sol --html > ../metrics.html"
                    }
        }
        stage('Run Slither Analysis') {
            steps {
                // Install Slither (if needed) and run it on the Solidity contracts
                sh "solc-select use 0.8.16"
                sh """
                slither contracts/*.sol --json slither-report.json > slither-report.txt
                """
            }
        }
    }

    post {
        always {
            // Clean workspace after build
            cleanWs()
        }  
        success {
            echo 'Unit tests passed!'
        }
        failure {
            echo 'Unit tests failed!'
        }
    }
}
