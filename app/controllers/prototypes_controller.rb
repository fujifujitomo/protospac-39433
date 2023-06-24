class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :show, :create]
  before_action :move_to_index, except: [:index, :show, :create,:new]
  before_action :authenticate_user!, only: [:new]

  def index
    @user = current_user
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path(@prototype)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path(@prototype) 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if current_user == @prototype.user
      @prototype.destroy
      redirect_to root_path
    else
      redirect_to new_user_session_path
  end
end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to new_user_session_path
    end
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])if params[:id]
  end

end
