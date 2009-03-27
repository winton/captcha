require 'openssl'
require 'digest/sha1'

module Captcha
  class Cipher
    @@key = Digest::SHA1.hexdigest(Config.options[:password])
    @@iv = 'captchas'*2
    
    def self.encrypt(text)
      # Encrypt
      cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
      cipher.encrypt
      cipher.key = @@key
      cipher.iv = @@iv
      encrypted = cipher.update(text)
      encrypted << cipher.final
      # Turn into chr codes separated by underscores
      # 135_14_163_53_43_135_172_31_1_23_169_81_49_110_49_230
      encrypted = (0..encrypted.length-1).collect do |x|
        encrypted[x]
      end
      encrypted.join('_')
    end
    
    def self.decrypt(text)
      # Decode chr coded string
      encrypted = text.split('_').collect do |x|
        x.to_i.chr
      end
      encrypted = encrypted.join('')
      # Decrypt
      cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
      cipher.decrypt
      cipher.key = @@key
      cipher.iv = @@iv
      decrypted = cipher.update(encrypted)
      decrypted << cipher.final
    end
  end
end