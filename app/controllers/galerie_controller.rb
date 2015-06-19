class GalerieController < ApplicationController
  def index
    @images = Image.all
    @tags = [] << Image.all.map { |x| x.tag.split(' ')}
    @tags = @tags.flatten.uniq.sample(3)
    @exemple = @tags.join(', ')
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
    @recherche = params[:tag].split(' ')
    @image = []
    if params[:tag] == "" 
      redirect_to root_path
    else
      @recherche.each do |r|
        @image << Image.where("tag like ?", "%#{r}%")
      end
    @images = @image.flatten
    @tags = [] << Image.all.map { |x| x.tag.split(' ')}
    @tags = @tags.flatten.uniq.sample(3)
    @exemple = @tags.join(', ')
    render 'index'
    end
  end

  def telecharger
  @telecharger= Image.find(params[:id])

  send_file @telecharger.avatar.path,
              :filename => @telecharger.avatar_file_name,
              :type => @telecharger.avatar_content_type,
              :disposition => 'attachment'
end

  private

  def params_image
    params.require(:upload).permit(:titre, :tag, :avatar)
  end

end
