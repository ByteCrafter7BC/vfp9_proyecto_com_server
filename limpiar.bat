cls

del /s *.bak
del /s *.err
del /s *.fxp
del /s tm*.*
del /s *.prg~

del /s *.BAK
del /s *.ERR
del /s *.FXP
del /s TM*.*
del /s *.PRG~

cd bd
cd..

cd biblioteca
ren com_base.prg com_base.prg
ren constantes.h constantes.h
ren crear_repositorio.prg crear_repositorio.prg
ren dto_base.prg dto_base.prg
ren modelo_base.prg modelo_base.prg
ren repositorio.prg repositorio.prg
ren repositorio_base.prg repositorio_base.prg
ren repositorio_existe_codigo.prg repositorio_existe_codigo.prg
ren repositorio_existe_referencia.prg repositorio_existe_referencia.prg
ren repositorio_obtener_nombre.prg repositorio_obtener_nombre.prg
ren repositorio_obtener_por_codigo.prg repositorio_obtener_por_codigo.prg
ren validador_base.prg validador_base.prg
cd..

cd binario
ren anular_registro.bat anular_registro.bat
ren com_interop.dll com_interop.dll
ren com_interop.tlb com_interop.tlb
ren com_interop.vbr com_interop.vbr
ren gdiplus.dll gdiplus.dll
ren msvcr71.dll msvcr71.dll
ren registrar.bat registrar.bat
ren vfp9resn.dll vfp9resn.dll
ren vfp9t.dll vfp9t.dll
cd..

cd modulo
cd barrios
ren barrios.prg barrios.prg
ren com_barrios.prg com_barrios.prg
ren dto_barrios.prg dto_barrios.prg
ren repositorio_barrios.prg repositorio_barrios.prg
ren validador_barrios.prg validador_barrios.prg
cd..
cd ciudades
ren ciudades.prg ciudades.prg
ren com_ciudades.prg com_ciudades.prg
ren dto_ciudades.prg dto_ciudades.prg
ren repositorio_ciudades.prg repositorio_ciudades.prg
ren validador_ciudades.prg validador_ciudades.prg
cd..
cd cobrador
ren cobrador.prg cobrador.prg
ren com_cobrador.prg com_cobrador.prg
ren dto_cobrador.prg dto_cobrador.prg
ren repositorio_cobrador.prg repositorio_cobrador.prg
ren validador_cobrador.prg validador_cobrador.prg
cd..
cd depar
ren com_depar.prg com_depar.prg
ren depar.prg depar.prg
ren dto_depar.prg dto_depar.prg
ren repositorio_depar.prg repositorio_depar.prg
ren validador_depar.prg validador_depar.prg
cd..
cd familias
ren com_familias.prg com_familias.prg
ren dto_familias.prg dto_familias.prg
ren familias.prg familias.prg
ren repositorio_familias.prg repositorio_familias.prg
ren validador_familias.prg validador_familias.prg
cd..
cd maquinas
ren com_maquinas.prg com_maquinas.prg
ren dto_maquinas.prg dto_maquinas.prg
ren maquinas.prg maquinas.prg
ren repositorio_maquinas.prg repositorio_maquinas.prg
ren validador_maquinas.prg validador_maquinas.prg
cd..
cd marcas1
ren com_marcas1.prg com_marcas1.prg
ren dto_marcas1.prg dto_marcas1.prg
ren marcas1.prg marcas1.prg
ren repositorio_marcas1.prg repositorio_marcas1.prg
ren validador_marcas1.prg validador_marcas1.prg
cd..
cd marcas2
ren com_marcas2.prg com_marcas2.prg
ren dto_marcas2.prg dto_marcas2.prg
ren marcas2.prg marcas2.prg
ren repositorio_marcas2.prg repositorio_marcas2.prg
ren validador_marcas2.prg validador_marcas2.prg
cd..
cd mecanico
ren com_mecanico.prg com_mecanico.prg
ren dto_mecanico.prg dto_mecanico.prg
ren mecanico.prg mecanico.prg
ren repositorio_mecanico.prg repositorio_mecanico.prg
ren validador_mecanico.prg validador_mecanico.prg
cd..
cd modelos
ren com_modelos.prg com_modelos.prg
ren dto_modelos.prg dto_modelos.prg
ren modelos.prg modelos.prg
ren repositorio_modelos.prg repositorio_modelos.prg
ren validador_modelos.prg validador_modelos.prg
cd..
cd rubros1
ren com_rubros1.prg com_rubros1.prg
ren dto_rubros1.prg dto_rubros1.prg
ren repositorio_rubros1.prg repositorio_rubros1.prg
ren rubros1.prg rubros1.prg
ren validador_rubros1.prg validador_rubros1.prg
cd..
cd rubros2
ren com_rubros2.prg com_rubros2.prg
ren dto_rubros2.prg dto_rubros2.prg
ren repositorio_rubros2.prg repositorio_rubros2.prg
ren rubros2.prg rubros2.prg
ren validador_rubros2.prg validador_rubros2.prg
cd..
cd proceden
ren com_proceden.prg com_proceden.prg
ren dto_proceden.prg dto_proceden.prg
ren proceden.prg proceden.prg
ren repositorio_proceden.prg repositorio_proceden.prg
ren validador_proceden.prg validador_proceden.prg
cd..
cd rubros1
ren com_rubros1.prg com_rubros1.prg
ren dto_rubros1.prg dto_rubros1.prg
ren repositorio_rubros1.prg repositorio_rubros1.prg
ren rubros1.prg rubros1.prg
ren validador_rubros1.prg validador_rubros1.prg
cd..
cd rubros2
ren com_rubros2.prg com_rubros2.prg
ren dto_rubros2.prg dto_rubros2.prg
ren repositorio_rubros2.prg repositorio_rubros2.prg
ren rubros2.prg rubros2.prg
ren validador_rubros2.prg validador_rubros2.prg
cd..
cd sifen
ren sifen_ciudades.prg sifen_ciudades.prg
cd..
cd vendedor
ren com_vendedor.prg com_vendedor.prg
ren dto_vendedor.prg dto_vendedor.prg
ren repositorio_vendedor.prg repositorio_vendedor.prg
ren validador_vendedor.prg validador_vendedor.prg
ren vendedor.prg vendedor.prg
cd..
cd..

cd prog
ren abrir_dbf.prg abrir_dbf.prg
ren base_datos.prg base_datos.prg
ren cerrar_dbf.prg cerrar_dbf.prg
ren es_alfa.prg es_alfa.prg
ren es_digito.prg es_digito.prg
ren generar_token.prg generar_token.prg
ren registrar_error.prg registrar_error.prg
cd..

cd proyecto
ren com_interop.pjt com_interop.pjt
ren com_interop.pjx com_interop.pjx
cd..

cd prueba
ren test_ciudades.prg test_ciudades.prg
ren test_com_barrios.prg test_com_barrios.prg
ren test_com_ciudades.prg test_com_ciudades.prg
ren test_com_cobrador.prg test_com_cobrador.prg
ren test_com_depar.prg test_com_depar.prg
ren test_com_familias.prg test_com_familias.prg
ren test_com_maquinas.prg test_com_maquinas.prg
ren test_com_marcas1.prg test_com_marcas1.prg
ren test_com_marcas2.prg test_com_marcas2.prg
ren test_com_modelos.prg test_com_modelos.prg
ren test_com_proceden.prg test_com_proceden.prg
ren test_com_rubros1.prg test_com_rubros1.prg
ren test_com_rubros2.prg test_com_rubros2.prg
ren test_com_vendedor.prg test_com_vendedor.prg
cd..

ren .gitignore .gitignore
ren construir.prg construir.prg
ren establecer_ruta.prg establecer_ruta.prg
ren LICENSE LICENSE
ren limpiar.bat limpiar.bat
ren README.md README.md
ren test.prg test.prg
