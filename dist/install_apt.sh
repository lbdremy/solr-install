#!/bin/bash

# Install dependencies
echo "Download dependencies"
sudo apt-get install openjdk-6-jre openjdk-6-jdk

#Create jetty user
sudo groupadd -r jetty
sudo useradd -M -r -g jetty jetty

# Download and Install Jetty Server
echo "Download and Install Jetty Server"
cd /usr/local/
JETTY_VERSION=7.4.2.v20110526
sudo wget http://download.eclipse.org/jetty/$JETTY_VERSION/dist/jetty-distribution-$JETTY_VERSION.tar.gz
sudo tar xfz jetty-distribution-$JETTY_VERSION.tar.gz
sudo rm jetty-distribution-$JETTY_VERSION.tar.gz
sudo mv jetty-distribution-$JETTY_VERSION jetty
JETTY_HOME=/usr/local/jetty

# Put a new jetty.xml file in JETTY_HOME/etc/
# Now Jetty will listen on port 8983
echo "Replaced old jetty.xml by a new one. Jetty will listen on 8983 port"
sudo cp /tmp/solr-install/conf/jetty.xml $JETTY_HOME/etc/jetty.xml

#Download and Install Apache Solr
echo "Download and Install Apache Solr"
cd /tmp/
wget http://apache.mirrors.timporter.net/lucene/solr/3.3.0/apache-solr-3.3.0.tgz
tar -xzf apache-solr-3.3.0.tgz
rm apache-solr-3.3.0.tgz

# Move Apache Solr Configuration File to Jetty directory
echo "Move Apache Solr Configuration File to Jetty directory"
sudo cp -R /tmp/apache-solr-3.3.0/example/solr/ $JETTY_HOME/

# Copy Apache Solr Application (war file) to Jetty webapp directory
echo "Copy Apache Solr Application (war file) to Jetty webapp directory"
sudo cp /tmp/apache-solr-3.3.0/dist/apache-solr-3.3.0.war $JETTY_HOME/webapps/apache-solr-3.3.0.war

# Copy Solr context from git repository
echo "Copy Solr context from git repository"
sudo cp /tmp/solr-install/conf/solr.xml $JETTY_HOME/contexts/solr.xml

# Copy Solr Schema
echo "Copy Solr Schema"
sudo cp /tmp/solr-install/conf/schema.xml $JETTY_HOME/solr/conf/schema.xml

# Permissions assignments
sudo chown -R jetty:jetty $JETTY_HOME
#Clean up
echo "Clean up"
sudo rm -R /tmp/apache-solr-3.3.0/

echo "Finish"
echo "For launch Jetty and Solr, run the command java -jar start.jar in the directory $JETTY_HOME"
