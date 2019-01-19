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
