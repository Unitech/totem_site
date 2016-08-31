class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote, :participate, :stop_participating]
  before_action :authenticate_user!,except: [:index, :show]

  def index
    if params[:tag]
      @pins = Pin.tagged_with(params[:tag])
    else
      @pins = Pin.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
    @pin = current_user.administered_pins.build
  end

  def create
    @pin = current_user.administered_pins.build(pin_params)

    if @pin.save
      redirect_to pin_path(@pin), notice: "Merci ton projet a bien été créé"
    else
      redirect_to new_pin_path, notice: "Ton projet n'a pas pu être créé"
    end
  end

  def edit
    redirect_to pin_path(@pin) unless current_user == @pin.admin
  end

  def update
    if @pin.update(pin_params)
      redirect_to pin_path(@pin), notice: "Projet modifié avec succès"
    else
      redirect_to edit_pin_path(@pin), notice: "Ton projet n'a pas pu être modifié"
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_path
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end

  def participate
    current_user.participate(@pin)
    redirect_to pin_path(@pin)
  end

  def stop_participating
    current_user.stop_participating(@pin)
    redirect_to pin_path(@pin)
  end

  private
  def pin_params
    params.require(:pin).permit(:title,:description, :image, :tag_list)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
