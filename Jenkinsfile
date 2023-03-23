pipeline {
    agent none

    stages {
        stage('parallel') {
            parallel {
                stage("linux") {
                    agent {
                        label "macOS"
                    }

                    stages {
                        stage("setup") {
                            steps {
                                sh "./script/docker_build.sh"
                            }
                        }

                        stage("build") {
                            steps {
                                sh "./script/run_command.sh ./script/build_apk.sh"
                            }
                        }
                    }
                }
            }
        }
    }
}