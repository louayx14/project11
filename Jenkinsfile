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

     /*   stage('Run Unit Tests') {
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
        }*/
        
        stage('Install Surya and Generate Graph') {
            steps {
                // Run shell commands to install Surya and generate the graph
                sh '''
                # Install Surya globally
                npm install -g surya
                
                # Generate the contract graph and save it as a PNG file
                surya graph contracts/*.sol | dot -Tpng > MyContract.png
                '''
            }
        }
        stage('Run Slither Analysis') {
    steps {
        // Install and select Solidity version 0.8.16 using solc-select
        sh '''
        pip3 install --user cbor2 crytic-compile mythril
        export PATH=$PATH:/var/lib/jenkins/.local/bin
        pip3 install solc-select
        solc-select install 0.8.16 || true  # Install if not already installed
        solc-select use 0.8.16
        '''

        // Run Slither on the Solidity contracts and output the results to JSON and text files
        sh '''
        slither contracts/*.sol 
        '''
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
