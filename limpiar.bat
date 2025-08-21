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
ren repositorio_codigo_existe.prg repositorio_codigo_existe.prg
ren repositorio_existe_referencia.prg repositorio_existe_referencia.prg
ren repositorio_obtener_nombre.prg repositorio_obtener_nombre.prg
ren repositorio_obtener_por_codigo.prg repositorio_obtener_por_codigo.prg
ren validador_base.prg validador_base.prg
cd..

cd binario
ren anular_registro.bat anular_registro.bat
ren com_interop.dll com_interop.dll
ren com_interop.tlb com_interop.tlb
ren com_interop.VBR com_interop.vbr
ren gdiplus.dll gdiplus.dll
ren msvcr71.dll msvcr71.dll
ren registrar.bat registrar.bat
ren vfp9resn.dll vfp9resn.dll
ren vfp9t.dll vfp9t.dll
cd..

cd modulo
cd barrio
ren barrio.prg barrio.prg
ren barrio_aud.prg barrio_aud.prg
ren frm_barrio.prg frm_barrio.prg
ren frm_barrio.sct frm_barrio.sct
ren frm_barrio.scx frm_barrio.scx
ren frm_listar_barrio.prg frm_listar_barrio.prg
ren frm_listar_barrio.sct frm_listar_barrio.sct
ren frm_listar_barrio.scx frm_listar_barrio.scx
ren repositorio_barrio.prg repositorio_barrio.prg
ren validador_barrio.prg validador_barrio.prg
cd..
cd ciudad
ren ciudad.prg ciudad.prg
ren ciudad_aud.prg ciudad_aud.prg
ren frm_ciudad.prg frm_ciudad.prg
ren frm_ciudad.sct frm_ciudad.sct
ren frm_ciudad.scx frm_ciudad.scx
ren frm_listar_ciudad.prg frm_listar_ciudad.prg
ren frm_listar_ciudad.sct frm_listar_ciudad.sct
ren frm_listar_ciudad.scx frm_listar_ciudad.scx
ren repositorio_ciudad.prg repositorio_ciudad.prg
ren validador_ciudad.prg validador_ciudad.prg
cd..
cd depar
ren depar.prg depar.prg
ren depar_aud.prg depar_aud.prg
ren frm_depar.prg frm_depar.prg
ren frm_depar.sct frm_depar.sct
ren frm_depar.scx frm_depar.scx
ren frm_listar_depar.prg frm_listar_depar.prg
ren frm_listar_depar.sct frm_listar_depar.sct
ren frm_listar_depar.scx frm_listar_depar.scx
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
cd pais
ren frm_listar_pais.prg frm_listar_pais.prg
ren frm_listar_pais.sct frm_listar_pais.sct
ren frm_listar_pais.scx frm_listar_pais.scx
ren frm_pais.prg frm_pais.prg
ren frm_pais.sct frm_pais.sct
ren frm_pais.scx frm_pais.scx
ren pais.prg pais.prg
ren pais_aud.prg pais_aud.prg
ren repositorio_pais.prg repositorio_pais.prg
ren validador_pais.prg validador_pais.prg
cd..
cd rubro
ren frm_listar_rubro.prg frm_listar_rubro.prg
ren frm_listar_rubro.sct frm_listar_rubro.sct
ren frm_listar_rubro.scx frm_listar_rubro.scx
ren frm_rubro.prg frm_rubro.prg
ren frm_rubro.sct frm_rubro.sct
ren frm_rubro.scx frm_rubro.scx
ren repositorio_rubro.prg repositorio_rubro.prg
ren rubro.prg rubro.prg
ren rubro_aud.prg rubro_aud.prg
ren validador_rubro.prg validador_rubro.prg
cd..
cd subrubro
ren frm_listar_subrubro.prg frm_listar_subrubro.prg
ren frm_listar_subrubro.sct frm_listar_subrubro.sct
ren frm_listar_subrubro.scx frm_listar_subrubro.scx
ren frm_subrubro.prg frm_subrubro.prg
ren frm_subrubro.sct frm_subrubro.sct
ren frm_subrubro.scx frm_subrubro.scx
ren subrubro.prg subrubro.prg
ren subrubro_aud.prg subrubro_aud.prg
ren repositorio_subrubro.prg repositorio_subrubro.prg
ren validador_subrubro.prg validador_subrubro.prg
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
ren test_com_familias.prg test_com_familias.prg
ren test_com_maquinas.prg test_com_maquinas.prg
ren test_com_marcas1.prg test_com_marcas1.prg
ren test_com_marcas2.prg test_com_marcas2.prg
ren test_com_modelos.prg test_com_modelos.prg
ren test_com_rubros1.prg test_com_rubros1.prg
ren test_com_rubros2.prg test_com_rubros2.prg
cd..

ren construir.prg construir.prg
ren establecer_ruta.prg establecer_ruta.prg
ren limpiar.bat limpiar.bat
ren README.md README.md
ren test.prg test.prg
