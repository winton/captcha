require 'captcha'

ActionController::Base.send :include, CaptchaActions

to = "public/images/captchas"
unless File.exists?(to)
  FileUtils.mkdir_p to
  (0..99).each do |x|
    c = Captcha.new(6)
    File.open("#{to}/#{c.code}.jpg", 'w') do |f|
      f << c.code_image
    end
  end
end