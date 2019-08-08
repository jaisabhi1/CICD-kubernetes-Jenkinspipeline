pipeline {
	agent any

    environment {
        DOCKER_IMAGE_NAME = "jaisabhi1/sample_java_app"
    }
    stages {
        stage('Build') {
	    agent {
               	docker { image 'maven:3-alpine' }
            }
            steps {
                echo 'Running build'
                sh 'mvn package'
                archiveArtifacts artifacts: 'target/java-tomcat-maven-example.war'
            }
        }
        stage('Build Docker Image') {
              steps {
		echo 'Creating Docker Image'
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DOCKER_HUB') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        
        stage('DeployToProduction') {
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'Kubeconfig',
                    configs: 'deploy_k8s_app.yml',
                    enableConfigSubstitution: true  //specify that substitute values for $ variables in deploy_k8s_app.yml file          
                )
            }
        }
    }
}
}
