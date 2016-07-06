class FrascosController < ApplicationController
  before_action :set_frasco, only: [:show, :edit, :update, :destroy]

  # GET /frascos
  # GET /frascos.json

  include CodigosGenerales
  layout :colocar_layout

  def index
    array_frascos_usuario(0)
  end

  def entregados    
    @frascosUsr = []
    if (params[:frasco])
      if (params[:frasco][:fInicio].present? && params[:frasco][:fFin].present?)
        if Date.parse(params[:frasco][:fInicio]) <= Date.parse(params[:frasco][:fFin])
          array_frascos_usuario(-1)
          
          if @frascosUsr.length == 0
            flash.now[:alert] = "No existen entregas en el intervalo de tiempo"
          end   
        else
          flash.now[:alert] = "Fechas inválidas"
          @frascosUsr = []
        end  
      else
        flash.now[:alert] = "No ha colocado la información"
        @frascosUsr = []
      end   
    else
      @frascosUsr = []
    end
  end

  def array_frascos_usuario(modo)
    users = Usuario.select("id,nombre,apellido,frascos").where(rol:3) 
    @frascosUsr = []
    users.each do |u|      
      @frascosUsr.push(obtener_frascos_usuario(u,modo))
    end
    @frascosUsr = @frascosUsr.compact
    @frascosUsr = @frascosUsr.sort_by { |hsh| hsh[:nomAp] }
    @frascosUsr = @frascosUsr.paginate(:page => params[:page], :per_page => 10)

  end



  def filtro_por_fecha (fecEnt)
    dMin =Date.parse(params[:frasco][:fInicio])
    dMax =Date.parse(params[:frasco][:fFin])
    dEnt =Date.parse(fecEnt)
    return dMin <= dEnt && dEnt <= dMax
  end

  # GET /frascos/1
  # GET /frascos/1.json
  def show
    @frascoU = obtener_frascos_usuario(Usuario.select("id,nombre,apellido,frascos").where(id:params[:id]).take,1)
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
    buenosFrascos = obtener_frascos_string(params[:id])
    indice = buenosFrascos.index("#", buenosFrascos.index("#", buenosFrascos.index("$"+params[:idFra]+"#"))+1)+1
    puts indice
    time = Time.new
    puts time.strftime("%Y-%m-%d")
    buenosFrascos.insert(indice,time.strftime("%Y-%m-%d"))
    puts buenosFrascos
    @frasco.frascos = buenosFrascos
    respond_to do |format|
      if @frasco.save
        format.html { redirect_to frasco_path(params[:id]), notice: 'Se ha entregado el frasco' }
        format.json { render :show, status: :ok, location: @frasco }
      else
        format.html { render :show }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
    puts "Ando jodiendo"
  end

  # DELETE /frascos/1
  # DELETE /frascos/1.json
  def destroy
    elFrascos = obtener_frascos_string(params[:id])
    indice1 = elFrascos.index("$"+params[:idFra]+"#")
    indice2 = elFrascos.index("#", elFrascos.index("#", elFrascos.index("$"+params[:idFra]+"#"))+1)+10
    puts indice
    
    elFrascos.insert(indice,time.strftime("%Y-%m-%d"))
    puts elFrascos
    @frasco.frascos = elFrascos

    @frasco.destroy
    respond_to do |format|
      format.html { redirect_to frascos_url, notice: 'Frasco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frasco
      puts "SET FRASCO CÑ #{}"
      @frasco = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frasco_params
      params.fetch(:frasco, {})
    end

    def obtener_frascos_string(per)
      return Usuario.select("frascos").where(rol:3, id:per).take.frascos
    end

    def obtener_frascos_usuario(user,criterio)
      #criterio => 1: todos los frascos, 0: solo preparados, -1: entregados
      numFrasco = 0
      fechaCrea = ""
      fechaEntr = ""
      frascosList = []
      frascoActual = ""
      entregado = 0
      creado = 0      
      #user = Usuario.select("id,nombre,apellido,frascos").where(rol:3, id:e)
      frascosList = []
      frascoActual = user.frascos
      while (frascoActual.index("$"))
        entregado = 0
        creado = 0
        numFrasco = frascoActual.slice(1,frascoActual.index("#")-1)
        #puts numFrasco
        frascoActual = frascoActual.slice(frascoActual.index("#")+1,frascoActual.size)
        if (frascoActual.index("#"))
          fechaCrea = frascoActual.slice(0,frascoActual.index("#"))
          #puts fechaCrea
          frascoActual = frascoActual.slice(frascoActual.index("#")+1,frascoActual.size)
          if (frascoActual.index("$"))
            fechaEntr = frascoActual.slice(0,frascoActual.index("$"))
            frascoActual = frascoActual.slice(frascoActual.index("$"),frascoActual.size)
          else
            fechaEntr = frascoActual
          end
          #puts fechaEntr
          if fechaCrea != ""
            creado = 1
            if fechaEntr == "NO RETIRO" || fechaEntr == "SUSPENDIO" 
              entregado = -1
            elsif  fechaEntr == ""
              entregado = 0
            else
              entregado = 1
            end
          end            
          if criterio == 1
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
          elsif criterio == 0 && creado == 1 && entregado != 1
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
          elsif criterio == -1 && creado == 1 && entregado == 1 && filtro_por_fecha(fechaEntr)
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
          end
        end
      end
      if !frascosList.empty?
        return {:id => user.id, :nomAp => user.apellido+", "+user.nombre, :frascos=> frascosList}
      end
    end

  end
