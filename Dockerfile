#build phase - creates a build in /app/build
FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
CMD ["npm", "run", "build"]

#run phase 
#nginx image will start automatically with having to run some command on it
FROM nginx
#--from means copy something from a different phase
#here we copy the directory /app/build from the builder phase to the /usr/share/nginx/html
#/usr/share/nginx/html is standard directory for nginx
COPY --from=builder /app/build /usr/share/nginx/html

#build - docker build .
#run - docker run -p 8080:80 (port 80 is default for nginx)
