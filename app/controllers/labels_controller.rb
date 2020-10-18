class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = label.all
  end

  def create
    @label = Label.new(label_params)
    if params[:back]
      render :new
    else
      if @label.save
        redirect_to root_path, notice: "CreateLabel!"
      else
        render :new
      end
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice:"Deleted！"
  end

  def edit
  end

  def new
    @label = label.new
  end

  def show
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: "Edited！"
    else
      render :edit
    end
  end


  private
  def label_params
    params.require(:label).permit(:content)
  end
  def set_label
    @label = label.find(params[:id])
  end
end
