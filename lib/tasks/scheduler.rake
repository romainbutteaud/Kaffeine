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
      if (site.nap == nil or !site.nap) or (6.hours.ago.strftime('%H:%M') <= site.bedtime and Time.now.strftime('%H:%M') >= site.bedtime) or (site.bedtime[0..1].to_i >= 18 and (6.hours.ago.strftime('%H:%M') <= site.bedtime) and Time.now.strftime('%H:%M') <= ("0" + (site.bedtime[0..1].to_i - 18).to_s + site.bedtime[2..4]))
        Rails.logger.info "ping #{c}/#{total} (#{site.id}) #{Time.now} #{url}"
        hydra.queue(Typhoeus::Request.new(url, followlocation: true))
      end
		end
		hydra.run
	end
end