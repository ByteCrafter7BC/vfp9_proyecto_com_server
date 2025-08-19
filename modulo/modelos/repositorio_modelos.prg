#INCLUDE 'constantes.h'

DEFINE CLASS repositorio_modelos AS repositorio_base OF repositorio_base.prg
    **--------------------------------------------------------------------------
    FUNCTION nombre_existe
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_nombre_existe(tcNombre, tnMaquina, tnMarca)
        ELSE
            RETURN THIS.dbf_nombre_existe(tcNombre, tnMaquina, tnMarca)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_por_nombre(tcNombre, tnMaquina, tnMarca)
        ELSE
            RETURN THIS.dbf_obtener_por_nombre(tcNombre, tnMaquina, tnMarca)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !repositorio_base::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnMaquina_Valid(toModelo.obtener_maquina()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnMarca_Valid(toModelo.obtener_marca()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Esta sección contiene la implementación de los métodos dependiendo del
    * tipo de conexión de la fuente de datos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_nombre_existe
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .T.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMarca')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(maquina, 4) + STR(marca, 4)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF maquina == tnMaquina AND marca == tnMarca THEN
                    llExiste = .T.
                    EXIT
                ENDIF
            ENDSCAN
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_nombre_existe
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .T.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMarca')
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

        IF tnMaquina > 0 THEN
            lcSql = lcSql + ' AND maquina = ?tnMaquina'
        ELSE
            lcSql = lcSql + ' AND maquina IS NULL'
        ENDIF

        IF tnMarca > 0 THEN
            lcSql = lcSql + ' AND marca = ?tnMarca'
        ELSE
            lcSql = lcSql + ' AND marca IS NULL'
        ENDIF

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
    PROTECTED FUNCTION dbf_obtener_por_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .F.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMarca')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(maquina, 4) + STR(marca, 4)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF maquina == tnMaquina AND marca == tnMarca THEN
                    loModelo = THIS.obtener_modelo()
                    EXIT
                ENDIF
            ENDSCAN
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_por_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .F.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnMarca')
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

        IF tnMaquina > 0 THEN
            lcSql = lcSql + ' AND maquina = ?tnMaquina'
        ELSE
            lcSql = lcSql + ' AND maquina IS NULL'
        ENDIF

        IF tnMarca > 0 THEN
            lcSql = lcSql + ' AND marca = ?tnMarca'
        ELSE
            lcSql = lcSql + ' AND marca IS NULL'
        ENDIF

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
            'FROM ' + THIS.cModelo + ' a ' + ;
            'LEFT JOIN maquinas b ON a.maquina == b.codigo ' + ;
            'LEFT JOIN marcas2 c ON a.marca == c.codigo'

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

        LOCAL lnConexion, lcSqlSelect, lcSql
        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSqlSelect = 'a.codigo, a.nombre, ' + ;
            'COALESCE(a.maquina, 0) AS maquina, ' + ;
            'COALESCE(a.marca, 0) AS marca, a.vigente, ' + ;
            "CONCAT(COALESCE(CONCAT(TRIM(b.nombre), ' '), ''), " + ;
            "COALESCE(CONCAT(TRIM(c.nombre), ' '), ''), " + ;
            'TRIM(a.nombre)) AS nombre_completo'
        lcSql = 'SELECT ' + lcSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo + ' a ' + ;
            'LEFT JOIN maquinas b ON a.maquina = b.codigo ' + ;
            'LEFT JOIN marcas2 c ON a.marca = c.codigo'

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

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.nombre_existe(m.nombre, m.maquina, m.marca) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF m.maquina > 0 ;
                AND !repositorio_codigo_existe('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !repositorio_codigo_existe('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
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

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente, ;
              lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = IIF(.esta_vigente(), 1, 0)
        ENDWITH

        IF THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.nombre_existe(m.nombre, m.maquina, m.marca) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF m.maquina > 0 ;
                AND !repositorio_codigo_existe('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !repositorio_codigo_existe('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'INSERT INTO ' + THIS.cModelo + ' ' + ;
            'VALUES (?m.codigo, ?m.nombre, ?m.maquina, ?m.marca, ?m.vigente)'
        m.maquina = IIF(m.maquina > 0, m.maquina, NULL)
        m.marca = IIF(m.marca > 0, m.marca, NULL)

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

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.maquina, m.marca)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        IF m.maquina > 0 ;
                AND !repositorio_codigo_existe('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !repositorio_codigo_existe('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
            RETURN .F.
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
                    maquina WITH m.maquina, ;
                    marca WITH m.marca, ;
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

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.codigo_existe(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.maquina, m.marca)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        IF m.maquina > 0 ;
                AND !repositorio_codigo_existe('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !repositorio_codigo_existe('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
            RETURN .F.
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
            'SET nombre = ?m.nombre, maquina = ?m.maquina, ' + ;
            'marca = ?m.marca, vigente = ?m.vigente ' + ;
            'WHERE codigo = ?m.codigo'

        WITH toModelo
            m.maquina = IIF(.obtener_maquina() > 0, .obtener_maquina(), NULL)
            m.marca = IIF(.obtener_marca() > 0, .obtener_marca(), NULL)
            m.vigente = IIF(.esta_vigente(), 1, 0)
        ENDWITH

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
            codigo, ALLTRIM(nombre), maquina, marca, vigente)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), IIF(!ISNULL(maquina), maquina, 0), ;
            IIF(!ISNULL(marca), marca, 0), vigente == 1)
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

        IF !tlModoEscritura THEN
            IF !abrir_dbf('maquinas') THEN
                THIS.desconectar()
                RETURN .F.
            ENDIF

            IF !abrir_dbf('marcas2') THEN
                THIS.desconectar()
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_desconectar
        cerrar_dbf(THIS.cModelo)
        cerrar_dbf('maquinas')
        cerrar_dbf('marcas2')
    ENDFUNC
ENDDEFINE
