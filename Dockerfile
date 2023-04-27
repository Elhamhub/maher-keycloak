# FROM quay.io/keycloak/keycloak:21.0.1

# Create the providers directory if it doesn't exist
# RUN mkdir -p /opt/jboss/keycloak/providers

# Add the necessary JARs to the providers directory
# ADD https://repo1.maven.org/maven2/org/jgroups/aws/jgroups-aws/2.0.1.Final/jgroups-aws-2.0.1.Final.jar /opt/keycloak/lib/quarkus/
# ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.12.410/aws-java-sdk-core-1.12.410.jar /opt/keycloak/lib/quarkus/
# ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.12.410/aws-java-sdk-s3-1.12.410.jar /opt/keycloak/lib/quarkus/
# ADD https://repo1.maven.org/maven2/joda-time/joda-time/2.12.2/joda-time-2.12.2.jar /opt/keycloak/lib/quarkus/
# ADD https://repo1.maven.org/maven2/org/jgroups/aws/s3/native-s3-ping/1.0.0.Final/native-s3-ping-1.0.0.Final.jar /opt/keycloak/lib/quarkus/

# ADD https://repo1.maven.org/maven2/org/jgroups/aws/jgroups-aws/2.0.1.Final/jgroups-aws-2.0.1.Final.jar /opt/keycloak/providers/
# ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.12.410/aws-java-sdk-core-1.12.410.jar /opt/keycloak/providers/
# ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.12.410/aws-java-sdk-s3-1.12.410.jar /opt/keycloak/providers/
# ADD https://repo1.maven.org/maven2/joda-time/joda-time/2.12.2/joda-time-2.12.2.jar /opt/keycloak/providers/
# ADD https://repo1.maven.org/maven2/org/jgroups/aws/s3/native-s3-ping/1.0.0.Final/native-s3-ping-1.0.0.Final.jar /opt/keycloak/providers/





#########################
FROM public.ecr.aws/docker/library/maven:3.8.4-openjdk-17-slim as maven-builder

COPY native-s3-ping/pom.xml ./

RUN mvn package

FROM quay.io/keycloak/keycloak:20.0.5 as keycloak-builder

COPY --from=maven-builder --chown=keycloak target/s3-native-ping-bundle-*-jar-with-dependencies.jar /opt/keycloak/providers/

ENV KC_METRICS_ENABLED=true \
    KC_DB=postgres \
    KC_CACHE=ispn \
    KC_CACHE_STACK=ec2
    
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.5
COPY --from=keycloak-builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=keycloak-builder /opt/keycloak/providers/* /opt/keycloak/providers/

# Add the necessary JARs to the providers directory
ADD https://repo1.maven.org/maven2/org/jgroups/aws/jgroups-aws/2.0.1.Final/jgroups-aws-2.0.1.Final.jar /opt/keycloak/lib/quarkus/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.12.410/aws-java-sdk-core-1.12.410.jar /opt/keycloak/lib/quarkus/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.12.410/aws-java-sdk-s3-1.12.410.jar /opt/keycloak/lib/quarkus/
ADD https://repo1.maven.org/maven2/joda-time/joda-time/2.12.2/joda-time-2.12.2.jar /opt/keycloak/lib/quarkus/
ADD https://repo1.maven.org/maven2/org/jgroups/aws/s3/native-s3-ping/1.0.0.Final/native-s3-ping-1.0.0.Final.jar /opt/keycloak/lib/quarkus/

ADD https://repo1.maven.org/maven2/org/jgroups/aws/jgroups-aws/2.0.1.Final/jgroups-aws-2.0.1.Final.jar /opt/keycloak/providers/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.12.410/aws-java-sdk-core-1.12.410.jar /opt/keycloak/providers/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.12.410/aws-java-sdk-s3-1.12.410.jar /opt/keycloak/providers/
ADD https://repo1.maven.org/maven2/joda-time/joda-time/2.12.2/joda-time-2.12.2.jar /opt/keycloak/providers/
ADD https://repo1.maven.org/maven2/org/jgroups/aws/s3/native-s3-ping/1.0.0.Final/native-s3-ping-1.0.0.Final.jar /opt/keycloak/providers/

