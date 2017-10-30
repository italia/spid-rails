class ContentController < ApplicationController
  before_action :validate_spid_session

  def show
    render 'content/show'
  end

end
