
####to start please add virtualenv    
`virtualenv -p python3 venv`  
`source venv/bin/activate`  
then install requirements:  
`pip install -r requirements.txt`  

####Celery configurations:  

sudo apt-get install supervisor -y 

sudo service supervisor start

`redis-server`  
`supervisord -c /Users/michaelspa/PycharmProjects/prototype/celery.conf`

supervisorctl start  
supervisorctl stop

to kill all workers type:  
`ps ax | grep celery | awk '{print $1}' | xargs kill -9`
`ps ax | grep supervisor | awk '{print $1}' | xargs kill -9`


####Start flask application:
`flask run`

then visit http://127.0.0.1:5000/ add click the buttons


For cpu limit you should do:  

apt-get install cpulimit

cpulimit -l 20 -p 1234  

start on windows:
celery -A tasks worker -n celery_worker1 -l INFO --pool=gevent

Travis CI
--
connect to the server you need to deploy:  
`ssh <user>@<server_ip>`  
then:  
 `cd ~/.ssh`  
 `ssh-keygen -t rsa -b 4096 -C "TravisCIDeployKey"`  
 then set name for ssh-key by default and set passphrase(for example: `travis`)  
 next:  
 `cat id_rsa.pub >> authorized_keys`
 after that you could exit from server  
 
Then go to your project and copy the ssh-key:   
`scp <user>@<server_ip>:/root/.ssh/id_rsa ./deploy_key`  

And Test That you are Able to Login to the Server:  
`ssh -i ./deploy_key <user>@<server_ip>`  

then Install Travis-CI CLI:  
for example the command for linux `gem install travis` 

Login to Travis with the CLI:
`travis login`

Encrypt the git_deploy_key (private key) using a symmetric encryption (AES-256), and store the secret in a secure environment variable in the Travis environment:
`travis encrypt-file deploy_key`

The travis encrypt-file will encrypt the private key into the deploy_key.enc file and output in the console the command to add to your .travis.yml file. It should look like openssl aes-256-cbc -K $encrypted_KKKKKKKKKKKK_key -iv $encrypted_VVVVVVVVVVVV_iv -in deploy_key.enc -out deploy_key -d

then try this command:  
openssl aes-256-cbc -e -p -in deploy_key -out deploy_key.enc -K `openssl rand -hex 32` -iv `openssl rand -hex 16`

and from output get REPO_ENC_KEY and REPO_ENC_IV pass it to travis ci environment variables
pass to .travis.yml in section before_install:  
\- openssl aes-256-cbc -K $REPO_ENC_KEY -iv $REPO_ENC_IV -in deploy_key.enc -out /tmp/deploy_key -d

also add to git `deploy_key.enc` that travis has generated