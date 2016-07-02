class MenuNivel0sController < ApplicationController
  before_action :set_menu_nivel0, only: [:show, :edit, :update, :destroy]

  # GET /menu_nivel0s
  # GET /menu_nivel0s.json
  def index
    @menu_nivel0s = MenuNivel0.all
  end

  # GET /menu_nivel0s/1
  # GET /menu_nivel0s/1.json
  def show
  end

  # GET /menu_nivel0s/new
  def new
    @menu_nivel0 = MenuNivel0.new
  end

  # GET /menu_nivel0s/1/edit
  def edit
  end

  # POST /menu_nivel0s
  # POST /menu_nivel0s.json
  def create
    @menu_nivel0 = MenuNivel0.new(menu_nivel0_params)

    respond_to do |format|
      if @menu_nivel0.save
        format.html { redirect_to @menu_nivel0, notice: 'Menu nivel0 was successfully created.' }
        format.json { render :show, status: :created, location: @menu_nivel0 }
      else
        format.html { render :new }
        format.json { render json: @menu_nivel0.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_nivel0s/1
  # PATCH/PUT /menu_nivel0s/1.json
  def update
    respond_to do |format|
      if @menu_nivel0.update(menu_nivel0_params)
        format.html { redirect_to @menu_nivel0, notice: 'Menu nivel0 was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_nivel0 }
      else
        format.html { render :edit }
        format.json { render json: @menu_nivel0.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_nivel0s/1
  # DELETE /menu_nivel0s/1.json
  def destroy
    @menu_nivel0.destroy
    respond_to do |format|
      format.html { redirect_to menu_nivel0s_url, notice: 'Menu nivel0 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_nivel0
      @menu_nivel0 = MenuNivel0.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_nivel0_params
      params[:menu_nivel0]
    end
end
