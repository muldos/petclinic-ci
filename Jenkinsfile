pipeline {
    agent any
    stages {
        stage('maven build') {
            agent { docker { 
                        image 'amazoncorretto:11'
                    } 
            }
            steps {
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
                sh './mvnw -B -Dcheckstyle.skip package'
            }
        }
       stage('docker build') {
           environment { 
                DOCKERHUB_CREDENTIALS=credentials('dockerhub') 
            }
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker build -t muldos/petclinic:latest .'
		        sh 'docker push muldos:latest'
            }
        }
    }
}