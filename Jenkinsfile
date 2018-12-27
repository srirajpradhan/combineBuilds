pipeline {
  agent any

  parameters {
   choice(name: 'CHOICE', choices: ['Initialize', 'Operations'], description: 'Pick something')
  }

  stages {
    stage('Choice') {
      steps {
        echo "Choice: ${params.CHOICE}"
      }
    }

    stage('Initialize System') {
      when {
	expression { params.CHOICE == 'Initialize'}
      }
      steps {
	echo 'Initialize Bhitra Ayo!!!!!!!!!!'
	build (job : 'Provision')
      }
    }

  }
  post {
    always {
	echo 'End of File!!!!!!!!!!!!!!'
    }
  }
}
