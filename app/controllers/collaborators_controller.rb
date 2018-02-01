class CollaboratorsController < ApplicationController

  def index
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    wiki.users << user unless wiki.users.include?(user)
    
    redirect_to wikis_path
  end


  def destroy
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:id])
    wiki.users.delete(user)
    redirect_to wikis_path
  end

end
