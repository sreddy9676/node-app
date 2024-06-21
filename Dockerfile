# FROM node:carbon

# # Create app directory
# WORKDIR /usr/src/app

# # Install app dependencies
# # A wildcard is used to ensure both package.json AND package-lock.json are copied
# # where available (npm@5+)
# COPY package*.json ./

# RUN npm install
# # If you are building your code for production
# # RUN npm install --only=production

# # Bundle app source
# COPY . .

# EXPOSE 8080
# CMD [ "npm", "start" ]
FROM docker:dind
RUN apk update && apk upgrade && \ 
    apk add --no-cache \
    bash \
    git \
    ca-certificates \
    curl \
    nodejs \
    npm
#verify node version when built this will always use the latest version    
RUN node --version && \
    npm --version
#install the semantic release npm package and gitlab module    
Run npm install -g \
    conventional-changelog-conventionalcommits \
    semantic-release \
    @semantic-release/changelog \
    @semantic-release/commit-analyzer \
    @semantic-release/exec \
    @semantic-release/git \
    @semanitc-release/gitlab \
    @semanitc-release/npm \
    @semanitc-release/release-notes-generator \
    @semanitc-release-slack-bot
# clear the cache    
RUN rm -rf /var/cache/apk/*    
