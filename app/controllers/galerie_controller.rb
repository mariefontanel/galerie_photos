class GalerieController < ApplicationController
	def index
    @image = Image.all
    @tags = [] << Image.all.map { |x| x.tag.split(' ')}
    @tags = @tags.flatten.uniq.sample(3)
  end

  def show
    @image = Image.find(params[:id])
  end

	def new
    @image = Image.new
	end

	def create
		@image = Image.create(params_image)
    if @image.save
      flash[:success] = "Votre image a bien été ajoutée dans la galerie."
      redirect_to root_path
    else
      flash[:error] = "Une erreur est survenue."
      render 'new'
    end
	end

  def recherche
    @image = Image.where("tag like ?", "%#{params[:tag]}%")
    @tags = [] << Image.all.map { |x| x.tag.split(' ')}
    @tags = @tags.flatten.uniq.sample(3)
    render 'index'
  end

  private

  def params_image
    params.require(:upload).permit(:titre, :tag, :avatar)
  end

end
