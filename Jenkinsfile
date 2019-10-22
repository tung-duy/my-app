node {
    def app
    stage('Build Docker Image') {
        checkout scm
        app = docker.build('tungduy/my-app:latest')
    }

    stage('Publish to Docker Hub') {
        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
            app.push('latest')
        }
    }

    stage('Deploy to Production') {
        docker.withServer('tcp://production:2376', 'production') {
            sh 'docker run -d tungduy/my-app'
        }
    }
}