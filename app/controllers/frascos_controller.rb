class FrascosController < ApplicationController
  before_action :set_frasco, only: [:show, :edit, :update, :destroy]

  # GET /frascos
  # GET /frascos.json
  before_filter :authenticate_usuario!
#  before_action :verificar_usuario_autenticado
before_action :verificar_perfil_administrador

include CodigosGenerales
layout :colocar_layout

def index
  @frascosUsr = []
  if (params[:paciente])
    if (params[:paciente][:fInicio].present? && params[:paciente][:fFin].present?)
      if Date.parse(params[:paciente][:fInicio]) <= Date.parse(params[:paciente][:fFin])
        array_frascos_usuario(2)

        if @frascosUsr.length == 0
          flash.now[:alert] = "No se crearon frascos en el intervalo de tiempo"
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



def entregados    
  @frascosUsr = []
  if (params[:paciente])
    if (params[:paciente][:fInicio].present? && params[:paciente][:fFin].present?)
      if Date.parse(params[:paciente][:fInicio]) <= Date.parse(params[:paciente][:fFin])
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

def filtro_por_fecha (fecParam)
  dMin =Date.parse(params[:paciente][:fInicio])
  dMax =Date.parse(params[:paciente][:fFin])
  dEnt =Date.parse(fecParam)
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
    

    if(Integer(params[:noRet]) == 0)
      actualizar = Time.new
      puts actualizar.strftime("%Y-%m-%d")
      actualizar = actualizar.strftime("%Y-%m-%d")
      mensaje = 'Se ha entregado el frasco'
    else
      actualizar = 'NO RETIRO'
      mensaje = 'Se ha cambiado el estado del frasco a NO RETIRADO'
    end
    buenosFrascos.insert(indice,actualizar)
    puts buenosFrascos
    @frasco.frascos = buenosFrascos
    @frasco.saltar_validacion_usuario = true
    @frasco.validar_usuario_nuevo = false
    respond_to do |format|
      if @frasco.save
        format.html { redirect_to frasco_path(params[:id]), notice: mensaje }
        format.json { render :show, status: :ok, location: @frasco }
      else
        format.html { render :show }
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
    puts "Ando actualizando"
  end

  # DELETE /frascos/1
  # DELETE /frascos/1.json
  def destroy
    elFrascos = obtener_frascos_string(params[:id])
    puts elFrascos
    sub1 = elFrascos.slice(0,elFrascos.index("$"+params[:idFra]+"#"))
    elFrascos = elFrascos.slice(elFrascos.index("$"+params[:idFra]+"#")+1,elFrascos.size)
    elFrascos = elFrascos.slice(elFrascos.index("#")+1,elFrascos.size)
    if(elFrascos.index("#"))
      elFrascos = elFrascos.slice(elFrascos.index("#")+1,elFrascos.size)
      if(elFrascos.index("$"))
        sub2 = elFrascos.slice(elFrascos.index("$"),elFrascos.size)
      else
        sub2=""
      end
    end
    puts sub1
    puts sub2
    elFrascos = sub1+sub2
    puts elFrascos
    @frasco.frascos = elFrascos
    @frasco.saltar_validacion_usuario = true
    @frasco.validar_usuario_nuevo = false
    respond_to do |format|
      if @frasco.save
        format.html { redirect_to frascos_eliminar_path, notice: "Se ha eliminado el frasco #{params[:idFra]} del paciente #{params[:id]}" }
        format.json { render :eliminar, status: :ok, location: @frasco }
      else
        format.html { render :eliminar}
        format.json { render json: @frasco.errors, status: :unprocessable_entity }
      end
    end
  end

  def eliminar
    @frascosUsr = [] 
    if (params[:paciente])
      if (params[:paciente][:pacID].present?)
        if (params[:paciente][:pacID].to_i > 0)
          user = Usuario.select("id,nombre,apellido,frascos").where(rol:3, id:params[:paciente][:pacID].to_i)
          user.each do |u| 
            @frascosUsr.push(obtener_frascos_usuario(u,0))
          end
          @frascosUsr = @frascosUsr.compact
          flash.now[:alert] = "No existe el usuario o todos sus frascos fueron entregados." if (@frascosUsr.length == 0)             
        else
          flash.now[:alert] = "Entrada inválida"
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

  def no_retirados
    @frascosUsr = []
    if (params[:paciente])
      if (params[:paciente][:pacID].present?)
        if (params[:paciente][:pacID].to_i > 0)
          user = Usuario.select("id,nombre,apellido,frascos").where(rol:3, id:params[:paciente][:pacID].to_i)
          user.each do |u| 
            @frascosUsr.push(obtener_frascos_usuario(u,3))
          end
          @frascosUsr = @frascosUsr.compact
          flash.now[:alert] = "No existe el usuario o no posee frascos en espera de entrega." if (@frascosUsr.length == 0)             
        else
          flash.now[:alert] = "Entrada inválida"
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

  def obtener_frascos_usuario(user,criterio)
      #criterio =>  -1: entregados, 0: no entregados (preparados+no retirados), 1: todos los frascos, 2:solo preparados(fecha) 3:solo preparados(id)
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
      sus = 0
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
          if criterio == 1 && creado == 1
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
          elsif criterio == 2 && creado == 1 && entregado == 0 && filtro_por_fecha(fechaCrea)
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado}) 
          elsif criterio == 3 && creado == 1 && entregado == 0
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado}) 
          elsif criterio == 0 && creado == 1 && entregado != 1
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})           
          elsif criterio == -1 && creado == 1 && entregado == 1 && filtro_por_fecha(fechaEntr)
            frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
          end
        else
          sus = 1
        end
      end
      if !frascosList.empty?
        return {:id => user.id, :nomAp => user.apellido+", "+user.nombre, :susp=>sus, :frascos=> frascosList}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_frasco
      @frasco = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frasco_params
      params.fetch(:paciente, {})
    end

    def obtener_frascos_string(per)
      return Usuario.select("frascos").where(rol:3, id:per).take.frascos
    end

  end