pipeline {
  agent any
  options { timestamps() }

  parameters {
    choice(name: 'TARGET_ENV', choices: ['dev','qa','staging','prod'], description: 'Deployment target (demo only)')
    choice(name: 'TEST_SUITE', choices: ['smoke','regression','all'], description: 'Which test suite to run')
    booleanParam(name: 'APPROVED', defaultValue: false, description: 'Required to deploy to prod')
  }

  environment {
    PIP_CACHE_DIR = "${WORKSPACE}/.pip-cache"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Setup Python') {
      steps {
        sh 'python3 --version || python --version'
        sh 'python3 -m pip install --upgrade pip || true'
        sh 'python3 -m pip install -r requirements.txt || pip install -r requirements.txt'
      }
    }

    stage('Lint') {
      steps { sh 'flake8 src tests' }
    }

    stage('Test') {
      steps {
        sh 'chmod +x scripts/run_tests.sh && TEST_SUITE=${TEST_SUITE} bash scripts/run_tests.sh'
      }
      post {
        always {
          junit 'results/junit.xml'
          archiveArtifacts artifacts: 'results/**', fingerprint: true, onlyIfSuccessful: false
        }
      }
    }

    stage('Package') {
      steps { sh 'chmod +x scripts/package.sh && bash scripts/package.sh' }
      post {
        success { archiveArtifacts artifacts: 'dist/**', fingerprint: true }
      }
    }

    stage('Deploy (demo)') {
      when { expression { return params.TARGET_ENV != 'dev' } }
      steps {
        script {
          if (params.TARGET_ENV == 'prod' && !params.APPROVED) {
            error 'Refusing to deploy to PROD without APPROVED=true'
          }
          echo "Simulating deploy to ${params.TARGET_ENV}..."
          sh 'sleep 1'
        }
      }
    }
  }
}
