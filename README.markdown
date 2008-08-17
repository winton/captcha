captcha
=======

A simple captcha generator for Rails.


How it works
------------

If **public/images/captchas** does not exist, 100 captchas will be generated there when the application starts.


Install
-------

	gem install winton-captcha

### Add to environment.rb

	config.gem 'winton-captcha', :lib => 'captcha', :source => 'http://gems.github.com'

### Add to .gitignore

	public/images/captchas


##### Copyright &copy; 2008 [Winton Welsh](mailto:mail@wintoni.us)