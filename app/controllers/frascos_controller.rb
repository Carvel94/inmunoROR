class FrascosController < ApplicationController
  before_action :set_frasco, only: [:show, :edit, :update, :destroy]

  # GET /frascos
  # GET /frascos.json


  def index
    @frascosUsr = []
    total = Usuario.where(rol:3).count
    for e in 1..total
      uActual = obtener_frascos_usuario(e,0)
      @frascosUsr.push(uActual) if uActual != nil
    end
    @frascosUsr = @frascosUsr.sort_by { |hsh| hsh[:nomAp] }
    @frascosUsr = @frascosUsr.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /frascos/1
  # GET /frascos/1.json
  def show
    @frascoU = obtener_frascos_usuario(params[:id],1)
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

    def obtener_frascos_usuario(e,todos)
      numFrasco = 0
      fechaCrea = ""
      fechaEntr = ""
      frascosList = []
      frascoActual = ""
      entregado = 0
      creado = 0      
      users = Usuario.select("id,nombre,apellido,frascos").where(rol:3, id:e)
      frascosList = []
      if !(users.empty?)
        frascoActual = users.first.frascos
        while (frascoActual.index("$"))
          entregado = 0
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
              if fechaEntr == "NO RETIRO"
                entregado = -1
              elsif  fechaEntr == ""
                entregado = 0
              else
                entregado = 1
              end
            end            
            if todos == 1
              frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
            elsif creado == 1 && entregado != 1
              frascosList.push({:idFra => numFrasco, :fCre =>fechaCrea, :fEnt =>fechaEntr, :status=>entregado})
            end
          end
        end
        if !frascosList.empty?
          return {:id => users.first.id, :nomAp => users.first.apellido+", "+users.first.nombre, :frascos=> frascosList}
        end
      else
        return nil
      end
    end

  end
