pipeline {
  agent none
  stages {
    stage("Puppet Agent Installation") {
      agent{
        label 'slave'
      }
      steps{        
        sh '''
              wget https://apt.puppetlabs.com/puppet7-release-focal.deb
              echo "puppet installed successfully"
            '''
        }
    }
  
      
    stage("Docker Installation"){
      agent{
        label 'slave'
      }
      steps {
          sh 'ansible-playbook -i inventory.txt plabook.yaml'
          echo "docker installed successfully" 
      }
    }

      stage("Checkout from GitHub") {
        agent{
        label 'slave'
      }
            steps {
                git branch: 'master',
                url: 'https://github.com/pranish89/projCert.git'
                echo "Pulled from GitHub successfully"
            }
        }

      stage("Building Docker"){
       agent{
        label 'slave'
      }
        steps{          
          sh 'docker build -t edureka_project . '
          echo "Docker image built"
        }
      }

      stage("Running the Docker"){
      agent{
        label 'slave'
      }
        steps{
          sh 'docker run -d -p 8082:80 edureka_project'
          echo "Docker container is running"
        }
      }

      stage("Delete Container"){
       agent{
        label 'slave'
      }
        when{
          expression{
            currentBuild.result == 'FAILURE' ||
            currentBuild.result == 'UNSTABLE'
          }
        }
        steps{
          sh 'docker stop edureka_project'
          sh 'docker rm edureka_project'
        }
      }
   }
}  

  
          
