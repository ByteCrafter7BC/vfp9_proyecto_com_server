PRIVATE poCiudad1, poCiudad2

poCiudad1 = NEWOBJECT('ciudades', 'ciudades.prg', '', 1, 'Nombre 1', 2, 3, .T.)
poCiudad2 = NEWOBJECT('ciudades', 'ciudades.prg', '', 1, 'Nombre 1', 2, 3, .T.)

? 'Es igual: ' + IIF(poCiudad1.es_igual(poCiudad2), 'Sí', 'No')
