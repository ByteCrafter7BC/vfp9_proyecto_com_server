**/
* dao_dbf.prg
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

**/
* Clase derivada de la clase abstracta.
*/

#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf AS dao OF dao.prg
    **/
    * @method existe_codigo
    *
    * @purpose Verifica si un código específico existe en la tabla/modelo.
    *
    * @access public
    *
    * @param tnCodigo {Numeric} Código a buscar en la base de datos.
    *
    * @return {Logical} .T. si el código existe, .F. si no existe.
    *                   .T. también en caso de error (con mensaje en
    *                       cUltimoError).
    *
    * @description Esta función realiza una búsqueda rápida utilizando el índice
    *              'indice1' para determinar si el código proporcionado existe
    *              en la tabla/modelo actual. Maneja validación de parámetros
    *              y conexión a la base de datos.
    */
    FUNCTION existe_codigo
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
    FUNCTION existe_nombre
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
    FUNCTION esta_vigente
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
    FUNCTION contar
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
    FUNCTION obtener_nuevo_codigo
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
    FUNCTION obtener_por_codigo
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
    FUNCTION obtener_por_nombre
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
    FUNCTION obtener_todos
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
    FUNCTION agregar
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

        INSERT INTO (THIS.cModelo) ;
            (codigo, nombre, vigente) ;
        VALUES ;
            (m.codigo, m.nombre, m.vigente)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION modificar
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
    FUNCTION borrar
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

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **/
    * @method configurar
    *
    * @purpose Configurar propiedades por defecto del objeto DAO (Data Access
    *          Object) basado en el nombre del modelo y establecer valores
    *          predeterminados para consultas SQL y propiedades de formato.
    *
    * @access protected
    *
    * @return {Logical} .T. si la configuración fue exitosa.
    *                   .F. si el modelo no es válido.
    *
    * @description Método protegido de inicialización que establece valores por
    *              defecto para:
    *              - Nombre del modelo (THIS.cModelo).
    *              - Anchos de campos (THIS.nAnchoCodigo, THIS.nAnchoNombre).
    *              - Ordenamiento SQL (THIS.cSqlOrder).
    *              - Consultas SELECT personalizadas (THIS.cSqlSelect).
    *
    * @note Este método se ejecuta automáticamente durante la inicialización
    *       del objeto para asegurar configuración consistente.
    */
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('dao_dbf_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 9)
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
            CASE THIS.cModelo == 'barrios'
                THIS.cSqlSelect = 'codigo, nombre, departamen, ciudad, vigente'
            CASE THIS.cModelo == 'ciudades'
                THIS.cSqlSelect = 'codigo, nombre, departamen, sifen, vigente'
            CASE THIS.cModelo == 'familias'
                THIS.cSqlSelect = 'codigo, nombre, p1, p2, p3, p4, p5, vigente'
            CASE THIS.cModelo == 'modelos'
                THIS.cSqlSelect = ;
                    'a.codigo, a.nombre, a.maquina, a.marca, a.vigente, ' + ;
                    "IIF(!ISNULL(b.nombre), ALLTRIM(b.nombre) + ' ', '') + " + ;
                    "IIF(!ISNULL(c.nombre), ALLTRIM(c.nombre) + ' ', '') + " + ;
                    'ALLTRIM(a.nombre) AS nombre_completo'
            OTHERWISE
                THIS.cSqlSelect = 'codigo, nombre, vigente'
            ENDCASE
        ENDIF
    ENDFUNC

    **/
    * @method obtener_modelo
    *
    * @purpose Crear y retornar una nueva instancia del modelo de datos con las
    *          propiedades básicas inicializadas.
    *
    * @access protected
    *
    * @param Ninguno (utiliza las propiedades actuales del objeto).
    *
    * @return {Object} Nueva instancia del modelo especificado en THIS.cModelo.
    *
    * @description Factory method que instancia dinámicamente un objeto del
    *              modelo de datos utilizando el nombre almacenado en
    *              THIS.cModelo.
    *              Inicializa el objeto con los valores actuales de código,
    *              nombre y estado vigente del objeto actual.
    *
    * @use Se utiliza para crear instancias consistentes del modelo manteniendo
    *      la cohesión con los datos actuales.
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), vigente)
    ENDFUNC

    **/
    * @method conectar
    *
    * @purpose Conectar/abrir la tabla o modelo de datos para su uso.
    *
    * @access protected
    *
    * @param tlModoEscritura {Logical} [Opcional] .T. para abrir en modo
    *                                                 escritura.
    *                                             .F. para abrir en modo solo
    *                                                 lectura.
    *                                             Si no se especifica,
    *                                             predeterminado .F.
    *
    * @return {Logical} .T. si la conexión fue exitosa, .F. si falló.
    *
    * @description Método protegido que abre la tabla de datos referenciada por
    *              THIS.cModelo utilizando la función global abrir_dbf().
    *              Maneja parámetros opcionales y asegura el modo de apertura.
    *              Si falla la apertura, asegura la desconexión limpia.
    *
    * @use Se llama internamente antes de operaciones que requieran acceso a la
    *      tabla de datos.
    */
    PROTECTED FUNCTION conectar
        LPARAMETERS tlModoEscritura

        IF VARTYPE(tlModoEscritura) != 'L' THEN
            tlModoEscritura = .F.
        ENDIF

        IF !abrir_dbf(THIS.cModelo, tlModoEscritura) THEN
            THIS.desconectar()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @method desconectar
    *
    * @purpose Desconectar/cerrar la tabla o modelo de datos actual.
    *
    * @access protected
    *
    * @return {Logical} .T. (valor por defecto).
    *
    * @description Método protegido que cierra la tabla de datos referenciada
    *              por THIS.cModelo utilizando la función global cerrar_dbf().
    *              Al ser protegido, solo puede ser accedido internamente por
    *              la clase y sus subclases.
    *
    * @use Se llama internamente después de completar operaciones de BD para
    *      liberar recursos y cerrar conexiones.
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC
ENDDEFINE
