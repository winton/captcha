captcha
=======

An Rmagick based, Google-style captcha generator.


Install
-------

	script/plugin install git://github.com/winton/captcha.git

### Create lib/captcha_config.rb (optional)

<pre>
{
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
  :generate_every => RAILS_ENV == 'production' ? 24 * 60 * 60 : 10 ** 8
}
</pre>

See <code>lib/captcha/config.rb</code> for more options.

### Add public/images/captchas/* to your .gitignore file

<pre>
public/images/captchas/*
</pre>

### Create a captcha controller
	
	script/generate controller Captchas

### Add the resource to your routes.rb

	map.resource :captcha

### Add acts\_as\_captcha to captchas_controller.rb

<pre>
class CaptchasController < ApplicationController
  acts_as_captcha
end
</pre> 

### Add acts\_as\_captcha to your model

<pre>
acts_as_captcha "does not have the correct code"
</pre>

The parameter is either the error added to the captcha input or nil to add a generic error to base.

### In your view

<pre>
&lt;img src="/captcha?<%= Time.now.to_i %>" onclick="this.src = '/captcha/new?' + (new Date()).getTime()" /&gt;
<%= text_field_tag(:captcha) %>
</pre>

### In your controller

<pre>
model_instance.known_captcha = session[:captcha]
model_instance.captcha = params[:captcha]
</pre>

### More information

Captchas will generate and re-generate automatically when a Rails instance starts. Captcha keeps the old batch of captchas around until the next re-generate so users do not get 404s.

We used the following URLs in our view:

* <code>/captcha</code> to retrieve the image 
* <code>/captcha/new</code> to grab a new image

Use <code>session[:captcha]</code> to store, retrieve, and reset the captcha code.