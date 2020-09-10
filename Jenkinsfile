pipeline {
  environment {
    registry = "chetana3/php"
    registryCredential = 'dockerhub'
    dockerImage = ''
    
  }
  agent {
    label 'slave'
  }
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/chetanamarella/projCert.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    
    stage('Deploy to container') {
      steps{
        script {
          dockerImage.run('-itd --name newPhpContainer -p 8085:80')
        }
      }
    }

  }
   agent {
    label 'slave2'
  }
  stages {
    stage('Deploy to prod') {
      steps {
        script {
          dockerImage.run('-itd --name newPhpContainer2 -p 8085:80')
        }
      }
    }
  }
}


