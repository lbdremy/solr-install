#!/bin/bash

# Install dependencies depending of the distribution family
echo "Download dependencies"

if which yum &> /dev/null; then
   echo "You are in the RedHat family"   
   sudo yum install java-1.6.0-openjdk
else
   echo "You are in the Debian family"
   sudo apt-get install openjdk-6-jre openjdk-6-jdk
fi

#DIRS
SCRIPT=$(readlink -f $0)
BASEDIR=`dirname $SCRIPT`
TMP=/tmp
HOME_INSTALL=/usr/local

# Create jetty user
sudo groupadd -r jetty
sudo useradd -M -r -g jetty jetty

# Download and Install Jetty Server
echo "Download and Install Jetty Server"
cd $HOME_INSTALL
JETTY_VERSION=7.4.2.v20110526
sudo wget http://download.eclipse.org/jetty/$JETTY_VERSION/dist/jetty-distribution-$JETTY_VERSION.tar.gz
sudo tar xfz jetty-distribution-$JETTY_VERSION.tar.gz
sudo rm jetty-distribution-$JETTY_VERSION.tar.gz
sudo mv jetty-distribution-$JETTY_VERSION jetty
JETTY_HOME=$HOME_INSTALL/jetty

# Put a new jetty.xml file in JETTY_HOME/etc/
# Now Jetty will listen on port 8983
echo "Replaced old jetty.xml by a new one. Jetty will listen on 8983 port"
sudo cp $BASEDIR/conf/jetty.xml $JETTY_HOME/etc/jetty.xml

#Download and Install Apache Solr
echo "Download and Install Apache Solr"
cd $TMP
wget http://apache.mirrors.timporter.net/lucene/solr/3.3.0/apache-solr-3.3.0.tgz
tar -xzf apache-solr-3.3.0.tgz
rm apache-solr-3.3.0.tgz

# Move Apache Solr Configuration File to Jetty directory
echo "Move Apache Solr Configuration File to Jetty directory"
sudo cp -R $TMP/apache-solr-3.3.0/example/solr/ $JETTY_HOME/

# Copy Apache Solr Application (war file) to Jetty webapp directory
echo "Copy Apache Solr Application (war file) to Jetty webapp directory"
sudo cp $TMP/apache-solr-3.3.0/dist/apache-solr-3.3.0.war $JETTY_HOME/webapps/apache-solr-3.3.0.war

# Copy Solr context from git repository
echo "Copy Solr context from git repository"
sudo cp $BASEDIR/conf/solr.xml $JETTY_HOME/contexts/solr.xml

# Copy Solr Schema
echo "Copy Solr Schema"
sudo cp $BASEDIR/conf/schema.xml $JETTY_HOME/solr/conf/schema.xml

# Copy the jetty startup script 
echo "Copy the jetty startup script in /etc/init.d/"
sudo cp $BASEDIR/conf/jetty.sh /etc/init.d/jetty

# Permissions assignments
sudo chown -R jetty:jetty $JETTY_HOME
#Clean up
echo "Clean up"
sudo rm -R $TMP/apache-solr-3.3.0/

echo "Finish"
echo "For launch Jetty and Solr, run the command java -jar start.jar in the directory $JETTY_HOME"
