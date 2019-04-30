class Admin::ProducerController < ApplicationController
  def new
    @producer = Producer.new
    @page_title = 'Crear nueva destilería'
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:notice] = "Destilería #{@producer.name} creada correctamente."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nueva destilería'
      render :action => 'new'
    end
  end

  def edit
    @producer = Producer.find(params[:id])
    @page_title = 'Editar destilería'
  end

  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(producer_params)
      flash[:notice] = "Destilería #{@producer.name} actualizada correctamente."
      redirect_to :action => 'show', :id => @producer
    else
      @page_title = 'Editar destilería'
      render :action => 'edit'
    end
  end

  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "Destilería #{@producer.name} eliminada correctamente."
    redirect_to :action => 'index'
  end

  def show
    @producer = Producer.find(params[:id])
    @page_title = @producer.name
  end
  def show
    	@producer = Producer.find(params[:id])
    	@page_title = @producer.name
  end

  def index
	@producers = Producer.all
	@page_title = 'Listado de destilerías'
  end

	private
		def producer_params
			params.require(:producer).permit(:name)
		end
end
