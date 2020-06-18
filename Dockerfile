# Container image that runs your code
FROM node:10

LABEL "com.github.actions.name"="Deploy Hexo Sync Yuque Action"
LABEL "com.github.actions.description"="This GitHub action will handle the building and deploying process of hexo project."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/chenpeng/deploy-hexo-sync-yuque-action"
LABEL "homepage"="https://github.com/chenpeng/deploy-hexo-sync-yuque-action"
LABEL "maintainer"="chenpeng"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
