pipeline {
          agent any
          stages('build da imagem docker'){
                    steps{
                              sh 'docker build -t devops/app .'
                    }
          }
          stage('subir docker compose - redis e app'){
                    steps{
                              sh 'docker-compose up --build -d'
                    }
          }
          stage('sleep para subida de container'){
                    steps{
                              sh 'sleep 10'
                    }
          }
          stage('teste da aplicação'){
                    steps{
                              sh 'teste-app.sh'
                    }
          }
}