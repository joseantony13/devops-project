pipeline {
  agent any
  environment {
    IMAGE = "yourdockerhubuser/sample-app"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build') {
      steps {
        sh 'docker build -t sample-app:local ./app'
      }
    }
    stage('Test') {
      steps {
        sh 'docker run --rm sample-app:local npm test || true'
      }
    }
    stage('Push') {
      steps {
        // If using Docker Hub credentials, configure Jenkins credentials and use docker login
        sh '''
          docker tag sample-app:local $IMAGE:latest
          # echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
          # docker push $IMAGE:latest
        '''
      }
    }
  }
  post {
    success { echo 'Pipeline succeeded' }
    failure { echo 'Pipeline failed' }
  }
}
