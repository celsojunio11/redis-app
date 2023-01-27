pipeline {
          agent any
          stages { 
                    stage('Build da imagem docker'){
                              steps{
                                        sh 'docker build -t devops/app .'
                              }
                    }
                    stage('Subir docker compose - redis e app'){
                              steps{
                                        sh 'docker-compose up --build -d'
                              }
                    }
                    stage('Sleep para subida de container'){
                              steps{
                                        sh 'sleep 10'
                              }
                    }
                    stage('Sonarqube validation'){
                              steps{
                                        script{
                                        scannerHome = tool 'sonar-scanner';      
                                        }   
                                        withSonarQubeEnv('sonar-server'){
                                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=redis-app -Dsonar.sources=. -Dsonar.host.url=${env.SONAR_HOST_URL} -Dsonar.login=${env.SONAR_AUTH_TOKEN}"      
                                        }   
                              }
                    }
                    stage('Quality Gate'){
                              steps{
                                        sleep (10)
                                        waitForQualityGate abortPipeline: true
                              }
                    }
                    stage('Teste da aplicação'){
                              steps{
                                        sh 'chmod +x teste-app.sh'
                                        sh './teste-app.sh'
                              }
                    }
                    stage('Shutdown dos containers de teste'){
                              steps{
                                        sh 'docker-compose down'
                              }
                    }
          }
}
