pipeline {
          agent any
          enviroment {
                    TAG = sh(script: 'git describe --abbrev=0',, returnStdout: true).trim()
          }
          stages { 
                    stage('Build da imagem docker'){
                              steps{
                                        sh 'docker build -t devops/app:${TAG} .'
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
                     stage('Upload docker image'){
                              steps{
                                        script{
                                                  withCredentials([usernamePassword(credentialsId: 'nexus-user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD' )]){
                                                           sh 'docker login -u $USERNAME -p $PASSWORD ${NEXUS_URL}' 
                                                           sh 'sleep 10'
                                                           sh 'docker tag devops/app:${TAG} ${NEXUS_URL}/devops/app:${TAG}'
                                                           sh 'docker push ${NEXUS_URL}/devops/app:${TAG}'
                                                  }
                                        }
                              }
                    }
                    stage('Apply k8s files'){
                              steps{
                                        sh '/usr/local/bin/kubectl apply -f ./k3s/redis.yaml'
                                        sh '/usr/local/bin/kubectl apply -f ./k3s/redis-app.yaml'
                              }
                    }
          }
}
