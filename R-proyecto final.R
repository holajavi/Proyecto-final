# install.packages('rvest')
# Usando la librería rvest
library('rvest')

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

#==================== falabella.com ====================#

# 1.- Se realiza la búsqueda y se copia la URL generada
# 2.- Se asigna la url generada a la variable paginaFalabellaCom
paginaFalabellaCom <- 'https://www.falabella.com/falabella-cl/search?Ntt=smarphone&sortBy=5'
webpage <-read_html(paginaFalabellaCom)

webpage <- html_nodes(webpage,".pod_item")


#########No hay bajada de informacion directa desde falabella.com######










# Usando la librería rvest
library('rvest')

# Leyendo el HTML del archivo
webpage <- read_html(archivo)


#=================TiendaPet.cl================#


# Crea data.frame vacio
productos <- data.frame()

for(i in 1:40){
  # 1.- Se realiza la búsqueda y se copia la URL generada
  # 2.- Se asigna la url generada a la variable paginaTiendaPet
  paginaTiendaPet <- paste('https://www.tiendapet.cl/catalogo/buscar/',i,'?term=alimento+perros',sep = "")
  
  print(paginaTiendaPet)
  
  webpage <-read_html(paginaTiendaPet)
  
  
  # Extracción del texto contenido en la clase 
  contenidoTiendaPet <- html_nodes(webpage,'.block-producto')
  
  contenidoTiendaPet <- html_nodes(contenidoTiendaPet,'.catalogo_click_detail')
  
  #Extracci?n links p?gina
  links<-html_attr(contenidoTiendaPet,"href")
  
  
  
  #========Extraccion datos de cada links===========#
  
  for(link in links){
    print(link)
    DatosproductosTienda<- link
    
    datostienda <-read_html(DatosproductosTienda)
    
    # Extracción de marcas alimentos 
    marca <- html_nodes(datostienda, "[itemprop=brand]")
    marca <- html_text(marca)
    
    # Extracción de precios alimento 
    precioProductos <- html_nodes(datostienda,'select')
    precioProductos <- html_nodes(precioProductos, 'option')
    precios <- html_attr(precioProductos, 'data-pricereal')
    
    #Eliminando los puntos de los precios
    precios <- gsub("[.]","",precios)
    
    
    
    # Extraccion kilos
    kilos <- html_text(precioProductos)
    
    # Pasando todas las palabras a minÃºsculas
    kg <- tolower(kilos)
    
    #Eliminando los puntos de los kilos
    kg <- gsub("[.]","",kg)
    
    #Extraccion nombre producto
    nombreProducto <- html_nodes(datostienda, "[itemprop=name]")
    nombreProducto <- html_text(nombreProducto)
    
    # Este if es para los productos sin stoc
    if(length(kg)!=0){
      
      # Se recorren los productos
      for (j in 1:length(kg)) {
        # Se crea data.frame que contine el valor y peso de un producto
        df <- data.frame(marca = marca, producto = nombreProducto, kg = kg[j], precio = precios[j])
        
        # Se junta la información de un producto con el de todos los productos
        productos <- rbind(productos,df)
      }
    }else{
      # Los productos sin stock se guardan con el kilo y el precio con NA
      df <- data.frame(marca = marca, producto = nombreProducto, kg = NA, precio = NA)
      
      # Se junta la información del producto sin stock con todos los productos
      productos <- rbind(productos,df)
      
    }
  }
}

    #guardar la informacion en cvs
    write.csv(productos, file = "alimentoperros")


