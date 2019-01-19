# Usando la librer√???a rvest
library('rvest')

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

#==================== falabella.com ====================#

# 1.- Se realiza la b√∫squeda y se copia la URL generada
# 2.- Se asigna la url generada a la variable paginaFalabellaCom
paginaFalabellaCom <- 'https://www.falabella.com/falabella-cl/search?Ntt=smarphone&sortBy=5'
webpage <-read_html(paginaFalabellaCom)

webpage <- html_nodes(webpage,".pod_item")


#########No hay bajada de informacion directa desde falabella.com######











# Usando la librer√???a rvest
library('rvest')

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

#=================TiendaPet.cl================#

# 1.- Se realiza la b√∫squeda y se copia la URL generada
# 2.- Se asigna la url generada a la variable paginaTiendaPet
paginaTiendaPet <- paste('https://www.tiendapet.cl/catalogo/buscar/',i,'?term=alimento+perros',sep = "")

webpage <-read_html(paginaTiendaPet)

# Extracci√≥n del texto contenido en la clase 
contenidoTiendaPet <- html_nodes(webpage,'.block-producto')

contenidoTiendaPet <- html_nodes(contenidoTiendaPet,'.catalogo_click_detail')

#ExtracciÛn links p·gina
links<-html_attr(contenidoTiendaPet,"href")



#========Extraccion datos de cada links===========#

datoslink <- 'https://www.tiendapet.cl/catalogo/producto/1020/taste-of-the-wild-wetlands-dry'

# Extracci√≥n de marcas alimentos 
marca <- html_nodes(datostienda, "[itemprop=brand]")
marca <- html_text(marca)

# Extracci√≥n de precios alimento 
precioProductos <- html_nodes(datostienda,'select')
precioProductos <- html_nodes(precioProductos, 'option')
precios <- html_attr(precioProductos, 'data-pricereal')

#Eliminando los puntos de los precios
precios <- gsub("[.]","",precios)

# Extraccion kilos
kilos <- html_text(precioProductos)

#Extraccion nombre producto
nombreProducto <- html_nodes(datostienda, "[itemprop=name]")
nombreProducto <- html_text(nombreProducto)

union <- c(marca,nombreProducto,kilos,precios)
