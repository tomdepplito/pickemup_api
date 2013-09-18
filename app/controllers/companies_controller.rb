class CompaniesController < ApplicationController
  require 'string'
  respond_to :json, :html
  def update
    company = Company.find("company_id: #{params['company']['company_id']}")
    if company && company.update_attributes(company_params)
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def create
    company = Company.create(company_params)
    if company && company.save
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def destroy
    company = Company.find("company_id: #{params['company']['company_id']}")
    if company && company.destroy
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  private

  def company_params
    modified_params = params.require(:company).permit!.except(:last_sign_in_at, :current_sign_in_at,
                                                              :last_sign_in_ip, :current_sign_in_ip)
  end
end
