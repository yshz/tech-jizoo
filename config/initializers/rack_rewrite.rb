TechJizoo::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  r301 %r{^/(.*)/$}, '/$1'

  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'http://tech.jizoo.net$&', if: Proc.new {|rack_env|
      rack_env['SERVER_NAME'] =~ /jizoo\.herokuapp\.com/
    }
  end
end
