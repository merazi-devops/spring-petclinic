FROM ubuntu:latest

# Installer les paquets
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk openjdk-17-jre
RUN apt-get install -y vim mysql-server mysql-client
RUN apt-get install -y git

RUN service mysql start


EXPOSE 8080

RUN git clone https://github.com/AwakenedViskasha/spring-petclinic.git
WORKDIR spring-petclinic

RUN echo "# database init, supports mysql too" > src/main/resources/application-mysql.properties
RUN echo "database=mysql" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.url=${MYSQL_URL:-jdbc:mysql://15.236.7.54:3306/petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.username=${MYSQL_USER:-petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.password=${MYSQL_PASS:-petclinic}" >> src/main/resources/application-mysql.properties
RUN echo "spring.sql.init.mode=always" >> src/main/resources/application-mysql.properties




# Exposer le port MySQL
EXPOSE 3306

# Exposer le port HTTP pour
EXPOSE 80


CMD ./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
