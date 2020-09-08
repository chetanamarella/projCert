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
          status = sh(script: "docker ps -a | grep newPhpContainer | awk -F\" \" '{print \$9}'") 
        }
      }
    }
    stage('Removing container if it already exists') {
      when {
        expression {
          status == 'Up' || 'Exited'
        }
      }
    }
      steps {
        sh 'sudo docker rm newPhpContainer -f'
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
      post {
        always {
          echo "Post build task"
        }
        success {
          echo "Build was successful"
        }
        failure {
          sh 'sudo docker stop newPhpContainer'
          sh 'sudo docker rm newPhpContainer'
        }
      }
    } 
  }
}
  

