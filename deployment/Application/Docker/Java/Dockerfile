FROM ubuntu:latest

# Installer les paquets
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk openjdk-17-jre
RUN apt-get install -y vim mysql-server mysql-client
RUN apt-get install -y git

RUN service mysql start


EXPOSE 8080

RUN git clone https://github.com/spring-projects/spring-petclinic.git
WORKDIR spring-petclinic

RUN echo "# database init, supports mysql too" > src/main/resources/application-mysql.properties
RUN echo "database=mysql" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.url= jdbc:mysql://petclinic.alpha-technology.cloudns.ph:3306/petclinic" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.username=petclinic" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.password=petclinic" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.driver-class-name=com.mysql.jdbc.Driver" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.schema=classpath*:db/${database}/schema.sql" >> src/main/resources/application-mysql.properties
RUN echo "spring.datasource.data=classpath*:db/${database}/data.sql" >> src/main/resources/application-mysql.properties

RUN ./mvnw package


# Exposer le port MySQL
EXPOSE 3306

# Exposer le port HTTP pour
EXPOSE 80


# Lancer nginx
#CMD java -jar target/*.jar



CMD ./mvnw spring-boot:run -D spring-boot.run.profiles=mysql
