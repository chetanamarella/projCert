pipeline {
  environment {
    registry = "chetana3/project"
    registryCredential = 'dockerhub'
    dockerImage = ''
    
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
          sh 'whoami'
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Pushing Image') {
      agent {label 'slave'}
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Removing container if it already exists') {
      agent {label 'slave'}
      steps{
        sh '''#!/bin/bash
                x=$( docker container inspect -f '{{.State.Status}}' newPhpContainer )
                echo $x
                if [ $x == "running" ]
                then
                        sudo docker stop newPhpContainer
                        sudo docker rm newPhpContainer
                elif [ $x == "exited" ]
                then
                        sudo docker rm newPhpContainer
                        
                else
                        echo "Container does not exist"
                fi
                
                '''
          
       
      }
    }

    
    stage('Deploying to test server') {
      agent {label 'slave'}
      steps{
        script {
          dockerImage.run('-itd --name newPhpContainer -p 8085:80')
        }
      }
    }
    
     stage('Selenium Test') {
       agent {label 'slave'}
       steps{
         sh 'java -jar test.jar'
       }
       post {
         always {
           echo "Post build task"
         }
         success {
           echo "Test was successful"
         }
         failure {
           sh 'sudo docker stop newPhpContainer'
           sh 'sudo docker rm newPhpContainer'
         }
       }
     }
   
  }
}
