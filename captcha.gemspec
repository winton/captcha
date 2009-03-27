Gem::Specification.new do |s|
  s.name    = 'captcha'
  s.version = '1.2.1'
  s.date    = '2009-03-27'
  
  s.summary     = "A Google-style captcha for enterprise Rails apps"
  s.description = "A Google-style captcha for enterprise Rails apps"
  
  s.author   = 'Winton Welsh'
  s.email    = 'mail@wintoni.us'
  s.homepage = 'http://github.com/winton/captcha'
  
  s.has_rdoc = false
  
  # = MANIFEST =
  s.files = %w[
    MIT-LICENSE
    README.markdown
    Rakefile
    captcha.gemspec
    init.rb
    lib/captcha.rb
    lib/captcha/action.rb
    lib/captcha/cipher.rb
    lib/captcha/config.rb
    lib/captcha/generator.rb
    lib/captcha/image.rb
    lib/captcha/model.rb
    resources/captcha.ttf
    spec/lib/captcha_spec.rb
    spec/spec.opts
    spec/spec_helper.rb
    tasks/captcha.rake
  ]
  # = MANIFEST =
end
