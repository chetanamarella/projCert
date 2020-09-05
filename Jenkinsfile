pipeline {
    def app
    
    stage('Clone repository') {
        
        checkout scm
    }
    
    stage('Build image') {
        
        app = docker.build('chetana3/phpproj')
    
    }
    
    stage('Push image') {
        docker.withRegistry('https://hub.docker.com/', '4a884472-5d21-4dea-8f0b-48ab4d7d0c24') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
    
    stage('Deploy') {
        steps {
            sh 'sudo docker run -itd --name random -p 8084:80 chetana3/phpproj'
        }
    }
    }
