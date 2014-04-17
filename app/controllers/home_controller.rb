class HomeController < ApplicationController
	def index
	end

	def register
		site = Site.where(:name => params[:name])
		if site = site.first
			render json: {}, status: 201
		else
			site = Site.where(:name => params[:name]).create
			ping_register site.name
			render json: {}, status: 200
		end
	end

	def reload
		ping_all
		render :index
	end
end
