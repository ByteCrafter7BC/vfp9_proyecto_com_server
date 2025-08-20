PRIVATE poRepositorio, poModelo, pcXml, pcDto
poRepositorio = NEWOBJECT('com_modelos', 'com_modelos.prg')

IF VARTYPE(poRepositorio) != 'O' THEN
    ? "ERROR: El objeto 'poRepositorio' no existe."
    RETURN .F.
ENDIF

separador()
? "Prueba: 1 | Método: 'codigo_existe' | Valor: 3"
? 'Resultado esperado: pasar'
? 'Existe: ' + IIF(poRepositorio.codigo_existe(3), 'Sí', 'No')

IF !poRepositorio.codigo_existe(3) THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 2 | Método: 'codigo_existe' | Valor: 1999"
? 'Resultado esperado: fallar'
? 'Existe: ' + IIF(poRepositorio.codigo_existe(1999), 'Sí', 'No')

IF poRepositorio.codigo_existe(1999) THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 3 | Método: 'nombre_existe' | Valor: 'FS 280', 3, 2"
? 'Resultado esperado: pasar'
? 'Existe: ' + IIF(poRepositorio.nombre_existe('FS 280', 3, 2), 'Sí', 'No')

IF !poRepositorio.nombre_existe('FS 280', 3, 2) THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 4 | Método: 'nombre_existe' | Valor: 'monark', 0, 0"
? 'Resultado esperado: fallar'
? 'Existe: ' + IIF(poRepositorio.nombre_existe('monark', 0, 0), 'Sí', 'No')

IF poRepositorio.nombre_existe('monark', 0, 0) THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 5 | Método: 'esta_vigente' | Valor: 3"
? 'Resultado esperado: pasar'
? 'Vigente: ' + IIF(poRepositorio.esta_vigente(3), 'Sí', 'No')

IF !poRepositorio.esta_vigente(3) THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 6 | Método: 'esta_vigente' | Valor: 1999"
? 'Resultado esperado: fallar'
? 'Vigente: ' + IIF(poRepositorio.esta_vigente(1999), 'Sí', 'No')

IF poRepositorio.esta_vigente(1999) THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 7 | Método: 'esta_relacionado' | Valor: 3"
? 'Resultado esperado: pasar'
? 'Relacionado: ' + IIF(poRepositorio.esta_relacionado(3), 'Sí', 'No')

IF !poRepositorio.esta_relacionado(3) THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 8 | Método: 'esta_relacionado' | Valor: 888"
? 'Resultado esperado: pasar'
? 'Relacionado: ' + IIF(poRepositorio.esta_relacionado(888), 'Sí', 'No')

IF !poRepositorio.esta_relacionado(888) THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 9 | Método: 'contar'"
? 'Resultado esperado: pasar'
? 'Cantidad de registros: ' + ALLTRIM(STR(poRepositorio.contar()))

IF poRepositorio.contar() = 0 THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 10 | Método: 'contar' | Valor: 'nombre == [CALOI                         ]'"
? 'Resultado esperado: pasar'
? 'Cantidad de registros: ' + ALLTRIM(STR(poRepositorio.contar('nombre == [CALOI                         ]')))

IF poRepositorio.contar() = 0 THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 11 | Método: 'nuevo_codigo'"
? 'Resultado esperado: pasar'
? 'Nuevo código: ' + ALLTRIM(STR(poRepositorio.nuevo_codigo()))

IF poRepositorio.nuevo_codigo() <= 0 THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 12 | Método: 'obtener_por_codigo' | Valor: 3"
? 'Resultado esperado: pasar'
poModelo = poRepositorio.obtener_por_codigo(3)
IF !imprimir() THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 13 | Método: 'obtener_por_codigo' | Valor: 1999"
? 'Resultado esperado: fallar'
poModelo = poRepositorio.obtener_por_codigo(1999)
IF imprimir() THEN
    RETURN .F.
ENDIF

esperar()

separador()
? "Prueba: 14 | Método: 'obtener_por_nombre' | Valor: 'FS 280', 3, 2"
? 'Resultado esperado: pasar'
poModelo = poRepositorio.obtener_por_nombre('FS 280', 3, 2)
IF !imprimir() THEN
    RETURN .F.
ENDIF

separador()
? "Prueba: 15 | Método: 'obtener_por_nombre' | Valor: 'monark', 0, 0"
? 'Resultado esperado: fallar'
poModelo = poRepositorio.obtener_por_nombre('monark', 0, 0)
IF imprimir() THEN
    RETURN .F.
ENDIF

esperar()

? "Prueba: 16 | Método: 'obtener_todos'"
? 'Resultado esperado: pasar'
pcXml = poRepositorio.obtener_todos()
IF !mostrar() THEN
    RETURN .F.
ENDIF

? "Prueba: 17 | Método: 'obtener_todos' | Valor: 'C%'"
? 'Resultado esperado: pasar'
pcXml = poRepositorio.obtener_todos('a.nombre LIKE [C%]')
IF !mostrar() THEN
    RETURN .F.
ENDIF

? "Prueba: 18 | Método: 'obtener_todos' | Valor: 'C%', 'a.codigo'"
? 'Resultado esperado: pasar'
pcXml = poRepositorio.obtener_todos('a.nombre LIKE [C%]', 'a.codigo')
IF !mostrar() THEN
    RETURN .F.
ENDIF

esperar()

? "Prueba: 19 | Método: 'obtener_dto'"
? 'Resultado esperado: pasar'
pcDto = poRepositorio.obtener_dto()
? 'DTO creado: ' + IIF(VARTYPE(pcDto) == 'O', 'Sí', 'No')

IF VARTYPE(pcDto) != 'O' THEN
    RETURN .F.
ENDIF

esperar()

? "Prueba: 20 | Método: 'agregar'"
? 'Resultado esperado: pasar'
pcDto = poRepositorio.obtener_dto()

IF VARTYPE(pcDto) != 'O' THEN
    RETURN .F.
ENDIF

WITH pcDto
    .establecer_codigo(poRepositorio.nuevo_codigo())
    .establecer_nombre('Nombre ' + ALLTRIM(STR(.obtener_codigo())))
    .establecer_vigente(.T.)
ENDWITH

? 'Código: ' + ALLTRIM(STR(pcDto.obtener_codigo()))
? 'Agregado: ' + IIF(poRepositorio.agregar(pcDto), 'Sí', 'No')

separador()

poModelo = poRepositorio.obtener_por_codigo(pcDto.obtener_codigo())
IF !imprimir() THEN
    RETURN .F.
ENDIF

separador()

? "Prueba: 21 | Método: 'modificar'"
? 'Resultado esperado: pasar'
IF VARTYPE(pcDto) != 'O' THEN
    RETURN .F.
ENDIF

WITH pcDto
    .establecer_nombre('nombre ' + ALLTRIM(STR(.obtener_codigo())) + ' (modificado)')
    .establecer_maquina(2)
    .establecer_marca(3)
    .establecer_vigente(.F.)
ENDWITH

? 'Código: ' + ALLTRIM(STR(pcDto.obtener_codigo()))
? 'Modificado: ' + IIF(poRepositorio.modificar(pcDto), 'Sí', 'No')

IF !poRepositorio.modificar(pcDto) THEN
    ? 'Error: ' + poRepositorio.obtener_ultimo_error()
ENDIF

separador()

poModelo = poRepositorio.obtener_por_codigo(pcDto.obtener_codigo())
IF !imprimir() THEN
    RETURN .F.
ENDIF

esperar()

? "Prueba: 22 | Método: 'borrar' | Valor: 3"
? 'Resultado esperado: fallar'
? 'Borrado: ' + IIF(poRepositorio.borrar(3), 'Sí', 'No')

IF !poRepositorio.codigo_existe(3) THEN
    RETURN .F.
ENDIF

**------------------------------------------------------------------------------
FUNCTION imprimir
    IF VARTYPE(poModelo) != 'O' THEN
        ? "ERROR: El objeto 'poModelo' no existe."
        RETURN .F.
    ENDIF

    WITH poModelo
        ? 'Código: ' + ALLTRIM(STR(.obtener_codigo()))
        ? 'Nombre: ' + .obtener_nombre()
        ? 'Máquina: ' + ALLTRIM(STR(.obtener_maquina()))
        ? 'Marca: ' + ALLTRIM(STR(.obtener_marca()))
        ? 'Vigente: ' + IIF(.esta_vigente(), 'Sí', 'No')
    ENDWITH
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION separador
    ? REPLICATE('-', 80)
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION esperar
    WAIT 'Presione cualquier tecla para continuar ...' WINDOW
    CLEAR
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION mostrar
    IF VARTYPE(pcXml) != 'C' OR EMPTY(pcXml) THEN
        RETURN .F.
    ENDIF

    XMLTOCURSOR(pcXml, 'tm_resultado')

    IF USED('tm_resultado') THEN
        SELECT tm_resultado
        BROWSE NOEDIT
        USE IN tm_resultado
    ENDIF
ENDFUNC
