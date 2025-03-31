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
              sudo dpkg -i puppet7-release-focal.deb
              sudo apt-get update -y
              sudo apt-get install puppet-agent -y'
              echo "puppet installed successfully"
            '''
        }
    }
      
    stage("Docker Installation"){
      steps {
          sh 'ansible-playbook plabook.yaml -i inventory.txt'
          echo "docker installed successfully" 
      }
    }

      stage("Checkout from GitHub") {
            steps {
                git branch: 'master',
                url: 'https://github.com/pranish89/projCert.git'
                echo "Pulled from GitHub successfully"
            }
        }

      stage("Building Docker"){
        steps{          
          sh 'sudo docker build -t edureka_project . '
          echo "Docker image built"
        }
      }

      stage("Running the Docker"){
        steps{
          sh 'sudo docker run -d --name edureka_project -p 80:8080'
          echo "Docker container is running"
        }
      }

      stage("Delete Container"){
        when{
          expression{
            currentBuild.result == 'FAILURE' ||
            currentBuild.result == 'UNSTABLE'
          }
        }
        steps{
          sh 'sudo docker stop edureka_project'
          sh 'sudo docker rm edureka_project'
        }
      }
   }
}  

  
          
