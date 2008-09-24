require 'RMagick'

class Captchas
  
  attr_reader :codes
  
  def initialize(startup=false)
    @o = get_options
    return unless @o
    generate if !startup || @o[:generate_on_startup]
    update_codes
  end
  
  def options
    @o
  end
  
  def generate
    FileUtils.rm_rf   @o[:destination]
    FileUtils.mkdir_p @o[:destination]
    
    (1..@o[:count]).each do |x|
      c = Captcha.new @o
      File.open("#{@o[:destination]}/#{c.code}.jpg", 'w') do |f|
        f << c.image
      end
    end
    GC.start
  end
  
  def update_codes
    @codes = Dir["#{@o[:destination]}/*.jpg"].collect do |f|
      File.basename f, '.jpg'
    end
  end
  
private

  def get_options
    if File.exists?('config/captchas.rb')
      eval File.read('config/captchas.rb')
    end
  end
  
  class Captcha
  
    include Magick
    attr_reader :code, :image
  
    def initialize(o)
      @code = generate_code o
    
      canvas = Magick::ImageList.new
      canvas.new_image(o[:width], o[:height]) {
        self.background_color = o[:colors][:background]
      }
    
      text = Magick::Draw.new
      text.font = File.expand_path o[:ttf]
      text.pointsize = o[:letters][:points]
    
      cur = 0
      @code.each { |c|
        text.annotate(canvas, 0, 0, cur, o[:letters][:baseline], c) {
          self.fill = o[:colors][:font]
        }
        cur += o[:letters][:width]
      }
    
      w = o[:wave][:wavelength]
      canvas = canvas.wave(o[:wave][:amplitude], rand(w.last - w.first) + w.first)
      canvas = canvas.implode(o[:implode])
    
      @code  = @code.to_s
      @image = canvas.to_blob { self.format = "JPG" }
    end
  
    def generate_code(o)
      chars = ('a'..'z').to_a - o[:letters][:ignore]
      code_array = []
      1.upto(o[:letters][:count]) { code_array << chars[rand(chars.length)] }
      code_array
    end
  end
end