require 'sinatra'
require 'mail'
require 'securerandom'
require 'erb'
require 'tilt'
require 'logger'

require_relative 'lib/fs_util/fs'
include FSUtil

if ENV == nil
	require 'dotenv'
	Dotenv.load
end

post '/parse' do
	payload = JSON.parse(request.body.read)
	puts payload['from']
  headers = Mail.new(params[:headers])

  id = headers['X-Save-Mail-ID'] || SecureRandom.uuid

  template_name = headers['X-Save-Mail-Template'] || "default"

  template_name += ".html.erb"

  template = Tilt.new("_templates/" + template_name)
  result = template.render(params, :parsed_headers => headers)

	FSUtil.write("/tmp/foo.txt", result)

	#TODO for each object in a given email call FSUtil::create_and_write

  "OK."
end
