class Admin::LiquorController < ApplicationController
  def new
    load_data
    @liquor = Liquor.new
    @page_title = 'Crear nuevo licor'
  end

  def create
    @liquor = Liquor.new(liquor_params)
    if @liquor.save
      flash[:notice] = "Licor #{@liquor.name} creado correctamente."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear nuevo licor'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @liquor = Liquor.find(params[:id])
    @page_title = 'Editar licor'
  end

  def update
    @liquor = Liquor.find(params[:id])
    if @liquor.update_attributes(liquor_params)
      flash[:notice] = "Licor #{@liquor.name} actualizado correctamente."
      redirect_to :action => 'show', :id => @liquor
    else
      load_data
      @page_title = 'Editar licor'
      render :action => 'edit'
    end
  end

  def destroy
    @liquor = Liquor.find(params[:id])
    @liquor.destroy
    flash[:notice] = "Licor #{@liquor.name} eliminado correctamente."
    redirect_to :action => 'index'
  end

  def show
    @liquor = Liquor.find(params[:id])
    @page_title = @liquor.name
  end

  def index
    sort_by = params[:sort_by]
    @liquors = Liquor.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Listado de licores'
  end

  private

    def load_data
      @suppliers = Supplier.all
      @producers = Producer.all
    end

    def liquor_params
      params.require(:liquor).permit(:name, :producer_id, :produced_at, { :supplier_ids => [] },
                                     :blurb, :graduation, :price, :cover_image)
    end
end
