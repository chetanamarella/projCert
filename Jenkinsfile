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
    stage('Deploy Image') {
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
          dockerImage.withRun('-itd --name newPhpContainer -p 8085:80')
        }
      }
    } 
    
  }
}
