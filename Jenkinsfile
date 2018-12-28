pipeline {
  agent any

  stages {
    stage('Choice') {
      steps {
        echo "Choice: ${params.CHOICE} \n Check: ${param.SENSU_CHECK}"
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
      steps {
        echo 'Operations Bhitra Ayo Hai!!!!!!!!!!!!!!'
        script {
		env.OPTIONS = input message: 'Enter Operation to Perform (start | stop | clean)', ok: 'OK',
                            parameters: [choice(name: 'OPTIONS', choices: 'start\nstop\nclean', description: 'Operation to Perform?')]
        }
	echo "${env.OPTIONS}"
        build job: 'Operations', parameters: [string(name: 'OPTIONS', value: "${env.OPTIONS}")]
      }
    }

  }
}
