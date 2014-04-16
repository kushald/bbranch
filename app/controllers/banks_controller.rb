class BanksController < ApplicationController
	def index
		@banks = Bank.where("state=? || bank=? || district=?", params[:state], params[:bank_id], params[:district])
	end
end
