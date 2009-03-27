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
  it "should generate fresh captchas if the files are older than the generate_every option" do
    codes = Captcha::Config.codes
    sleep @delay
    @generator.generate
    codes.should_not == Captcha::Config.codes
  end
  it "should not regenerate before the files are older than the generate_every option" do
    codes = Captcha::Config.codes
    sleep 1
    @generator.generate
    codes.should == Captcha::Config.codes
  end
  it "should not allow more than the captcha limit to exist" do
    sleep @delay
    @generator.generate
    Captcha::Config.codes.length.should == 10
  end
end