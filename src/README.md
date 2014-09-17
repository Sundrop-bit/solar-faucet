# sundrop.bit

Work in progress bitcoin faucet..
More details emerging..

Hint: It's in the name..


# Installation

1. Set variables in src/client/views/home/home.coffee:
    * IP_ADDRESS - public internet address or hostname
    * RECAPTCHA_PUBLIC_KEY - from https://www.google.com/recaptcha/admin
1. Set variables in server/methods.coffee:
    * RECAPTCHA_PRIVATE_KEY - from https://www.google.com/recaptcha/admin
    * FAUCET_AMOUNT_IN_SATOSHI - Amount of satoshi to send on each faucet command
    * BLOCKCHAIN_GUID - your unique user ID for Blockchain.info service (not your username/alias)
    * BLOCKCHAIN_PASSWORD - primary password
    * BLOCKCHAIN_PASSWORD2 - secondary if any, otherwise empty string
    * BLOCKCHAIN_FEE_IN_SATOSHI - how much fee to send
    
1. Execute ["demeteorizer"](https://github.com/onmodulus/demeteorizer):

    $ demeteorizer --tarball /path/to/tarball.tar.gz
    
1. Install MongoDB locally or on another server. [RasPi Instructions](http://www.widriksson.com/install-mongodb-raspberrypi/)

1. Copy to your destination server/device   

1. Install using standard Meteor setup instructions
 Example only, your data will vary:
 
    $ npm install
    
    $ npm install underscore
 
    $ npm install source-map-support
 
    $ npm install semver
 
    $ npm install uglify-js
 
    $ npm install css-parse

    $ npm install css-stringify

    $ npm install connect

    $ npm install useragent

    $ npm install send

    $ npm install sockjs

    $ npm install mongod
    
    $ npm install mongodb

    $ npm install mailcomposer

    $ npm install handlebars

    $ npm install request
    
    $ export MONGO_URL=mongodb://localhost:27017/meteor
    
    $ export PORT=8080
    
    $ export ROOT_URL=http://127.131.33.128
    
    $ node main.js
    
    
    ## I know there has got to be a simpler way to do this but I haven't researched it enough
    
# Troubleshooting

If you get errors starting mongodb, try to remove the lock file and then restart the service:

    $ sudo rm /var/lib/mongodb/mongod.lock 
    $ sudo /etc/init.d/mongod start