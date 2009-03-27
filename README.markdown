captcha
=======

A Google-style captcha for enterprise Rails apps

Goals
-----

* Batch generate captchas
* Use ciphered filenames (no need to store filename/captcha pairs)
* Easy configuration
  * Number of captchas
  * Period for captcha refresh
  * Colors, wave, implode
* Handle lots of users

Install
-------

	script/plugin install git://github.com/winton/captcha.git

### Create lib/captcha_config.rb (optional)

<pre>
Captcha::Config.new(
  # Used for filename cipher
  :password => 'something-unique',
  # Captcha colors
  :colors => {
    :background => '#FFFFFF',
    :font => '#080288'
  },
  # Number of captcha images to generate
  :count => RAILS_ENV == 'production' ? 500 : 10,
  # Where to write captchas
  :destination => "#{RAILS_ROOT}/public/images/captchas",
  # Generate new batch every day
  :generate_every => 24 * 60 * 60
)
</pre>

See <code>lib/captcha/config.rb</code> for more options.

### application_controller.rb

<pre>
class ApplicationController < ActionController::Base
  acts_as_captcha
end
</pre>

You may now use the <code>reset_captcha</code> method in any controller.

### user.rb

<pre>
class User < ActiveRecord::Base
  acts_as_captcha :base => "base error when captcha fails", :field => "field error when captcha fails"
end
</pre>

With no parameters, a default error is added to the "captcha" field (<code>:field => true</code>).

Specify <code>:base => true</code> to use a default error for base.

### In your view

<pre>
&lt;img src="/images/captchas/<%= session[:captcha] %>.jpg" /&gt;
<%= text_field_tag(:captcha) %>
</pre>

### In your controller

<pre>
user = User.new
user.known_captcha = session[:captcha]
user.captcha = params[:captcha]
user.save
reset_captcha
</pre>

### crontab

<pre>
0 0 * * * cd /path/to/rails/app && /usr/bin/rake RAILS_ENV=production captcha:generate
</pre>

Your config file sets the captcha refresh period. The rake task just checks if its time to repopulate, and does so if necessary.