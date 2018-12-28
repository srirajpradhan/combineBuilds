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
      steps {
        echo 'Operations Bhitra Ayo Hai!!!!!!!!!!!!!!'
	def OPTIONS = input(
        	id: 'Options', message: 'Input Operation to Perform (start | stop | clean) ', ok: 'OK', parameters: [string(defaultValue: 'start', description: 'Enter Options!!!', name: 'OPTIONS')]
	)
        build job: 'Operations', parameters: [string(name: 'OPTIONS', value: '$OPTIONS')]
      }
    }

  }
}
