#guardo los datos del excel en un arreglo llamado celdas
       $celdas=[] 
       ex = Roo::Excel.new("#{Rails.root}/db/pacientes-de-Inmunoterapia.xls")

       ex.default_sheet = ex.sheets.first
       posC=0
       puts "MIGRACION DATA EXCEL A TABLAS"
       puts ex.last_row

      pos=''
      # for fila in (1 .. ex.last_row)
      #    for columna in (1 .. ex.last_column)
      #       $celdas[posC]= ex.cell(fila,columna)
      #       posC=posC+1
      #    end
      # end



#titulos_vinculos.each do |titulo|
#  MenuNivel0.create( titulo: titulo, usuario_id: u.id )
#end