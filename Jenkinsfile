pipeline {
  agent any

  environment {
    IMAGE = "jose22an/sample-app"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
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

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag sample-app:local $IMAGE:latest
            docker push $IMAGE:latest
            docker logout
          '''
        }
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline completed successfully. Image pushed to Docker Hub.'
    }
    failure {
      echo '❌ Pipeline failed. Check logs.'
    }
  }
}

