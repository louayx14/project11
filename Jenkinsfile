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
                // The repository is already cloned by Jenkins, so this step is optional
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
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                // Run Hardhat tests
                sh 'npx hardhat test'
                }
            }
        }

        stage('Run Solidity Code Metrics') {
            steps {
                // Run solidity-code-metrics on all Solidity files in the contracts directory and generate HTML output
                sh 'solidity-code-metrics contracts/*.sol --html > metrics.html'
            }
        }

        stage('Run Slither Analysis') {
            steps {
                // Install necessary tools and set Solidity version using solc-select
                sh '''
                pip3 install --user cbor2 crytic-compile mythril
                export PATH=$PATH:/var/lib/jenkins/.local/bin
                pip3 install solc-select
                solc-select install 0.8.16 || true  # Install if not already installed
                solc-select use 0.8.16
                '''

                // Run Slither on the Solidity contracts
                sh 'slither contracts/*.sol'
            }
        }
        stage('Run Echidna Analysis') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                // Run Echidna on the Solidity contracts
                sh '''
                sh 'slither contracts/*.sol'
                

                '''
                }
            }
        }
    
    }

    post {
        always {
            // Clean workspace after the build
            cleanWs()
        }  
        success {
            echo 'All stages completed successfully!'
        }
        failure {
            echo 'Pipeline failed during one of the stages.'
        }
    }
}
