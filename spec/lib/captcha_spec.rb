require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe :captcha do
  before(:each) do
    @delay = 2 # 2 seconds
    Captcha::Config.new(
      :count => 10,
      :destination => File.expand_path(File.dirname(__FILE__) + "/../tmp"),
      :generate_every => @delay
    )
    FileUtils.rm_rf Captcha::Config.options[:destination]
    @generator = Captcha::Generator.new
  end
  after(:all) do
    FileUtils.rm_rf Captcha::Config.options[:destination]
  end
  it "should generate captchas" do
    Captcha::Config.codes.length.should == 10
  end
  it "should only generate more captchas if the youngest file is older than the generate_every option" do
    @generator.generate
    Captcha::Config.codes.length.should == 10
    sleep @delay
    @generator.generate
    Captcha::Config.codes.length.should == 20
  end
  it "should not allow more than twice the captcha limit to exist" do
    sleep @delay
    @generator.generate
    Captcha::Config.codes.length.should == 20
    sleep @delay
    @generator.generate
    Captcha::Config.codes.length.should == 20
  end
  it "should only destroy the oldest captchas" do
    codes = Captcha::Config.codes
    sleep @delay
    @generator.generate
    codes2 = Captcha::Config.codes
    Captcha::Config.codes.length.should == 20
    Captcha::Config.codes[9..-1].should_include_all_from(codes)
    sleep @delay
    @generator.generate
    Captcha::Config.codes.length.should == 20
    Captcha::Config.codes[9..-1].should_include_all_from(codes2)
    Captcha::Config.codes.should_not_include_any_from(codes)
    @generator.generate
    Captcha::Config.codes.length.should == 20
    Captcha::Config.codes.should_not_include_any_from(codes2)
  end
  class Array
    def should_include_all_from(array)
      included_all = true
      array.each { |a| included_all = false unless self.include?(a) }
      included_all
    end
    def should_not_include_any_from(array)
      included_any = false
      array.each { |a| included_any = true if self.include?(a) }
      included_any
    end
  end
end