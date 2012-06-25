# Solr Install

##Get started
    cd /tmp/
    git clone https://github.com/lbdremy/solr-install.git
    cd solr-install
    ./install.sh
    sudo ./etc/init.d/jetty start
    
 + Now visit `http://localhost:8983/solr`

##Notes
In __Redhat Enterprise Linux__ you *cannot execute from /tmp because /tmp is mounted as noexec*.
On attempt it gives you the following error: "bad interpreter: Permission denied", so cloned and executed it somewhere else.
