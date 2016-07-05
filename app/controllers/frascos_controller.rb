class FrascosController < ApplicationController
  before_action :set_frasco, only: [:show, :edit, :update, :destroy]

  # GET /frascos
  # GET /frascos.json


  def index
    numFrasco = 0
    fechaCrea = ""
    fechaEntr = ""
    @frascosUsr = []
    frascosList = []
    frascoActual = ""
    entregado = 0
    creado = 0
    total = Usuario.where(rol:3).count
    for e in 1..total
      @users = Usuario.select("id,nombre,apellido,frascos").where(rol:3, id:e).take(10)
      frascosList = []
      if !(@users.empty?)
        frascoActual = @users.first.frascos
        while (frascoActual.index("$"))
          entregado = 1
          creado = 0
          numFrasco = frascoActual.slice(1,frascoActual.index("#")-1)
          puts numFrasco
          frascoActual = frascoActual.slice(frascoActual.index("#")+1,frascoActual.size)
          if (frascoActual.index("#"))
            fechaCrea = frascoActual.slice(0,frascoActual.index("#"))
            puts fechaCrea
            frascoActual = frascoActual.slice(frascoActual.index("#")+1,frascoActual.size)
            if (frascoActual.index("$"))
              fechaEntr = frascoActual.slice(0,frascoActual.index("$"))
              frascoActual = frascoActual.slice(frascoActual.index("$"),frascoActual.size)
            else
              fechaEntr = frascoActual
            end
            puts fechaEntr
            if fechaCrea != ""
              creado = 1
              if fechaEntr == "NO RETIRO" || fechaEntr == ""
                entregado = 0
              end
            end            
            if creado == 1 && entregado ==0
              frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea})
            end            
          end
        end
        if !frascosList.empty?
          @frascosUsr.push({:id => @users.first.id, :nomAp => @users.first.apellido+", "+@users.first.nombre, :frascos=> frascosList})
        end
      end
    end
    @frascosUsr = @frascosUsr.sort_by { |hsh| hsh[:nomAp] }
    @frascosUsr = @frascosUsr.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /frascos/1
  # GET /frascos/1.json
  def show

  end

  # GET /frascos/new
  def new
    @frasco = Frasco.new
  end

  # GET /frascos/1/edit
  def edit
  end

  # POST /frascos
  # POST /frascos.json
  def create

    @frasco = Frasco.new(frasco_params)

    respond_to do |format|
      if @frasco.save
        format.html { redirect_to @frasco, notice: 'Frasco was successfully created.' }
        format.json { render :show, status: :created, location: @frasco }
      else
        format.html { render :new }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frascos/1
  # PATCH/PUT /frascos/1.json
  def update
    respond_to do |format|
      if @frasco.update(frasco_params)
        format.html { redirect_to @frasco, notice: 'Frasco was successfully updated.' }
        format.json { render :show, status: :ok, location: @frasco }
      else
        format.html { render :edit }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frascos/1
  # DELETE /frascos/1.json
  def destroy
    @frasco.destroy
    respond_to do |format|
      format.html { redirect_to frascos_url, notice: 'Frasco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frasco
      @frasco = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frasco_params
      params.fetch(:frasco, {})
    end
  end
