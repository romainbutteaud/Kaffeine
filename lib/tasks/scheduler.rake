namespace :scheduler do
	desc "Schedule ping tasks for Kaffeine"
	task ping_all: :environment do 
		sites = Site.all
		sites.each do |site|
			name = site.name
			url = "http://#{name}.herokuapp.com"
			Rails.logger.info "ping #{Time.now} #{url}"
			Net::HTTP.get_response(URI.parse(url))
		end
	end
end