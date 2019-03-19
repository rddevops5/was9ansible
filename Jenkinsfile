#!/usr/bin/env groovy

final String REGISTRY_URL = "https://fs-pcm-docker.maven.etb.tieto.com"
final String REGISTRY_CREDENTIALS = "artifactory-uploader"
final String BASE_ANSIBLE_IMAGE = "fs-pcm-docker.maven.etb.tieto.com/tieto/pcm-ansible:latest"
final String PCM_TOOLS_SETUP_IMAGE = "pcm-tools-setup-using-ansible"
final String basedir = "/ansible/playbooks"
final boolean DELIVER = (env.JOB_NAME as String).endsWith("-deliver")

node('automation') {
    docker.withRegistry(REGISTRY_URL, REGISTRY_CREDENTIALS) {

		stage('Prepare') {
			deleteDir()
			checkout scm
		}
		
		stage('Build Docker Image') {
			docker.build(PCM_TOOLS_SETUP_IMAGE)
		}
			
		def img = docker.image(PCM_TOOLS_SETUP_IMAGE)
        img.inside() { c->
				
			stage('Check Syntax') {
				echo 'Performing only syntax check'
				ansiblePlaybook(
					playbook: "${basedir}/ansible/site.yml",
					inventory: "${basedir}/ansible/inventory",
					credentialsId: 'root-generic-credentials',
					extras: '--syntax-check'
				)
			}
			
			if (DELIVER) {
				stage('pcm-tools-setup-and-configuration') {
					
					withEnv(["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_CONFIG=${basedir}/ansible/ansible.cfg"]) {
							ansiblePlaybook(
								playbook: "${basedir}/ansible/site.yml",
								inventory: "${basedir}/ansible/inventory",
								credentialsId: 'root-generic-credentials',
								extras: '-vv'
							)
					}
				}
			}
        }
    }
}
