{
  :count => 100,    # number of captcha images to generate
  :width => 90,     # canvas width (px)
  :height => 31,    # canvas height (px)
  :colors => {
    :background => '#1B1C20',
    :font => '#7385C5'
  },
  :letters => {
    :baseline => 24,# text baseline (px)
    :count => 6,    # number of letters in captcha
    :ignore => ['a','e','i','o','u','l','j','q'],
    :points => 34,  # font size (pts)
    :width => 14,   # width of a character (used to decrease or increase space between characters) (px)
  },
  :implode => 0.2,  # http://www.imagemagick.org/RMagick/doc/image2.html#implode
  :wave => {        # http://www.imagemagick.org/RMagick/doc/image3.html#wave
    :wavelength => (40..60), # range is used for randomness (px)
    :amplitude => 3          # distance between peak and valley of sin wave (px)
  },
  :generate_on_startup => RAILS_ENV == 'production',
  :destination => 'public/images/captchas',
  :ttf => 'vendor/plugins/captcha/resources/captcha.ttf'
}