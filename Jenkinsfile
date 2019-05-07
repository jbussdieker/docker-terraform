#!groovy
properties([
  parameters([
    string(defaultValue: '0.11.13', description: 'Terraform Version', name: 'TerraformVersion')
  ])
])

node {
  terraformVersion = params.TerraformVersion
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
    }
  }
}
