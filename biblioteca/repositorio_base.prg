#INCLUDE 'constantes.h'

DEFINE CLASS repositorio_base AS Custom
    PROTECTED cModelo
    PROTECTED nAnchoCodigo
    PROTECTED nAnchoNombre

    PROTECTED cSqlOrder
    PROTECTED cSqlSelect

    PROTECTED cUltimoError

    **--------------------------------------------------------------------------
    FUNCTION codigo_existe
        LPARAMETERS tnCodigo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_codigo_existe(tnCodigo)
        ELSE
            RETURN THIS.dbf_codigo_existe(tnCodigo)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION nombre_existe
        LPARAMETERS tcNombre

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_nombre_existe(tcNombre)
        ELSE
            RETURN THIS.dbf_nombre_existe(tcNombre)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_vigente
        LPARAMETERS tnCodigo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_esta_vigente(tnCodigo)
        ELSE
            RETURN THIS.dbf_esta_vigente(tnCodigo)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .T.
        lcCondicionFiltro = ''

        * TODO: Implementar lógica relacional.

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION contar
        LPARAMETERS tcCondicionFiltro

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_contar(tcCondicionFiltro)
        ELSE
            RETURN THIS.dbf_contar(tcCondicionFiltro)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION nuevo_codigo
        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_nuevo_codigo()
        ELSE
            RETURN THIS.dbf_nuevo_codigo()
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_codigo
        LPARAMETERS tnCodigo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_por_codigo(tnCodigo)
        ELSE
            RETURN THIS.dbf_obtener_por_codigo(tnCodigo)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_por_nombre(tcNombre)
        ELSE
            RETURN THIS.dbf_obtener_por_nombre(tcNombre)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_todos(tcCondicionFiltro, tcOrden)
        ELSE
            RETURN THIS.dbf_obtener_todos(tcCondicionFiltro, tcOrden)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_modelo
        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_modelo()
        ELSE
            RETURN THIS.dbf_obtener_modelo()
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_ultimo_error
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_ciudad
        LPARAMETERS tnCiudad
        RETURN THIS.obtener_nombre_referencial('ciudad', tnCiudad)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_departamen
        LPARAMETERS tnDepartamen
        RETURN THIS.obtener_nombre_referencial('depar', tnDepartamen)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_maquina
        LPARAMETERS tnMaquina
        RETURN THIS.obtener_nombre_referencial('maquinas', tnMaquina)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_marcas1
        LPARAMETERS tnMarca
        RETURN THIS.obtener_nombre_referencial('marcas1', tnMarca)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_marcas2
        LPARAMETERS tnMarca
        RETURN THIS.obtener_nombre_referencial('marcas2', tnMarca)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_pais
        LPARAMETERS tnPais
        RETURN THIS.obtener_nombre_referencial('pais', tnPais)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_rubros1
        LPARAMETERS tnRubro
        RETURN THIS.obtener_nombre_referencial('rubros1', tnRubro)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre_rubros2
        LPARAMETERS tnSubRubro
        RETURN THIS.obtener_nombre_referencial('rubros2', tnSubRubro)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION agregar
        LPARAMETERS toModelo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_agregar(toModelo)
        ELSE
            RETURN THIS.dbf_agregar(toModelo)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION modificar
        LPARAMETERS toModelo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_modificar(toModelo)
        ELSE
            RETURN THIS.dbf_modificar(toModelo)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION borrar
        LPARAMETERS tnCodigo

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_borrar(tnCodigo)
        ELSE
            RETURN THIS.dbf_borrar(tnCodigo)
        ENDIF
    ENDFUNC

    **/
    * Métodos protegidos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('repositorio_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 13)
        ENDIF

        IF VARTYPE(THIS.nAnchoCodigo) != 'N' OR THIS.nAnchoCodigo <= 0 THEN
            THIS.nAnchoCodigo = 9999
        ENDIF

        IF VARTYPE(THIS.nAnchoNombre) != 'N' OR THIS.nAnchoNombre <= 0 THEN
            THIS.nAnchoNombre = 30
        ENDIF

        IF VARTYPE(THIS.cSqlOrder) != 'C' OR EMPTY(THIS.cSqlOrder) THEN
            DO CASE
            CASE THIS.cModelo == 'modelos'
                THIS.cSqlOrder = 'nombre_completo'
            OTHERWISE
                THIS.cSqlOrder = 'nombre'
            ENDCASE
        ENDIF

        IF VARTYPE(THIS.cSqlSelect) != 'C' OR EMPTY(THIS.cSqlSelect) THEN
            DO CASE
            CASE THIS.cModelo == 'barrio'
                THIS.cSqlSelect = ;
                    'codigo, nombre, pais, departamen, ciudad, vigente'
            CASE THIS.cModelo == 'ciudad'
                THIS.cSqlSelect = 'codigo, nombre, pais, departamen, vigente'
            CASE THIS.cModelo == 'depar'
                THIS.cSqlSelect = 'codigo, nombre, pais, vigente'
            CASE THIS.cModelo == 'familias'
                THIS.cSqlSelect = 'codigo, nombre, p1, p2, p3, p4, p5, vigente'
            CASE THIS.cModelo == 'modelos'
                IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
                    THIS.cSqlSelect = 'codigo, nombre, ' + ;
                        'COALESCE(maquina, 0) AS maquina, ' + ;
                        'COALESCE(marca, 0) AS marca, vigente'
                ELSE
                    THIS.cSqlSelect = ;
                        'a.codigo, a.nombre, a.maquina, a.marca, ' + ;
                        'a.vigente, ' + ;
                        'IIF(!ISNULL(b.nombre), ' + ;
                            "ALLTRIM(b.nombre) + ' ', '') + " + ;
                        'IIF(!ISNULL(c.nombre), ' + ;
                            "ALLTRIM(c.nombre) + ' ', '') + " + ;
                        'ALLTRIM(a.nombre) AS nombre_completo'
                ENDIF
            CASE THIS.cModelo == 'pais'
                THIS.cSqlSelect = ;
                    'codigo, nombre, cod_alfa2, cod_alfa3, cod_num, vigente'
            OTHERWISE
                THIS.cSqlSelect = 'codigo, nombre, vigente'
            ENDCASE
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION obtener_nombre_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tcModelo')
        ENDIF

        IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 0, 9999) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
        ENDIF

        IF tnCodigo == 0 THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL lcNombre
        lcNombre = repositorio_obtener_nombre(tcModelo, tnCodigo)

        IF EMPTY(lcNombre) THEN
            RETURN NO_EXISTE
        ENDIF

        RETURN lcNombre
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_codigo_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnMinimo, lnMaximo
        lnMinimo = 1
        lnMaximo = 9999

        IF INLIST(tcModelo, 'maquinas', 'marcas2') THEN
            lnMinimo = 0
        ENDIF

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, lnMinimo, lnMaximo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnCodigo_Valid
        LPARAMETERS tnCodigo

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, 1, THIS.nAnchoCodigo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcNombre_Valid
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' OR EMPTY(tcNombre) ;
                OR LEN(tcNombre) > THIS.nAnchoNombre THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tlVigente_Valid
        LPARAMETERS tlVigente
        RETURN VARTYPE(tlVigente) == 'L'
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcCodAlfa2_Valid
        LPARAMETERS tcCodAlfa2

        IF VARTYPE(tcCodAlfa2) != 'C' OR EMPTY(tcCodAlfa2) ;
                OR LEN(ALLTRIM(tcCodAlfa2)) != 2 OR !es_alfa(tcCodAlfa2) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcCodAlfa3_Valid
        LPARAMETERS tcCodAlfa3

        IF VARTYPE(tcCodAlfa3) != 'C' OR EMPTY(tcCodAlfa3) ;
                OR LEN(ALLTRIM(tcCodAlfa3)) != 3 OR !es_alfa(tcCodAlfa3) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcCodNum_Valid
        LPARAMETERS tcCodNum

        IF VARTYPE(tcCodNum) != 'C' OR EMPTY(tcCodNum) ;
                OR LEN(ALLTRIM(tcCodNum)) != 3 OR !es_digito(tcCodNum) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnRubro_Valid
        LPARAMETERS tnRubro
        RETURN THIS.validar_codigo_referencial('rubros1', tnRubro)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnSubRubro_Valid
        LPARAMETERS tnSubRubro
        RETURN THIS.validar_codigo_referencial('rubros2', tnSubRubro)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnMaquina_Valid
        LPARAMETERS tnMaquina
        RETURN THIS.validar_codigo_referencial('maquina', tnMaquina)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnMarca_Valid
        LPARAMETERS tnMarca
        RETURN THIS.validar_codigo_referencial('marca', tnMarca)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.cModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnCodigo_Valid(toModelo.obtener_codigo()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tcNombre_Valid(toModelo.obtener_nombre()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tlVigente_Valid(toModelo.esta_vigente()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcCondicionFiltro_Valid
        LPARAMETERS tcCondicionFiltro

        IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) ;
                OR LEN(tcCondicionFiltro) > 150 THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcOrden_Valid
        LPARAMETERS tcOrden

        IF VARTYPE(tcOrden) != 'C' OR EMPTY(tcOrden) ;
                OR !INLIST(tcOrden, 'codigo', 'nombre') THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION conectar
        LPARAMETERS tlModoEscritura

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_conectar()
        ELSE
            RETURN THIS.dbf_conectar(tlModoEscritura)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION desconectar
        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_desconectar()
        ELSE
            RETURN THIS.dbf_desconectar()
        ENDIF
    ENDFUNC

    **/
    * Esta sección contiene la implementación de los métodos dependiendo del
    * tipo de conexión de la fuente de datos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_codigo_existe
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        llExiste = SEEK(tnCodigo)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_codigo_existe
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste, lnConexion, lcSql
        llExiste = .T.
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT COUNT(*) AS cantidad ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE codigo = ?tnCodigo'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            llExiste = VAL(cantidad) > 0
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN llExiste
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_nombre_existe
        LPARAMETERS tcNombre

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && UPPER(nombre)
        llExiste = SEEK(tcNombre)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_nombre_existe
        LPARAMETERS tcNombre

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste, lnConexion, lcSql
        llExiste = .T.
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT COUNT(*) AS cantidad ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE UPPER(nombre) = ?tcNombre'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            llExiste = VAL(cantidad) > 0
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN llExiste
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_esta_vigente
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL llVigente

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            llVigente = vigente
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llVigente
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_esta_vigente
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL llVigente, lnConexion, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT COUNT(*) AS cantidad ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE codigo = ?tnCodigo AND vigente'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            llVigente = VAL(cantidad) > 0
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN llVigente
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_contar
        LPARAMETERS tcCondicionFiltro

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = '!DELETED()'
        ELSE
            tcCondicionFiltro = tcCondicionFiltro + ' AND !DELETED()'
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCantidad

        SELECT (THIS.cModelo)
        COUNT FOR EVALUATE(tcCondicionFiltro) TO lnCantidad

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN lnCantidad
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_contar
        LPARAMETERS tcCondicionFiltro

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            THIS.cUltimoError = ;
                STRTRAN(PARAM_INVALIDO, '{}', 'tcCondicionFiltro')
            RETURN -1
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCantidad, lnConexion, lcSql
        lnCantidad = -1
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT COUNT(*) AS cantidad ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE ' + tcCondicionFiltro

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            lnCantidad = VAL(cantidad)
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN lnCantidad
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_nuevo_codigo
        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCodigo
        lnCodigo = 1

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        SEEK(lnCodigo)
        DO WHILE FOUND()
            lnCodigo = lnCodigo + 1
            SEEK(lnCodigo)
        ENDDO

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN lnCodigo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_nuevo_codigo
        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCodigo, lnCantidad, lnConexion, lcSql
        STORE 1 TO lnCodigo, lnCantidad
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT COUNT(*) AS cantidad ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE codigo = ?lnCodigo'

        IF SQLPREPARE(lnConexion, lcSql) == SQL_ERROR THEN
            AERROR(laError)
            THIS.cUltimoError = laError[2]
            RETURN -1
        ENDIF

        DO WHILE lnCantidad > 0
            IF SQLEXEC(lnConexion) == SQL_EXITO THEN
                lnCantidad = VAL(cantidad)
                USE
                THIS.cUltimoError = ''

                IF lnCantidad > 0 THEN
                    lnCodigo = lnCodigo + 1
                ELSE
                    EXIT
                ENDIF
            ELSE
                AERROR(laError)
                THIS.cUltimoError = laError[2]
                RETURN -1
            ENDIF
        ENDDO

        RETURN lnCodigo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_obtener_por_codigo
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_por_codigo
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo, lnConexion, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE codigo = ?tnCodigo'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            IF RECCOUNT() > 0 THEN
                GOTO TOP
                loModelo = THIS.obtener_modelo()
            ENDIF
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN loModelo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_obtener_por_nombre
        LPARAMETERS tcNombre

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && nombre
        IF SEEK(tcNombre) THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_por_nombre
        LPARAMETERS tcNombre

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo, lnConexion, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo + ' ' + ;
            'WHERE UPPER(nombre) = ?tcNombre'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            IF RECCOUNT() > 0 THEN
                GOTO TOP
                loModelo = THIS.obtener_modelo()
            ENDIF
            USE
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN loModelo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = ''
        ENDIF

        IF !THIS.tcOrden_Valid(tcOrden) THEN
            tcOrden = THIS.cSqlOrder
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lcSql
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo

        IF !EMPTY(tcCondicionFiltro) THEN
            lcSql = lcSql + ' WHERE ' + tcCondicionFiltro
        ENDIF

        lcSql = lcSql + ' ORDER BY ' + tcOrden + ' ' + ;
            'INTO CURSOR tm_' + THIS.cModelo
        &lcSql

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = ''
        ENDIF

        IF !THIS.tcOrden_Valid(tcOrden) THEN
            tcOrden = THIS.cSqlOrder
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lnConexion, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo

        IF !EMPTY(tcCondicionFiltro) THEN
            lcSql = lcSql + ' WHERE ' + tcCondicionFiltro
        ENDIF

        lcSql = lcSql + ' ORDER BY ' + tcOrden

        IF SQLEXEC(lnConexion, lcSql, 'tm_' + THIS.cModelo) == SQL_EXITO THEN
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.nombre_existe(m.nombre) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) FROM MEMVAR

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.vigente, ;
              lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.vigente = IIF(.esta_vigente(), 1, 0)
        ENDWITH

        IF THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.nombre_existe(m.nombre) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'INSERT INTO ' + THIS.cModelo + ' ' + ;
            'VALUES (?m.codigo, ?m.nombre, ?m.vigente)'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_modificar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        loModelo = THIS.obtener_por_codigo(m.codigo)

        IF VARTYPE(loModelo) != 'O' THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(m.codigo) THEN
            REPLACE nombre WITH ALLTRIM(m.nombre), ;
                    vigente WITH m.vigente
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                "No se pudo modificar el registro porque no existe."
        ENDIF

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_modificar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.vigente, ;
              loModelo, lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        loModelo = THIS.obtener_por_codigo(m.codigo)

        IF VARTYPE(loModelo) != 'O' THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'UPDATE ' + THIS.cModelo + ' ' + ;
            'SET nombre = ?m.nombre, vigente = ?m.vigente ' + ;
            'WHERE codigo = ?m.codigo'
        m.vigente = IIF(toModelo.esta_vigente(), 1, 0)

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_borrar
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF THIS.esta_relacionado(tnCodigo) THEN
            THIS.cUltimoError = ;
                "El registro figura en otros archivos; no se puede borrar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            DELETE
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                "No se pudo borrar el registro porque no existe."
        ENDIF

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_borrar
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF THIS.esta_relacionado(tnCodigo) THEN
            THIS.cUltimoError = ;
                "El registro figura en otros archivos; no se puede borrar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lnConexion, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'DELETE FROM ' + THIS.cModelo + ' ' + ;
            'WHERE codigo = ?tnCodigo'

        IF SQLEXEC(lnConexion, lcSql) == SQL_EXITO THEN
            THIS.cUltimoError = ''
        ELSE
            AERROR(laError)
            THIS.cUltimoError = laError[2]
        ENDIF

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), vigente)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), vigente == 1)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_conectar
        LPARAMETERS tlModoEscritura

        IF VARTYPE(tlModoEscritura) != 'L' THEN
            tlModoEscritura = .F.
        ENDIF

        IF !abrir_dbf(THIS.cModelo, tlModoEscritura) THEN
            THIS.desconectar()
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_conectar
        RETURN _oSCREEN.oConexion.obtener_conexion() > 0
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_desconectar
        * @Override
    ENDFUNC
ENDDEFINE
