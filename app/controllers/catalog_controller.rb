# coding: utf-8
class CatalogController < ApplicationController
  before_action :initialize_cart, :except => :show
  #before_action :require_no_user

  def show
    @liquor = Liquor.find(params[:id])
    @page_title = @liquor.name
  end

  def index
    @liquors = Liquor.order("liquors.id desc").includes(:suppliers, :producer).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catálogo'
  end

  def latest
    @liquors = Liquor.latest 5 # invoques "latest" method to get the five latest books
    @page_title = 'Últimos licores'
  end
end
