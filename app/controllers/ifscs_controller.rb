class IfscsController < ApplicationController
  def index
  	redirect_to "/ifsc/axis_bank"
  	@bank_names = NeftBank.limit(10).collect(&:name)
  end

  def search_by_name
  	redirect_to "/" unless valid_bank_name(params[:bank_name])
  	@branches = bank_name(params[:bank_name])
  	@states = @branches.collect {|br| br.state}.sort.uniq
  end

  def search_by_state
  	#bank_id = NeftBank.where("name like (?)", params[:name].gsub("_",' ').downcase).first.try(:id)
  	redirect_to "/" unless valid_bank_name(params[:bank_name])
  	bank_id = NeftBank.where("name like (?)", params[:bank_name].gsub("_",' ').downcase).first.try(:id)
  	@branches = Ifsc.where("neft_bank_id = ? AND state = ?", bank_id, params[:state])
  	@districts = @branches.collect {|br| br.district}.sort.uniq
  end

  def search_by_district
  	redirect_to "/" unless valid_bank_name(params[:bank_name])
  	bank_id = NeftBank.where("name like (?)", params[:bank_name].gsub("_",' ').downcase).first.try(:id)
  	@branches = Ifsc.where("neft_bank_id = ? AND state = ? AND district = ?", bank_id, params[:state].upcase, params[:district].upcase)
  end

  def search_by_branch
  end

  private

  def valid_bank_name(name)
  	NeftBank.all_banks(params[:bank_name].gsub("_",' '))
  end

  def bank_name(name)
  	bank_id = NeftBank.where("name like (?)", name.gsub("_",' ').downcase).first.try(:id)
  	bank_id.present? ? Ifsc.where(neft_bank_id: bank_id) : nil
  end
end
