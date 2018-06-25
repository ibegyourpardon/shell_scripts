sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install java
java --version
java -v
whereis java
java --version
/usr/bin/java --version
java -version
yum install jenkins
service jenkins start
iptables -L
cat /var/lib/jenkins/secrets/initialAdminPassword
