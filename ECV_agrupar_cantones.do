#AGRUPAR CIUDADES a CANTONES

tab ciudad
label list(ciudad)
gen canton=ciudad

gen ciudad1 = strofreal(canton)

gen ciudad2 = ciudad1 if strlen(ciudad1) == 5
gen ciudad3 = "0"+ciudad2
replace ciudad1 = ciudad3 if strlen(ciudad1) == 5

gen canton1 = substr(ciudad1,1,4)

collapse (mean) servicio estadocivil salario discapacidad edad control empleo agua area, by (canton1)
br



GRAFICAS PROYECTO
Nombre: Ingrid Poma

 	                      *MODELO VARIABLES INSTRUMENTALES*  
*Mortalidad infantil cantonal desde salarios y servicios de salud publica*

---------------------------------------------------------------------------------------
*Directorios*

local DIR = "C:\Users\Ingrid\Desktop\Visualizacion"  
cd "`DIR'"



*Paquetes*

version 12.0
ssc install spmap
ssc install shp2dta
net install sg162, from(http://www.stata.com/stb/stb60)
net install st0292, from(http://www.stata-journal.com/software/sj13-2)
net install spwmatrix, from(http://fmwww.bc.edu/RePEc/bocode/s)
net install splagvar, from(http://fmwww.bc.edu/RePEc/bocode/s)


----------------------------------------------------------------------------------------
*1. MANIPULACION Y VISUALIZACION DE DATOS ESPACIALES*
-------------------------------------------------------------------------------------

shp2dta using OTEC, database(Data) coordinates(Coord) ///
genid(id) genc(c)

use Data, clear
describe


*Mapa Ecuador (sin informacion)
spmap using Coord, id(id) note("Ecuador2016")

*Eliminar Galapagos
drop if id==204|id==205|id==206
spmap using Coord, id(id) note("Ecuador")

*Importacion y transformacion datos de Excel a formato Stata*
clear all
import excel "C:\Users\Ingrid\Desktop\Visualizacion\Mapa.xlsx", firstrow
save "C:\Users\Ingrid\Desktop\Visualizacion\Mapa.dta", replace
use Mapa
describe

*Union bases*
use Data, clear
gen POLY_ID=id
merge 1:1 POLY_ID using Mapa, gen(union) force
assert union==3       //*Nos salio falso*/

*Verificacion Union*
drop union
save Mapa_shp.dta, replace



---------------------------------------------------------------------------------------
*REPRESENTACION: MAPAS*
---------------------------------------------------------------------------------------

use Mapa_shp.dta


*MAPA COMBINADO*

*Salarios*
spmap salario using Coord, id(id) fcolor(Blues2) point(data(Mapa_shp) xcoord(x_c)  ///
ycoord(y_c) deviation(TMI) fcolor(red) size(*0.6)) legend(size(medium) position(5)) ///
note("Ecuador 2016") 

*Salud publica*
spmap servicio using Coord, id(id) fcolor(Blues2) point(data(Mapa_shp) xcoord(x_c)  ///
ycoord(y_c) deviation(TMI) fcolor(red) size(*0.6)) legend(size(medium) position(5)) ///
note("Ecuador 2016") 


               




