pipeline {
    agent {
     node {
         label "laravel"
     }
 }
  stages {
        stage('checkout') {
              steps {
                  git branch: 'main', url: 'https://github.com/devopssteps/laravel2025.git'
              }
        }
        //Build stage
          stage('Build') {
            steps {
                sh 'composer install'
                sh 'npm install'
                sh 'npm run build'
                // if we need any other commands to compile
            }
         }
        //Test stage
        stage('Test') {
            steps {
                sh 'php artisan test'
            }
        }
        // deploy to staging 
        stage('Deploy to stgaing') {

            steps {
                sh 'ssh ubuntu@54.242.14.213 -o StrictHostKeyChecking=no "bash /var/www/larademo/scripts/deploy.sh" '
            }
        } 
        // deploy to production server 
        stage('Deploy to production') {
            input {
                message "Want to deploy to production"
                ok "Yes"
            }

            steps {
                sh 'ssh ubuntu@50.19.206.170 -o StrictHostKeyChecking=no "bash /var/www/larademo/scripts/deploy.sh" '
            }
        }  
   }
   post {
     // send email notification the specicied addresses if the build fails
        failure {  
             mail bcc: '', body: "<b>Failed Jenkins Build</b><br>Project: ${env.JOB_NAME} \
             <br>Build Number: ${env.BUILD_NUMBER} <br> URL of the build: ${env.BUILD_URL}", cc: '', \
             charset: 'UTF-8', from: 'rajiv19831@gmail.com', mimeType: 'text/html', replyTo: 'rajiv19831@gmail.com', \
             subject: "ERROR CI: Project name -> ${env.JOB_NAME}", \
             to: "rajiv19831@gmail.com";  \
        }
        // send email notification the specicied addresses if the build fails
        success {  
             mail bcc: '', body: "<b>Success Jenkins Build</b><br>Project: ${env.JOB_NAME} \
             <br>Build Number: ${env.BUILD_NUMBER} <br> URL of the build: ${env.BUILD_URL}", cc: '', \
             charset: 'UTF-8', from: 'rajiv19831@gmail.com', mimeType: 'text/html', replyTo: 'rajiv19831@gmail.com', \
             subject: "SUCCESS CI: Project name -> ${env.JOB_NAME}", \
             to: "rajiv19831@gmail.com";  \
         } 
 
    }

}
