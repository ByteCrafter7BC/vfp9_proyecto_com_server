**/
* repositorio_familias.prg
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

DEFINE CLASS repositorio_familias AS repositorio_base OF repositorio_base.prg
    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'familia == ' + ALLTRIM(STR(tnCodigo))

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            lcCondicionFiltro = STRTRAN(lcCondicionFiltro, '==', '=')
        ENDIF

        IF !llRelacionado THEN
            llRelacionado = ;
                repositorio_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnP_Valid
        LPARAMETERS tnP

        IF VARTYPE(tnP) != 'N' OR !BETWEEN(tnP, 0, 999.99) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !repositorio_base::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnLista, lcCondicion

        FOR lnLista = 1 TO 5
            lcCondicion = '!THIS.tnP_Valid(toModelo.obtener_p' + ;
                STR(lnLista, 1) + '())'
            IF EVALUATE(lcCondicion) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Esta sección contiene la implementación de los métodos dependiendo del
    * tipo de conexión de la fuente de datos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION dbf_agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre) THEN
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

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente, ;
              lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = IIF(.esta_vigente(), 1, 0)
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre) THEN
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
            'VALUES (?m.codigo, ?m.nombre, ' + ;
            '?m.p1, ?m.p2, ?m.p3, ?m.p4, ?m.p5, ?m.vigente)'

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

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
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
                    p1 WITH m.p1, ;
                    p2 WITH m.p2, ;
                    p3 WITH m.p3, ;
                    p4 WITH m.p4, ;
                    p5 WITH m.p5, ;
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

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente, ;
              loModelo, lnConexion, lcSql

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
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
            'SET nombre = ?m.nombre, p1 = ?m.p1, p2 = ?m.p2, ' + ;
            'p3 = ?m.p3, p4 = ?m.p4, p5 = ?m.p5, vigente = ?m.vigente ' + ;
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
            codigo, ALLTRIM(nombre), p1, p2, p3, p4, p5, vigente)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION odbc_obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), p1, p2, p3, p4, p5, vigente == 1)
    ENDFUNC
ENDDEFINE
