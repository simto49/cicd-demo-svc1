#!/usr/bin/env groovy

node {
    def containerRegistry = "df4498b6-kr1-registry.container.cloud.toast.com"
    def containerImageName = "demo-svc1"
    
    def commitId
    stage("git clone application-source") {
        deleteDir()
        git credentialsId: 'kst-github', url: 'https://github.nhnent.com/toast-cloud-deploy/cicd-demo-svc1.git'
        commitId = sh(returnStdout: true, script: "git show -s --format=%h")
    }
    stage("build&register container image") {
        docker.withRegistry("https://${containerRegistry}", "kst-docker") {
            sh """CONTAINER_IMAGE=${containerRegistry}/${containerImageName}
                CONTAINER_IMAGE_TAG=${commitId}
                docker build -t \$CONTAINER_IMAGE:\$CONTAINER_IMAGE_TAG .
                docker tag \$CONTAINER_IMAGE:\$CONTAINER_IMAGE_TAG \$CONTAINER_IMAGE:latest
                docker push \$CONTAINER_IMAGE:\$CONTAINER_IMAGE_TAG
                docker push \$CONTAINER_IMAGE:latest
                docker rmi \$CONTAINER_IMAGE:\$CONTAINER_IMAGE_TAG
                docker rmi \$CONTAINER_IMAGE:latest"""              
        }        
    }
}

