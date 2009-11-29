GEM_NAME = 'captcha'
GEM_FILES = FileList['**/*'] - FileList[
  'coverage', 'coverage/**/*',
  'pkg', 'pkg/**/*'
]
GEM_SPEC = Gem::Specification.new do |s|
  # == CONFIGURE ==
  s.author = "Winton Welsh"
  s.email = "mail@wintoni.us"
  s.homepage = "http://github.com/winton/#{GEM_NAME}"
  s.summary = "A Google-style captcha for enterprise Rails apps"
  # == CONFIGURE ==
  s.add_dependency('rmagick', '>=2.9.2')
  s.extra_rdoc_files = [ "README.markdown" ]
  s.files = GEM_FILES.to_a
  s.has_rdoc = false
  s.name = GEM_NAME
  s.platform = Gem::Platform::RUBY
  s.require_path = "lib"
  s.version = "1.2.2"
end
