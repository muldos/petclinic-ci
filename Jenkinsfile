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
                sh './mvnw -B -Dcheckstyle.skip clean package -U'
                stash includes: 'target/spring-petclinic-*.jar', name: 'petclinicjar'
            }
        }
       stage('docker build') {
           environment { 
                DOCKERHUB_CREDENTIALS=credentials('dockerhub')
                JFROG_CREDENTIALS=credentials('jfrog')
            }
            steps {
                unstash 'petclinicjar'
                sh 'mv target/spring-petclinic-*.jar petclinic.jar'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'echo $JFROG_CREDENTIALS_PSW | docker login drobin.jfrog.io -u $JFROG_CREDENTIALS_USR --password-stdin'
                sh 'docker build -t muldos/petclinic:latest .'
                sh 'docker tag muldos/petclinic:latest drobin.jfrog.io/default-docker-local/petclinic:latest'
		        sh 'docker push drobin.jfrog.io/default-docker-local/petclinic:latest'
            }
        }
    }
}