#!groovy

def err_msg = ""
def repo_name = "HelloWorld"
def git_url = "http://localhost:8081/git/nunokawa/HelloWorld.git"
def dev_branch = "develop"
def release_branch = "main"

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