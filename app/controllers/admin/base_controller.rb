class Admin::BaseController < ApplicationController
  include Pundit
  
  before_filter :set_paper_trail_whodunnit
  #force_ssl if: :production?
  layout 'admin/application'
  before_action :authenticate_admin!

  def production?
    Rails.env.production?
  end

  def user_for_paper_trail
    admin_signed_in? ? current_admin.try(:email) : 'Unknown user'
  end
end
