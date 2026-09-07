
                          MODELO DE ENDOGENEIDAD
*Reducir la endogeneidad en la tasa de mortalidad infantil Ecuador 2014*
--------------------------------------------------------------------------------

import excel "C:\Users\Ingrid\Documents\Sexto ciclo\ECONOMETRIA INTERMEDIA\Unidad1\PROYECTO\Basedatos\BASEFINAL.xls", sheet("BASEFINAL") fir
> strow

----------------------------------------------------------------------------------------
*Graficos
---------------------------------------------------------------------------------------------

graph hbar TMI, over(Canton) blabel(total) ylabel(,grid)

twoway (scatter TMI salario)(lfit TMI salario)              // MI1
twoway (scatter TMI servicio)(lfit TMI servicio)  // MI2
twoway (scatter TMI estadocivil)(lfit TMI estadocivil)      // MI3
twoway (scatter TMI discapacidad)(lfit TMI discapacidad)            // MI4
twoway (scatter TMI edad)(lfit TMI edad)            // MI5
twoway (scatter TMI control)(lfit TMI control)                  // MI6
twoway (scatter TMI empleo)(lfit TMI empleo)        // MI7
twoway (scatter TMI agua)(lfit TMI agua)        // MI8
twoway (scatter TMI area)(lfit TMI area)        // MI9

gr combine MI1.gph MI2.gph MI3.gph MId4.gph MI5.gph MI6.gph MI7.gph MI8.gph MI9.gph

-----------------------------------------------------------------------------------
*Estadisticos descriptivos
--------------------------------------------------------------------------------------

sum TMI servicio estadocivil salario discapacidad edad control empleo agua area
cor TMI servicio estadocivil salario discapacidad edad control empleo agua area

--------------------------------------------------------------------------------
*Modelo*
--------------------------------------------------------------------------------

*Regresion Minser                          
regress TMI salario 
estimates store Modelo1
                           
regress TMI salario servicio estadocivil 
estimates store Modelo2
                        
regress TMI salario servicio estadocivil discapacidad edad 
estimates store Modelo3

regress TMI salario servicio estadocivil discapacidad edad control empleo 
estimates store Modelo4

regress TMI salario servicio estadocivil discapacidad edad control empleo agua area
estimates store Modelo5

esttab Modelo1 Modelo2 Modelo3 Modelo4 Modelo5 using TMI2014.rtf, t ar2 compress label ///
title (Resultados Resultados TMI 2014) ///
nonumbers mtitles ("Modelo1" "Modelo2" "Modelo3" "Modelo4" "Modelo5")


*Metodos de reduccion de endogeneidad*

quietly reg TMI salario
predict hatl
label var hatl "Linear prediction1"
twoway (scatter TMI salario, mlabel(Canton)) (line hatl salario, sort), ytitle("Tasa de mortalidad")
twoway (scatter TMI salario, mlabel(Canton)) (line hatl salario, sort)

reg TMI edad
predict hat2
label var hat2 "Linear prediction2"
twoway (scatter TMI edad, mlabel(Canton)) (line hat2 edad, sort), ytitle("Tasa de mortalidad")

twoway (scatter TMI salario, mlabel(Canton)) (line hatl salario) (scatter TMI edad, mlabel(Canton)) (line hat2 edad)


regress TMI salario

*Prueba de endogeneidad
ivregress 2sls TMI (salario = servicio), small
estat endogenous

*Fit a regression using the LIML estimator
ivregress liml TMI (salario = servicio), small
estat firststage

*Fit a regression via GMM using the default heteroskedasticity-robust weight matrix
ivregress gmm TMI (salario = servicio), small
estat endogenous


