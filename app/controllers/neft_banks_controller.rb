class NeftBanksController < ApplicationController
  def index
  	@nefts = NeftBank.all
  end
end
