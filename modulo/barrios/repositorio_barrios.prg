**/
* repositorio_barrios.prg
*
* Derechos de autor (C) 2000-2025 ByteCrafter7BC <bytecrafter7bc@gmail.com>
*
* Este programa es software libre: puede redistribuirlo y/o modificarlo
* bajo los términos de la Licencia Pública General GNU publicada por
* la Free Software Foundation, ya sea la versión 3 de la Licencia, o
* (a su elección) cualquier versión posterior.
*
* Este programa se distribuye con la esperanza de que sea útil,
* pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de
* COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la
* Licencia Pública General de GNU para obtener más detalles.
*
* Debería haber recibido una copia de la Licencia Pública General de GNU
* junto con este programa. Si no es así, consulte
* <https://www.gnu.org/licenses/>.
*/

#INCLUDE 'constantes.h'

DEFINE CLASS repositorio_barrios AS repositorio_base OF repositorio_base.prg
    **--------------------------------------------------------------------------
    FUNCTION existe_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_existe_nombre(tcNombre, tnDepartamen, tnCiudad)
        ELSE
            RETURN THIS.dbf_existe_nombre(tcNombre, tnDepartamen, tnCiudad)
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
        llRelacionado = .F.
        lcCondicionFiltro = 'barrio == ' + ALLTRIM(STR(tnCodigo))

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            lcCondicionFiltro = STRTRAN(lcCondicionFiltro, '==', '=')
        ENDIF

        IF !llRelacionado THEN
            llRelacionado = ;
                repositorio_existe_referencia('clientes', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            llRelacionado = ;
                repositorio_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            RETURN THIS.odbc_obtener_por_nombre(tcNombre, tnDepartamen, ;
                tnCiudad)
        ELSE
            RETURN THIS.dbf_obtener_por_nombre(tcNombre, tnDepartamen, tnCiudad)
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !repositorio_base::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnDepartamen_Valid(toModelo.obtener_departamen()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnCiudad_Valid(toModelo.obtener_ciudad()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Esta sección contiene la implementación de los métodos dependiendo del
    * tipo de conexión de la fuente de datos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_existe_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .T.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCiudad')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(departamen, 3) + STR(ciudad, 5)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF departamen == tnDepartamen AND ciudad == tnCiudad THEN
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
    PROTECTED FUNCTION odbc_existe_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .T.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCiudad')
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
            'WHERE UPPER(nombre) = ?tcNombre ' + ;
            'AND departamen = ?tnDepartamen AND ciudad = ?tnCiudad'

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
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .F.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCiudad')
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(departamen, 3) + STR(ciudad, 5)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF departamen == tnDepartamen AND ciudad == tnCiudad THEN
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
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .F.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCiudad')
            RETURN .T.
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
            'WHERE UPPER(nombre) = ?tcNombre ' + ;
            'AND departamen = ?tnDepartamen AND ciudad = ?tnCiudad'

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
    PROTECTED FUNCTION dbf_agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.departamen, m.ciudad) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) ;
            (codigo, nombre, departamen, ciudad, vigente) ;
        VALUES ;
            (m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente)

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

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente, ;
              loModelo, lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = IIF(.esta_vigente(), 1, 0)
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.departamen, m.ciudad) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = ERROR_CONEXION
            RETURN .F.
        ENDIF

        lnConexion = _oSCREEN.oConexion.obtener_conexion()
        lcSql = 'INSERT INTO ' + THIS.cModelo + ' ' + ;
            'VALUES (?m.codigo, ?m.nombre, ?m.departamen, ?m.ciudad, ' + ;
            '?m.vigente)'

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

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.departamen, m.ciudad)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        IF !repositorio_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
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
                    departamen WITH m.departamen, ;
                    ciudad WITH m.ciudad, ;
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

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.departamen, m.ciudad)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        IF !repositorio_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !repositorio_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
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
            'SET nombre = ?m.nombre, departamen = ?m.departamen, ' + ;
            'ciudad = ?m.ciudad, vigente = ?m.vigente ' + ;
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
    PROTECTED FUNCTION dbf_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), departamen, ciudad, vigente)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), departamen, ciudad, vigente == 1)
    ENDFUNC
ENDDEFINE
