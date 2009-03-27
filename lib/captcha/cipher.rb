require 'openssl'
require 'digest/sha1'

module Captcha
  class Cipher
    @@key = Digest::SHA1.hexdigest(Config.options[:password])
    @@iv = 'captchas'*2
    def self.encrypt(text)
      c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
      c.encrypt
      c.key = @@key
      c.iv = @@iv
      e = c.update(text)
      e << c.final
      e = (0..e.length-1).collect do |x|
        e[x]
      end
      e.join('_')
    end
    
    def self.decrypt(text)
      e = text.split('_').collect do |x|
        x.to_i.chr
      end
      e = e.join('')
      c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
      c.decrypt
      c.key = @@key
      c.iv = @@iv
      d = c.update(e)
      d << c.final
    end
  end
end