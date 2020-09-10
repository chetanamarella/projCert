pipeline {
  environment {
    registry = "chetana3/php"
    registryCredential = 'dockerhub'
    dockerImage = ''
    status =  " "
    
  }
  agent none
  stages {
    stage('Cloning Git') {
      agent {label 'slave'}
      steps {
        git 'https://github.com/chetanamarella/projCert.git'
      }
    }
    stage('Building image') {
      agent {label 'slave'}
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      agent {label 'slave'}
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Check if container is already exists') {
      agent {label 'slave'}
      steps{
        script {
          status = $(docker container inspect -f='{{.State.Status}}' newPhpContainer)
          echo ${status}
        }
      }
    }

    
    
    stage('Deploy to container') {
      agent {label 'slave'}
      steps{
        script {
          dockerImage.run('-itd --name newPhpContainer -p 8085:80')
        }
      }
    }
   
  }
}


