captcha
=======

An Rmagick based, Google-style captcha generator.


Install
-------

	script/plugin install git://github.com/winton/captcha.git

### Create lib/captcha_config.rb (optional)

<pre>
{
  :colors => {
    :background => '#1B1C20',
    :font => '#7385C5'
  },
  # number of captcha images to generate
  :count => 500,
  :destination => "#{RAILS_ROOT}/public/images/captchas"
  ),
  :dimensions => {
    # canvas height (px)
    :height => 31,
    # canvas width (px)
    :width => 90
  },
  :generate_every => 24 * 60 * 60,
  # http://www.imagemagick.org/RMagick/doc/image2.html#implode
  :implode => 0.2,
  :letters => {
    # text baseline (px)
    :baseline => 24,
    # number of letters in captcha
    :count => 6,
    :ignore => ['a','e','i','o','u','l','j','q'],
    # font size (pts)
    :points => 34,
    # width of a character (used to decrease or increase space between characters) (px)
    :width => 14
  },
  :ttf => File.expand_path("#{File.dirname(__FILE__)}/../../resources/captcha.ttf"),
  # http://www.imagemagick.org/RMagick/doc/image3.html#wave
  :wave => {
    # range is used for randomness (px)
    :wavelength => (20..70),
    # distance between peak and valley of sin wave (px)
    :amplitude => 3
  }
}
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

### Add public/images/captchas/* to your .gitignore

  public/images/captchas/*

Captchas will generate and re-generate automatically (see the <code>generate_every</code> option).

Access <code>/captcha</code> to retrieve the image, <code>/captcha/new</code> to grab a new image, and <code>session[:captcha]</code> for the captcha code.