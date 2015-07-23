class HomeController < ApplicationController

	def authenticate
		authenticate_or_request_with_http_basic do |username, password|
			username == "#{ENV['ADMIN_LOGIN']}" && password == "#{ENV['ADMIN_PASSWORD']}"
		end
	end

	def index
		@count = Site.count
	end

	def register
		if Site.find_by_name(params[:name])
			render json: {}, status: 201
    else Site.create(:name => params[:name], :nap=> params[:nap],:bedtime => params[:bedtime])
			url = "http://#{params[:name]}.herokuapp.com"
			Rails.logger.info "ping #{Time.now} #{url}"
			Net::HTTP.get_response(URI.parse(url))
			render json: {}, status: 200
		end
	end

	def decaf
		@site = Site.find_by_name(params[:name])
		if @site
			@site.destroy
			render json: @site
		else
			render json: {}, status: 201
		end
	end

	def admin
		authenticate
		@sites = Site.all.order("id asc")
	end
end
