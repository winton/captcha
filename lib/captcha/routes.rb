ActionController::Routing::RouteSet::Mapper.class_eval do
  def captcha
    resource :captcha
  end
end