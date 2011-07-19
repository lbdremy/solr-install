#!/bin/bash

# Clone INSTALL JETTY AND SOLR
git clone http://

JAVA_HOME=/usr/bin/java
JAVA_OPTIONS="-Dsolr.sorl?home=/usr/share/jetty/sorl/ $JAVA_OPTIONS"
JETTY_HOME=/usr/share/jetty/solr/
JETTY_USER=jetty
JETTY_LOGS=/usr/share/jetty/logs/

#Don't forget to edit /etc/default/jetty and change NO_START to be 0 (or comment it out)

# Install dependencies
sudo apt-get install openjdk-6-jre openjdk-6-jdk

#Create jetty user TODO

# Download and Install Jetty Server
cd /usr/local/
mkdir jetty
cd jetty
JETTY_VERSION=7.4.2.v20110526
wget http://download.eclipse.org/jetty/$JETTY_VERSION/dist/jetty-distribution-$JETTY_VERSION.tar.gz
tar xfz jetty-distribution-$JETTY_VERSION.tar.gz
cd jetty-distribution-$JETTY_VERSION

#Download and Install Apache Solr
cd /tmp/
wget http://apache.mirrors.timporter.net/lucene/solr/3.3.0/apache-solr-3.3.0.tgz
tar -xzf apache-solr-3.3.0.tgz

# Move Apache Solr Configuration File to Jetty directory
cp -R /tmp/apache-solr-3.3.0/example/solr /usr/local/jetty/

# Copy Apache Solr Application (war file) to Jetty webapp directory
cp /tmp/apache-sorl-3.3.0/dist/apache-solr-3.3.0.war /usr/local/jetty/webapp/

# Clone Solr context from git repository
cd /usr/local/jetty/contexts/

