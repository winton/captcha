require 'RMagick'

module Captcha
  class Image

    include Magick
    attr_reader :code, :image

    def initialize(o)
      @code = generate_code o
    
      canvas = Magick::ImageList.new
      canvas.new_image(o[:dimensions][:width], o[:dimensions][:height]) {
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
  
    private

    def generate_code(o)
      chars = ('a'..'z').to_a - o[:letters][:ignore]
      code_array = []
      1.upto(o[:letters][:count]) { code_array << chars[rand(chars.length)] }
      code_array
    end
  end
end