namespace :scheduler do
	desc "Schedule ping tasks for Kaffeine"
	task ping_all: :environment do 
		sites = Site.order(:id)
		c = 0
		total = sites.count
		sites.each do |site|
			c += 1
			name = site.name
			url = "http://#{name}.herokuapp.com"
			Rails.logger.info "ping #{c}/#{total} (#{site.id}) #{Time.now} #{url}"
			Net::HTTP.get_response(URI.parse(url))
		end
	end
end