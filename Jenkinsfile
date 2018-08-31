pipeline {
	agent any

    environment {
        DOCKER_IMAGE_NAME = "saviovettoor/sample_java_app"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build'
		sh 'source /etc/profile.d/maven.sh'
                sh '/usr/local/maven/bin/mvn package'
                archiveArtifacts artifacts: 'target/java-tomcat-maven-example.war'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
		echo 'Creating Docker Image'
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DockerHubLogin') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'deploy_k8s_app.yml',
                    enableConfigSubstitution: true                  
                )
            }
        }
    }
}
