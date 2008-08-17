require 'RMagick'

Dir[File.expand_path('*/*.rb', File.dirname(__FILE__))].each do |f|
  require [ File.dirname(f), File.basename(f, '.rb') ].join('/')
end

class Captcha
  
  include Magick
  attr_reader :code, :code_image
  
  JIGGLE = 15
  WOBBLE = 25

  def initialize(len)
    chars = ('a'..'z').to_a - ['a','e','i','o','u','l','j']
    code_array = []
    1.upto(len) { code_array << chars[rand(chars.length)] }
    granite = Magick::ImageList.new('granite:')
    canvas = Magick::ImageList.new
    canvas.new_image(32*len, 50, Magick::TextureFill.new(granite))
    text = Magick::Draw.new
    text.font = File.expand_path('vendor/plugins/captcha/resources/captcha.ttf')
    text.pointsize = 40
    cur = 10

    code_array.each { |c|
      rot    = rand(10) > 5 ? rand(WOBBLE) : -rand(WOBBLE)
      weight = rand(10) > 5 ? NormalWeight : BoldWeight
      text.annotate(canvas,0,0,cur,30+rand(JIGGLE), c) {
        self.rotation = rot
        self.font_weight = weight
        self.fill = '#98999B'
      }
      cur += 30
    }
    
    @code = code_array.to_s
    @code_image = canvas.to_blob {
      self.format = "JPG" 
    }
    
    GC.start
  end

end