Using for bitbucket pipelines

image: pictalingo/docker-node-jdk-chrome:latest

pipelines:
    default:
        -   step:
                caches:
                    - node
                script:
                    - npm install typescript@4.0.3 --save
                    - npm install -g @angular/cli@10.2.0
                    - npm install --no-optional --no-shrinkwrap --no-package-lock
                    - ng --version
                    - ng build --prod
