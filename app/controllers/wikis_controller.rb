class WikisController < ApplicationController
  def index
    if current_user.admin? || current_user.premium?
      @wikis = Wiki.all
    else
      @wikis = Wiki.where.not(private: true)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private];
     @wiki.user = current_user;

     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    authorize Wiki
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private];
    @wiki.user = current_user;

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
    end
  end


end
