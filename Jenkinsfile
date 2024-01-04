pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t shenukacj/learners-api .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push shenukacj/learners-api'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}


// // ==================================================================

// node {
//     def app

//     stage('Clone repository') {
//         /* Let's make sure we have the repository cloned to our workspace */

//         checkout scm
//     }

//     stage('Initialize'){
//         def dockerHome = tool 'myDocker'
//         env.PATH = "${dockerHome}/bin:${env.PATH}"
//     }


//     stage('Build image') {
//         /* This builds the actual image; synonymous to
//          * docker build on the command line */

//         app = docker.build("paddymcbreen/backend-jenkins")
//     }

//     stage('Test image') {
//         /* Ideally, we would run a test framework against our image.
//          * For this example, we're using a Volkswagen-type approach ;-) */

//         app.inside {
//             sh 'echo "Tests passed"'
//         }
//     }

//     stage('Push image') {
//         /* Finally, we'll push the image with two tags:
//          * First, the incremental build number from Jenkins
//          * Second, the 'latest' tag.
//          * Pushing multiple tags is cheap, as all the layers are reused. */
//         docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
//             app.push("${env.BUILD_NUMBER}")
//             app.push("latest")
//         }
//     }
// }