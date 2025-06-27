FROM node:22-alpine

WORKDIR /app


COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN  npm  install 

COPY . .

# dont pass in  "" below  
# ENV DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres
 
# during docker build it has to postgres so we have 
# use --network=host and that time also database url include localhost 
# and during run time in the database url include name of the database 
# because with in the netwok prisma-to-express 
# RUN DATABASE_URL=$DATABASE_URL npx prisma migrate dev 
RUN npx prisma generate
RUN npm run build 

EXPOSE 3000

# it will run when container will run 
CMD ["npm", "run", "dev:docker"]