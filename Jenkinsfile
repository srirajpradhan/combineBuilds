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
	expression { ${params.CHOICE} == 'Initialize'}
      }
      steps {
        try {
          build(
            job: 'job/example1',
          )
        } catch(err) {
          echo 'Aborted Due to ${err}'
        }
      }
    }

  }
  post {
    always {
	echo 'End of File!!!!!!!!!!!!!!'
    }
  }
}
