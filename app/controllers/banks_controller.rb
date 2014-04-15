class BanksController < ApplicationController
	def index
		@banks = Bank.where("state=? || bank=? || district=?", params[:state], params[:bank], params[:district])
	end
end
