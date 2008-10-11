require File.expand_path('../lib/captcha/captcha.rb', File.dirname(__FILE__))

desc 'Updates config/captcha.rb'
task :captcha => 'captcha:config'

namespace :captcha do
  
  desc 'Updates config/captcha.rb'
  task :config => 'captcha:config:to_app'
  
  desc 'Generates captchas'
  task :generate do
    Captchas.new
  end
  
  namespace :config do
    desc 'Copies plugin resources to app'
    task :to_app do
      captcha_resource 'captchas.rb', 'config/captchas.rb'
    end

    desc 'Copies app resources to plugin'
    task :to_plugin do
      captcha_resource 'captchas.rb', 'config/captchas.rb', true
    end
    
    desc 'Removes plugin resources from app'
    task :remove do
      rm_rf 'config/captchas.rb'
    end
  end
  
  def captcha_resource(type, to, reverse=false, overwrite=true)
    from = "#{File.dirname(__FILE__)}/../resources/#{type}"
    from, to = to, from if reverse
    puts "=> Removing old #{type}..."
    puts to
    return if File.exists?(to) && !overwrite
    if File.directory?(from)
      FileUtils.remove_dir(to, true) if File.exists?(to)
      FileUtils.mkdir_p to
    else
      File.unlink(to) if File.exists?(to)
    end
    puts "=> Copying #{type}..."
    (File.directory?(from) ? Dir["#{from}/*"] : [from]).each do |f|
      if File.directory? f
        FileUtils.mkdir_p "#{to}/#{File.basename(f)}"
        FileUtils.cp_r f, to
      else
        FileUtils.cp f, to
      end
    end if File.exists?(from)
  end
end