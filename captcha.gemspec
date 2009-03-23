Gem::Specification.new do |s|
  s.name    = 'captcha'
  s.version = '1.0.4'
  s.date    = '2009-03-23'
  
  s.summary     = "An Rmagick based, Google-style captcha generator"
  s.description = "An Rmagick based, Google-style captcha generator"
  
  s.author   = 'Winton Welsh'
  s.email    = 'mail@wintoni.us'
  s.homepage = 'http://github.com/winton/captcha'
  
  s.has_rdoc = false
  
  # = MANIFEST =
  s.files = %w[
    README.markdown
    Rakefile
    captcha.gemspec
    init.rb
    lib/captcha.rb
    lib/captcha/action.rb
    lib/captcha/actions.rb
    lib/captcha/captcha.rb
    lib/captcha/config.rb
    lib/captcha/generator.rb
    lib/captcha/image.rb
    lib/captcha/routes.rb
    resources/captcha.ttf
    resources/captchas.rb
    spec/lib/captcha_spec.rb
    spec/spec.opts
    spec/spec_helper.rb
    tasks/captcha.rake
  ]
  # = MANIFEST =
end
