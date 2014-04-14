require 'rufus/scheduler'
scheduler = Rufus::Scheduler.new

scheduler.every '30m' do
	require "net/http"
	require "uri"
	urls = ['http://kaffeine.herokuapp.com',
			'http://followmeback.herokuapp.com',
			'http://viviio.herokuapp.com',
			'http://bestyear.herokuapp.com',
			'http://eifer.herokuapp.com',
			'http://imaginariumfestival.herokuapp.com'
			]
	urls.each do |url|
		Net::HTTP.get_response(URI.parse(url))
	end
end