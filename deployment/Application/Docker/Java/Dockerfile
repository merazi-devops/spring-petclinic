FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y openjdk-17-jdk openjdk-17-jre
RUN apt-get install -y vim mysql-server mysql-client
RUN apt-get install -y git

RUN service mysql start

EXPOSE 8080
EXPOSE 3306
EXPOSE 80

RUN git clone https://github.com/merazi-devops/spring-petclinic.git
WORKDIR spring-petclinic

RUN echo "# database init, supports mysql too" > src/main/resources/application-mysql.properties
RUN echo "database=mysql" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.url=${MYSQL_URL:-jdbc:mysql://petclinic-db-instance-1.cvaynupz6nwb.eu-west-3.rds.amazonaws.com:3306/petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.username=${MYSQL_USER:-petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.password=${MYSQL_PASS:-petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.sql.init.mode=always" >> src/main/resources/application-mysql.properties

CMD ./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
