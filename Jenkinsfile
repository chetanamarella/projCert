pipeline {
  environment {
    registry = "chetana3/php"
    registryCredential = 'dockerhub'
    dockerImage = ''
    status = ''
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
    
    stage('Checking if container already exists') {
      steps{
        script {
          status = $(sh(script: "docker ps -a | grep newPhpContainer | awk -F\" \" '{print \$9}'"))
          echo "${env.status}"
        }
      }
    }
    stage('Removing container if it already exists') {
      steps{
        script {
          
          if (status == 'Up') {
            echo "it is up"
          }
          else {
            echo "no"
        
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
    
    stage('Selenium Test') {
      steps{
        sh 'java -jar test.jar'
      }
    }
  }
} 
  

