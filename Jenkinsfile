#!groovy
latest = "0.12.0-rc1"
stable = "0.11.13"

properties([
  parameters([
    string(defaultValue: '0.11.13', description: 'Version', name: 'Version')
  ])
])

node {
  terraformVersion = params.Version
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/terraform:${terraformVersion}", "--build-arg terraform_version=${terraformVersion} .")
  }

  stage('test') {
    image.inside {
      sh "terraform version | grep ${terraformVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
      if (terraformVersion == latest)
        image.push('latest')
      else if (terraformVersion == stable)
        image.push('stable')
    }
  }
}
