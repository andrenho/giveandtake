#!/bin/sh

RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Update packages"
yum update -y

echo "Add swap"
dd if=/dev/zero of=/swapfile bs=1G count=4
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon -s
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

echo "Install Java"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install Jenkins stable release"
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
chkconfig jenkins on

echo "Install git"
yum install -y git

echo "Install npm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 4.4.5

echo "Install gradle"
gradle_version=5.2
wget -c http://services.gradle.org/distributions/gradle-${gradle_version}-all.zip
unzip  gradle-${gradle_version}-all.zip -d /opt
ln -s /opt/gradle-${gradle_version} /opt/gradle
printf "export GRADLE_HOME=/opt/gradle\nexport PATH=\$PATH:\$GRADLE_HOME/bin\n" > /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
# check installation
gradle -v

echo "Configure Jenkins"
echo 'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"' >> /etc/sysconfig/jenkins

echo "Start Jenkins"
service jenkins start
sleep 20

echo "Install plugins & configure"
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin Git
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin workflow-aggregator
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin pipeline-multibranch-defaults
java -jar jenkins-cli.jar -s http://localhost:8080/ create-job website < /tmp/mainjob.xml 
service jenkins restart
sleep 20
java -jar jenkins-cli.jar -s http://localhost:8080/ build -s website

echo "Configure jenkins security"
service jenkins stop
echo 'JENKINS_ARGS="--argumentsRealm.passwd.admin=p1a2s3s4 --argumentsRealm.roles.admin=admin"' >> /etc/sysconfig/jenkins
cp /tmp/config.xml /var/lib/jenkins/
service jenkins start
