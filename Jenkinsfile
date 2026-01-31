pipeline {
  agent any // or: agent { label 'windows' }

  options {
    timestamps()
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Setup Python') {
      steps {
        // PowerShell version
        powershell '''
          $ErrorActionPreference = "Stop"

          python --version
          pip --version

          if (-Not (Test-Path ".venv")) {
            python -m venv .venv
          }

          .\\.venv\\Scripts\\python -m pip install --upgrade pip

          if (Test-Path "requirements.txt") {
            .\\.venv\\Scripts\\pip install -r requirements.txt
          }
        '''

        // Or use bat (uncomment if you prefer cmd.exe)
        // bat '''
        //   python --version
        //   pip --version
        //   if not exist .venv python -m venv .venv
        //   call .\\.venv\\Scripts\\activate
        //   python -m pip install --upgrade pip
        //   if exist requirements.txt pip install -r requirements.txt
        // '''
      }
    }

    stage('Lint') {
      steps {
        powershell '.\\.venv\\Scripts\\flake8 .'
        // bat '.\\.venv\\Scripts\\flake8 .'
      }
    }

    stage('Test') {
      steps {
        // If you produce JUnit XML, add --junitxml=report.xml and publish in post{}
        powershell '.\\.venv\\Scripts\\pytest -q'
        // bat '.\\.venv\\Scripts\\pytest -q'
      }
    }

    stage('Package') {
      steps {
        powershell '.\\.venv\\Scripts\\python -m build'
        // bat '.\\.venv\\Scripts\\python -m build'
      }
    }

    stage('Deploy (demo)') {
      when { expression { false } } // change this to your real condition
      steps {
        powershell 'echo "Deploy step here"'
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
      junit testResults: '**/junit-*.xml', allowEmptyResults: true
    }
  }
}