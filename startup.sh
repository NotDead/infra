sudo -u appuser -i /bin/bash <<EOF
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
rvm install 2.4.1
rvm use 2.4.1 --default
gem install bundler -V --no-ri --no-rdoc
ruby -v
gem -v bundler

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt-get update && sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

git clone https://github.com/Artemmkin/reddit.git
cd reddit && bundle install
puma -d
echo `ps aux|grep -m1 puma`
PORT=`ps aux|grep -m1 puma| awk '{print $13}'| tr -d '()'| awk 'BEGIN { FS = ":" } ; { print $3 }'`
echo $PORT
EXTIP=`curl ipecho.net/plain`
echo "application deployed succesfully."
echo "you can connect and check."
echo "http://$EXTIP:$PORT"
EOF

