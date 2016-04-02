class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
      @wikis = Wiki.visible_to(current_user).where(private: false)
      if current_user && (current_user.admin? || current_user.premium?)
        @wikis = Wiki.all
      end
  end

  def show
    @wiki = Wiki.find(params[:id])

    unless !@wiki.private || current_user.admin? || current_user.premium?
      flash[:alert] = "You must be a premium member to view private wikis."
      redirect_to wikis_path
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again later."
      render :new
    end
  end

  def edit
      @wiki = Wiki.find(params[:id])
      authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again later."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" has been deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end
