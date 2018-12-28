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
	build (job : 'example1')
      }
    }

    stage('Operations') {
      when {
       expression { params.CHOICE == 'Operations'}
      }
      parameter {
        choice(name: 'OPTIONS', choices: ['start', 'stop', 'clean'], description: 'Options!!!!!!')
      }
      steps {
        echo 'Operations Bhitra Ayo Hai!!!!!!!!!!!!!!!'
        build job: 'Operations', parameters: [string(name: 'OPTIONS', value: params.OPTIONS)]
      }
    }

  }
}
