pipeline {
	environment { // Set environment properties to use in docker stages
    imagename = // "DockerID/imagename"
    registryCredential =  //'credential_ID generated through Jenkins credential manager'
    dockerImage = ''
  }
	agent any
	stages {
	    stage('Checkout'){
		    steps {
			// You can generate pipeline syntax using Jenkins's pipeline generator option
		        git branch: 'branch_name', credentialsId: 'credential_id', url: 'Your repository URL'
		    }
		
		}
		stage('Build'){
		    steps {
		        //Depending upon project
				//sh 'npm run cibuild' --for Nodejs Application
		    }
		
		}
		stage('SCA using SonarQube'){
		    steps {
				script {
					scannerHome = tool 'sonarqube' //Here SonarQube scanner has been defined in global tools of Jenkins as sonarqube
				}
		        withSonarQubeEnv('SonarQube'){ //'SonarQube' name is configured in global tool of Jenkins where SonarQube server URL & auth is given
					sh "${scannerHome}/bin/sonar-scanner" // path the Sonarqube scanner executables.
				}
		    }
		
		}
		stage('Sonarqube result'){
		    steps {
				script {
					waitForQualityGate abortPipeline: true // The webhook is configured in SonarQube so that we get result of Quality gates and abort pipeline if quality gate is failed.
				}
		    }
		
		}
		stage('Building docker image'){
		    steps {
				script {
					dockerImage = docker.build imagename // build docker images using Dockerfile in repository
				}
		    }
		
		}
		stage('Deploying docker image'){
		    steps {
				script {
					docker.withRegistry( '', registryCredential ) { // By default registry is Docker Hub, but we can give our own registry if available
					dockerImage.push('latest') // Pushing Docker image to Docker hub
				}
		    }
		
		}
		}
		stage('Terraform init'){
		    steps {
				sh 'terraform init' // Initialize Terraform, it will pull the provide from provider.tf
		    }
		
		}
		stage('Terraform Apply'){
		    steps {
				sh 'terraform apply --auto-approve' // As per main.tf, Terraform will apply and create resource
		    }
		
		}
		stage('Pipeline paused for 5 minutes'){
		    steps {
				sleep time: 5, unit: 'MINUTES' // This was project specific, where pipeline has been paused for 5 mins.
		    }
		
		}
		stage('Terraform destroy'){
		    steps {
				sh 'terraform destroy --auto-approve' // After resuming, Terraform will destroy the resources.
		    }
		
		}
	}
	post { // In post action, email notification will be sent to recipients with build status (Success / Failed)
		always {
			mail to: 'shrishrimalswapnil@gmail.com', // TO_EMAIL_ID
			subject: "Status of pipeline: ${currentBuild.fullDisplayName}", // SUBJECT
			body: "${env.BUILD_URL} has result ${currentBuild.result}" // Jenkins Environment variables for build URL & result.
		}
	}
	
}
