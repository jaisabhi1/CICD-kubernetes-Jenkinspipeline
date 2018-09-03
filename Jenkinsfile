pipeline {
	agent any

    environment {
        DOCKER_IMAGE_NAME = "saviovettoor/sample_java_app"
    }
    stages {
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
