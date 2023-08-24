setwd("C:/Users/karen/OneDrive/Escritorio/KAREN/DOCUMENTOS/10mo SEMESTRE/Programación/scrip/Repositorio_1")
library(tidyverse)
library(ggplot2)

url <- "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto19/CasosActivosPorComuna_std.csv"
Casos_Activos <- read_csv(url)

#¿Qué proporción de las comunas ha tenido en algún momento más de 50 casos por cada 100.000 habitantes?



class(Casos_Activos$Poblacion)
class(Casos_Activos$`Casos activos`)


# casos por cada 100,000 habitantes : mutate
Casos_Activos <- Casos_Activos %>%
  mutate(activos_cada_100mil = (`Casos activos`/ Poblacion) * 100000)


# comunas con más de 50 casos por cada 100,000 habitantes :filter
comunas_mas_50 <- Casos_Activos%>%
  filter(activos_cada_100mil > 50) %>%
  distinct(Comuna)

# Calculo proporción de comunas
proporcion_comunas_mas_de_50 <- nrow(comunas_mas_50) / nrow(Casos_Activos)

comunas_filtradas <- merge(Casos_Activos, comunas_mas_50, by = "Comuna", all.x = TRUE)

filtro_comunas <- Casos_Activos %>%
  filter(Comuna != "Total") %>%
  left_join(comunas_mas_50, by = "Comuna")



#Genera un dataframe, donde aparezca para cada comuna que haya tenido sobre 50 casos por cada 100.000 habitantes, cuantos días ha tenido sobre ese valor.


#Genera una tabla con las comunas que han tenido sobre 50 casos por cada 100.000 habitantes y de esas comunas crea una variable que sea la prevalencia máxima de dicha comuna.
