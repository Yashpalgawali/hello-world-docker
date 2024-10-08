## Following will create the docker file , but we need to run mvn clean install manually (STEP1)
#FROM openjdk:18.0-slim
#COPY target/*.jar app.jar
#EXPOSE 5000
#ENTRYPOINT ["java","-jar","/app.jar"]
## End OF Step 1 ##


## Following will create the docker file , it will create jar file as well, as maven is installed (STEP 2)
#FROM maven:3.8.6-openjdk-18-slim AS build
#WORKDIR /home/app
#COPY . /home/app
#RUN mvn -f /home/app/pom.xml clean package
#
#FROM openjdk:18.0-slim
#EXPOSE 5000
#COPY --from=build /home/app/target/*.jar app.jar
#ENTRYPOINT ["java","-jar","/app.jar"] 

## END OF STEP 2 ##
  
## Step 3 ( Using caching ,so it will not download all the files all the time ,when we make changes to other files)
FROM maven:3.8.6-openjdk-18-slim AS build
WORKDIR /home/app

COPY ./pom.xml /home/app/pom.xml
COPY ./src/main/java/com/in28minutes/rest/webservices/restfulwebservices/RestfulWebServicesApplication.java	/home/app/src/main/java/com/in28minutes/rest/webservices/restfulwebservices/RestfulWebServicesApplication.java

RUN mvn -f /home/app/pom.xml clean package

COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package


FROM openjdk:18.0-slim
EXPOSE 5000
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"] 
