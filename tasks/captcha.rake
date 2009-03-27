namespace :captcha do
  desc 'Generate a batch of captchas'
  task :generate => :environment do
    Captcha::Generator.new
  end
end