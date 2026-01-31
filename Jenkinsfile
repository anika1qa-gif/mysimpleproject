pipeline {
  agent any  // or 'agent { label "windows" }' if you have labels
  tools {
    // If you have configured Git and Python tools in Jenkins > Manage Jenkins > Global Tool Configuration,
    // you can reference them here. Otherwise rely on PATH.
    // git 'Default' // only if you've named a Git tool
    // python 'Python39' // if configured
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Setup Python') {
      steps {
        // Use powershell or bat, whichever you prefer
        powershell '''
          python --version
          pip --version
          if (-Not (Test-Path .venv)) { python -m venv .venv }
          .\\.venv\\Scripts\\python -m pip install --upgrade pip
          .\\.venv\\Scripts\\pip install -r requirements.txt
        '''
        // Alternatively with bat:
        // bat '''
        //   python --version
        //   pip --version
        //   if not exist .venv python -m venv .venv
        //   call .\\.venv\\Scripts\\activate
        //   python -m pip install --upgrade pip
        //   pip install -r requirements.txt
        // '''
      }
    }

    stage('Lint') {
      steps {
        powershell '.\\.venv\\Scripts\\flake8 .'
      }
    }

    stage('Test') {
      steps {
        powershell '.\\.venv\\Scripts\\pytest -q'
      }
    }

    stage('Package') {
      steps {
        powershell '.\\.venv\\Scripts\\python -m build'
      }
    }

    stage('Deploy (demo)') {
      when { expression { return false } } // replace with your condition
      steps {
        powershell 'echo Deploy step here'
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