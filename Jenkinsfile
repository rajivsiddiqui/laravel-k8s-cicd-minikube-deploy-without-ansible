pipeline {
    agent any
    // agent {
    //     node{
    //         label "ansible"
    //     }
        
    // }

    environment {
        DOCKER_IMAGE = 'devopssteps/laravel-app'
        K8S_NAMESPACE = 'default'
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credential')
        //IMAGE_NAME = 'devopssteps/laravel-app'
        IMAGE_TAG = 'latest'
        KUBE_DEPLOYMENT_NAME = 'laravel-app'
        APP_LABEL = 'laravel'
        KUBECONFIG = "/var/lib/jenkins/kube-minikube/config"
        MINIKUBE_HOME = "/var/lib/jenkins/kube-minikube/.minikube"
    }

    stages {
        //clone git repo
        // stage('Checkout') {
        //     steps {
        //         deleteDir()
        //         checkout scm
        //     }
        // }

        stage('Clone Repo') {
            steps {
                //git branch: 'main', url: 'git@github.com:rajivsiddiqui/laravel-k8s-cicd.git'
                sh 'echo $APP_LABEL'
            }
        }
        // Build docker image
        stage('Build Docker Image') {
            steps {
                //sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
                sh 'docker build -t $DOCKER_IMAGE:$IMAGE_TAG .'
            }
        }

        stage('Login to dockerhub and push the image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                //sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                sh 'docker push $DOCKER_IMAGE:$IMAGE_TAG'

            }
        }

        //k8s steps add
        stage('deploy to kubernetes') {
            steps {
                sh './k8s/deploy.sh'
                sh 'kubectl rollout restart deployment.apps/$KUBE_DEPLOYMENT_NAME' // this force to deployment with the new docker image

            }
        }


        // stage('Deploy to Kubernetes') {
        //     steps {
        //         script {
        //             sh '''
        //                 kubectl set image deployment/$KUBE_DEPLOYMENT_NAME laravel=$DOCKER_IMAGE:$IMAGE_TAG
        //                 kubectl rollout status deployment/$KUBE_DEPLOYMENT_NAME
        //             '''
        //         }
        //     }
        // }

        // stage('Push to DockerHub') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
        //             sh """
        //                 echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        //                 docker push $DOCKER_IMAGE:$BUILD_NUMBER
        //             """
        //         }
        //     }
        // }

        // stage('Deploy to K8s via Ansible') {
        //     steps {
        //         sh 'kubectl get pods -n default'

        //         //sh 'ansible-playbook ansible/deploy.yml --extra-vars "image=$DOCKER_IMAGE:$BUILD_NUMBER"'
        //         //sh 'ansible-playbook ansible/deploy-laravel-k8s.yml'
        //         withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
        //             withEnv(["KUBECONFIG=$KUBECONFIG_FILE"]) {
        //                 sh 'ansible-playbook ansible/deploy-laravel-k8s.yml'
        //             }
        //         }


        //     }
        // }
    }


}