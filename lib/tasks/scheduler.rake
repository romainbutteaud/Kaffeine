namespace :scheduler do
	desc "Schedule ping tasks for Kaffeine"
	task ping_all: :environment do 
		c = 0
		sites = Site.order(:id)
		total = sites.count
		hydra = Typhoeus::Hydra.new
		sites.each do |site|
			c += 1
			name = site.name
			url = "http://#{name}.herokuapp.com"
			Rails.logger.info "ping #{c}/#{total} (#{site.id}) #{Time.now} #{url}"
			hydra.queue(Typhoeus::Request.new(url, followlocation: true))
		end
		hydra.run
	end
end