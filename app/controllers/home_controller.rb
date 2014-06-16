class HomeController < ApplicationController
	def index
		@entretains = Entretain.all
		
	end
end
