pipeline {
  agent any
  enviroment {
    IMAGE_NAME = ""
  }
  parameters {
   choice(name: 'CHOICE', choices: ['Initalize', 'Operations'], description: 'Pick something')
  }
  stages {
    stage('Choice') {
     echo "Choice: ${params.CHOICE}"
    }
   /*  stage('Initialize System') {
      when {
	expression { ${params.CHOICE}}
      }
      steps {
        try {
          sh './provision.sh'
        } catch(err) {
          echo 'Aborted Due to ${err}'
        }
      }
    } */
  }
  post {
    always {
	echo 'End of File!!!!!!!!!!!!!!'
    }
  }
}
