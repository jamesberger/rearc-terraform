FROM node:10

# App directory
WORKDIR /home/

# Copy our files over
COPY . .

# Run npm install
RUN npm install


# App runs on port 3000, so let's expose that
EXPOSE 3000

# Run our app
CMD [ "npm", "start" ]
