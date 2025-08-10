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
ren barrio.cdx barrio.cdx
ren barrio.dbf barrio.dbf
ren barrio_aud.cdx barrio_aud.cdx
ren barrio_aud.dbf barrio_aud.dbf
ren ciudad.cdx ciudad.cdx
ren ciudad.dbf ciudad.dbf
ren ciudad_aud.cdx ciudad_aud.cdx
ren ciudad_aud.dbf ciudad_aud.dbf
ren depar.cdx depar.cdx
ren depar.dbf depar.dbf
ren depar_aud.cdx depar_aud.cdx
ren depar_aud.dbf depar_aud.dbf
ren familia.cdx familia.cdx
ren familia.dbf familia.dbf
ren familia_aud.cdx familia_aud.cdx
ren familia_aud.dbf familia_aud.dbf
ren maquina.cdx maquina.cdx
ren maquina.dbf maquina.dbf
ren maquina_aud.cdx maquina_aud.cdx
ren maquina_aud.dbf maquina_aud.dbf
ren marca.cdx marca.cdx
ren marca.dbf marca.dbf
ren marca_aud.cdx marca_aud.cdx
ren marca_aud.dbf marca_aud.dbf
ren modelo.cdx modelo.cdx
ren modelo.dbf modelo.dbf
ren modelo_aud.cdx modelo_aud.cdx
ren modelo_aud.dbf modelo_aud.dbf
ren pais.cdx pais.cdx
ren pais.dbf pais.dbf
ren pais_aud.cdx pais_aud.cdx
ren pais_aud.dbf pais_aud.dbf
ren rubro.cdx rubro.cdx
ren rubro.dbf rubro.dbf
ren rubro_aud.cdx rubro_aud.cdx
ren rubro_aud.dbf rubro_aud.dbf
ren subrubro.cdx subrubro.cdx
ren subrubro.dbf subrubro.dbf
ren subrubro_aud.cdx subrubro_aud.cdx
ren subrubro_aud.dbf subrubro_aud.dbf
ren zona.cdx zona.cdx
ren zona.dbf zona.dbf
ren zona_aud.cdx zona_aud.cdx
ren zona_aud.dbf zona_aud.dbf
cd..

cd biblioteca
ren auditoria_base.prg auditoria_base.prg
ren constantes.h constantes.h
ren crear_repositorio.prg crear_repositorio.prg
ren frm_base.prg frm_base.prg
ren frm_listar_base.prg frm_listar_base.prg
ren libvfp9.vct libvfp9.vct
ren libvfp9.vcx libvfp9.vcx
ren modelo_base.prg modelo_base.prg
ren repositorio.prg repositorio.prg
ren repositorio_base.prg repositorio_base.prg
ren repositorio_codigo_existe.prg repositorio_codigo_existe.prg
ren repositorio_obtener_nombre.prg repositorio_obtener_nombre.prg
ren repositorio_obtener_por_codigo.prg repositorio_obtener_por_codigo.prg
ren validador_base.prg validador_base.prg
cd..

cd img
cd bmp
ren disquete_blanco.bmp disquete_blanco.bmp
ren disquete_rojo.bmp disquete_rojo.bmp
ren lupa.bmp lupa.bmp
cd..
cd ico
ren form.ico form.ico
cd..
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
cd familia
ren familia.prg familia.prg
ren familia_aud.prg familia_aud.prg
ren frm_familia.prg frm_familia.prg
ren frm_familia.sct frm_familia.sct
ren frm_familia.scx frm_familia.scx
ren frm_listar_familia.prg frm_listar_familia.prg
ren frm_listar_familia.sct frm_listar_familia.sct
ren frm_listar_familia.scx frm_listar_familia.scx
ren repositorio_familia.prg repositorio_familia.prg
ren validador_familia.prg validador_familia.prg
cd..
cd maquina
ren frm_listar_maquina.prg frm_listar_maquina.prg
ren frm_listar_maquina.sct frm_listar_maquina.sct
ren frm_listar_maquina.scx frm_listar_maquina.scx
ren frm_maquina.prg frm_maquina.prg
ren frm_maquina.sct frm_maquina.sct
ren frm_maquina.scx frm_maquina.scx
ren maquina.prg maquina.prg
ren maquina_aud.prg maquina_aud.prg
ren repositorio_maquina.prg repositorio_maquina.prg
ren validador_maquina.prg validador_maquina.prg
cd..
cd marca
ren frm_listar_marca.prg frm_listar_marca.prg
ren frm_listar_marca.sct frm_listar_marca.sct
ren frm_listar_marca.scx frm_listar_marca.scx
ren frm_marca.prg frm_marca.prg
ren frm_marca.sct frm_marca.sct
ren frm_marca.scx frm_marca.scx
ren marca.prg marca.prg
ren marca_aud.prg marca_aud.prg
ren repositorio_marca.prg repositorio_marca.prg
ren validador_marca.prg validador_marca.prg
cd..
cd modelo
ren frm_listar_modelo.prg frm_listar_modelo.prg
ren frm_listar_modelo.sct frm_listar_modelo.sct
ren frm_listar_modelo.scx frm_listar_modelo.scx
ren frm_modelo.prg frm_modelo.prg
ren frm_modelo.sct frm_modelo.sct
ren frm_modelo.scx frm_modelo.scx
ren modelo.prg modelo.prg
ren modelo_aud.prg modelo_aud.prg
ren repositorio_modelo.prg repositorio_modelo.prg
ren validador_modelo.prg validador_modelo.prg
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
cd zona
ren frm_listar_zona.prg frm_listar_zona.prg
ren frm_listar_zona.sct frm_listar_zona.sct
ren frm_listar_zona.scx frm_listar_zona.scx
ren frm_zona.prg frm_zona.prg
ren frm_zona.sct frm_zona.sct
ren frm_zona.scx frm_zona.scx
ren repositorio_zona.prg repositorio_zona.prg
ren validador_zona.prg validador_zona.prg
ren zona_aud.prg zona_aud.prg
ren zona.prg zona.prg
cd..
cd..

cd prog
ren abrir_dbf.prg abrir_dbf.prg
ren base_datos.prg base_datos.prg
ren cerrar_dbf.prg cerrar_dbf.prg
ren comprimir_zip.prg comprimir_zip.prg
ren createmp.prg createmp.prg
ren descomprimir_zip.prg descomprimir_zip.prg
ren pa_calcular_dv_11_a.sql pa_calcular_dv_11_a.sql
ren sanitizar_cadena_busqueda.prg sanitizar_cadena_busqueda.prg
ren textbox_bueno.prg textbox_bueno.prg
ren textbox_malo.prg textbox_malo.prg
ren textbox_normal.prg textbox_normal.prg
ren textbox_requerido.prg textbox_requerido.prg
cd..

ren aguateria.sublime-project aguateria.sublime-project
ren aguateria.sublime-workspace aguateria.sublime-workspace
ren establecer_ruta.prg establecer_ruta.prg
ren limpiar.bat limpiar.bat
ren notas.txt notas.txt
ren test_repositorio_ciudad.prg test_repositorio_ciudad.prg
ren test_repositorio_zona.prg test_repositorio_zona.prg
