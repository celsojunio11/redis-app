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