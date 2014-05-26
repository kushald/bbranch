class IfscsController < ApplicationController
  def index
  	#@bank_names = NeftBank.limit(10).collect(&:name)
  	@bank_names = Ifsc.group(:name).collect(&:name)
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
  	@branches = Ifsc.where("neft_bank_id = ? AND state = ?", bank_id, params[:state]).page(params[:page]).per(20)
  	@districts = @branches.collect {|br| br.district}.sort.uniq
  end

  def search_by_district
  	redirect_to "/" unless valid_bank_name(params[:bank_name])
  	bank_id = NeftBank.where("name like (?)", params[:bank_name].gsub("_",' ').downcase).first.try(:id)
  	@branches = Ifsc.where("neft_bank_id = ? AND state = ? AND district = ?", bank_id, params[:state].upcase, params[:district].upcase)
  							.page(params[:page]).per(10)
  end

  def search_by_branch
  	if valid_bank_name(params[:bank_name]) && valid_state_name?(params[:bank_name], params[:state]) && valid_district_name?(params[:bank_name], params[:state], params[:district]) 
  		@branch = get_by_branch(params[:bank_name], params[:state], params[:district], params[:branch])
  		return
  	end
  	redirect_to '/'
  end

  private

  def valid_bank_name(name)
  	NeftBank.all_banks(params[:bank_name].gsub("_",' '))
  end

  def valid_state_name?(bank, state)
  	Ifsc.where("name like ? and state = ?", "%bank%", state).present?
  end

  def valid_district_name?(bank, state, district)
  	Ifsc.where("name like ? and state = ? and district = ?", "%#{bank}%", state, district).present?
  end

  def get_by_branch(bank, state, district, branch)
  	Ifsc.where("name like ? and state = ? and district = ? and branch = ?", "%#{bank}%", state, district, branch).first
  end

  def bank_name(name)
  	bank_id = NeftBank.where("name like (?)", name.gsub("_",' ').downcase).first.try(:id)
  	bank_id.present? ? Ifsc.where(neft_bank_id: bank_id).page(params[:page]).per(20) : nil
  end
end