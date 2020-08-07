pipeline {
  environment {
    registry = "belalazzam/laravel-devops"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/belal-azzam/laravel-devops-project'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Linting PHP') {
      steps{
        sh 'docker run --rm belalazzam/laravel-devops' + ":$BUILD_NUMBER" + ' /scripts/lintphp.sh /var/www/html/app'
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
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('Deploy last image to cluster') {
      steps{
        withKubeConfig([credentialsId: 'kube-config-user-id', serverUrl: 'https://8C57813D2BA29B5C80F0D97E25597A3D.yl4.us-west-2.eks.amazonaws.com']) {
            sh 'kubectl set image -n laravel-devops deployment/laravel-dev-ops-web laravel-dev-ops-web=$registry:$BUILD_NUMBER --record'
        }
      }
    }
  }
}