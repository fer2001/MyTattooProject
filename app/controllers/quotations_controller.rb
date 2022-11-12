class QuotationsController < ApplicationController

  def show
    @quotations = Quotation.find(params[:id])
    authorize @quotation
  end

  def new
    @quotation = Quotation.new
    @artist = User.find(params[:artist_id])
    authorize @quotation
  end

  def create
    @artist = User.find(params[:artist_id])
    @quotation = Quotation.new(quotations_params)
    @quotation.artist = @artist
    @quotation.user = current_user
    if @quotation.save
      redirect_to root_path # redirecionar para o chat de conversa
    else
      render :new, status: :unprocessable_entity
    end
    authorize @quotation
  end

  def destroy
    @quotation = quotation.find(params[:id])
    @quotation.delete
    redirect_to quotations_path, status: :see_other # redirecionar para suas quotations
    authorize @quotation
  end

  private

  def quotations_params
    params.require(:quotation).permit(:size, :placement, :description, :date, photos: [])
  end
end
