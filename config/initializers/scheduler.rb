require 'rufus-scheduler'
require "net/http"
require "uri"

def ping name
	url = "http://#{name}.herokuapp.com"
	Rails.logger.info "ping #{Time.now} #{url}"
	Net::HTTP.get_response(URI.parse(url))
end

def ping_register name
	s = Rufus::Scheduler.singleton
	s.every '30m' do
		ping name
	end
end

s = Rufus::Scheduler.singleton
s.every '30m' do
	Site.all.each do |site|
		ping site.name
	end
end