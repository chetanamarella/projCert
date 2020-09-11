pipeline {
  environment {
    registry = "chetana3/php"
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
        sh '''#!/bin/bash

                x=$( docker container inspect -f '{{.State.Status}}' newPhpContainer )
                echo $x

                if [ $x == "running" ]
                then
                        echo "yes run"
                fi

                if [ $x == "exited" ]
                then
                        echo "no run"
                fi
                
                '''
          
       
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


