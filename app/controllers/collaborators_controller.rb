class CollaboratorsController < ApplicationController
  def create
  	Collaborator.create(wiki_id: params[:wiki_id], user_id: params[:user_id])
  	redirect_to :back
  end

  def new
  	@collaborator = Collaborator.new.find_by(user_id: user.id, wiki_id: params[:wiki_id])
  end

  def index
  	@wiki = Wiki.find(params[:wiki_id])
  	@users = User.all
  end

  def destroy
  	Collaborator.find_by(user_id: params[:id], wiki_id: params[:wiki_id]).delete
    redirect_to :back
  end
end
