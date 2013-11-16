Fork the API located at: https://github.com/tomdepplito/pickemup_api

Make sure you have JRuby installed by running:
```
rvm install jruby-1.7.1
rvm use jruby 1.7.1
```

Make sure you have the right version of Rails by running:
```
gem install rails -v '4.0.0.rc1'
```

Download Torquebox version 3.0.0 here: http://torquebox.org/download/

Run the following:
```
export TORQUEBOX_HOME=~/torquebox-3.0.0
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export JRUBY_HOME=$TORQUEBOX_HOME/jruby
export PATH=$JRUBY_HOME/bin:$PATH
```

Almost done.  Run:
```
bundle
```

Now to start the whole environment.  Run:
```
torquebox deploy
torquebox run
```

*Torquebox is what we use in production but you could also start a server on any port you want by running:
```
bundle exec puma
```
