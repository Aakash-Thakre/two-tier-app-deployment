pipeline{
    
    agent { label "dev"};
    
    stages{
        stage("Code Clone"){
            steps{
               script{
                   clone("https://github.com/Aakash-Thakre/two-tier-app-deployment.git", "maiin")
               }
            }
        }
        stage("Trivy File System Scan"){
            steps{
                script{
                    trivy_fs()
                }
            }
        }
        stage("Build"){
            steps{
                sh "docker build -t two-tier-flask-app ."
            }
            
        }
        stage("Test"){
            steps{
                echo "Developer / Tester tests "
            }
            
        }
        stage("Deploy"){
            steps{
                sh "docker compose up -d --buid flask-app"
            }
        }
    }
}
