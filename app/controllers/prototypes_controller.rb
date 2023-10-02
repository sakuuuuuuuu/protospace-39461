class PrototypesController < ApplicationController
  # before_action :prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_prototype, except: [:index, :new, :create]
  
  
  def index
    @prototypes = Prototype.includes(:user)
    @Prototypes = Prototype.all
  end

  def new
      @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
    
  end

  def edit
    @prototype = Prototype.find(params[:id])
    contributor_confirmation
  end

  def update
    #  @prototype.update(prototype_params)
    #   redirect_to prototype_path(@prototype)
    @prototype = Prototype.find(params[:id])    

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
      redirect_to root_path
      
      # if @prototype.destroy
      #   redirect_to root_path
      # else
      #   redirect_to root_path
      # end
    
  end  


  # def create
  #   if Prototype.create(prototype_params)
  #   redirect_to root_path
  #   else
  #   render :create, status: :unprocessable_entity
  #   end
  # end

  private
  def prototype_params
    # params.require(:prototype).permit(:name, :image, :text).merge(user_id: current_user.id)
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end  
end
