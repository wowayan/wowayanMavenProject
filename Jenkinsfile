pipeline {


  environment {
    //Project Configurations
    solutionName="ruby-cucumber"
    reportUrl = "http://localhost:8088/job/$env.JOB_NAME/$env.BUILD_NUMBER/cucumber-html-reports/overview-failures.html"



   //below parameters are entered in jenkins pipeline
   // parameters {

   //         string(name: 'test', defaultValue: 'api_tests', description: 'Which tests to run?')
   //         string(name: 'feature', defaultValue: 'Cart', description: 'Which feature to run?')
   //         string(name: 'browser', defaultValue: 'seleniumgrid', description: 'Which browser to use?')
   //         string(name: 'platform', defaultValue: 'mobile', description: 'Which platform to run tests?')
   //         string(name: 'environment', defaultValue: 'test', description: 'Which environment to run tests?')
   //         string(name: 'report', defaultValue: 'jenkinsreport_apitests', description: 'Which report to generate?')
   //         string(name: 'reportname', defaultValue: 'API', description: 'Which tests report to alert on slack?')

   //     }
   

  }

  agent any

  stages {
    
    stage('Building Docker image') {
      steps{
         sh "docker build -t ${solutionName}:${env.BUILD_NUMBER} ."
      }
    }


    
   stage('Run Tests') {
       steps {

            script {
              echo "Starting ${params.test} on ${params.environment} environment ${params.platform} platform with ${params.browser} browser"
              sh """docker run -v ${env.WORKSPACE}:/${solutionName} ${solutionName}:${env.BUILD_NUMBER} cucumber features/${params.test}/${params.feature}.feature -p ${params.environment} -p ${params.platform} -p ${params.browser} -p ${params.report}"""
             }

       }
   }

  }

  post {
  	     failure {

  	      echo "Test failed"
                      cucumber buildStatus: 'FAIL',
                                   failedFeaturesNumber: 1,
                                   failedScenariosNumber: 1,
                                   skippedStepsNumber: 1,
                                   failedStepsNumber: 1,
                                   fileIncludePattern: '**/*.json',
                                   sortingMethod: 'ALPHABETICAL'



  	     }

  	      success {

          echo "Test succeeded"
                     cucumber buildStatus: 'SUCCESS',
                                            failedFeaturesNumber: 0,
                                            failedScenariosNumber: 0,
                                            skippedStepsNumber: 0,
                                            failedStepsNumber: 0,
                                            fileIncludePattern: '**/*.json',
                                            sortingMethod: 'ALPHABETICAL'


          }

  }

}

