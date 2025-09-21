**/
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
* Clase de acceso a datos (DAO) para tablas DBF; deriva de una clase abstracta.
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas nativas de Visual FoxPro (.DBF).
*
* Esta clase está diseñada para ser heredada por clases DAO específicas de cada
* tabla o ser instanciada directamente, configurando la propiedad 'cModelo' con
* el alias de la tabla a gestionar.
*
* @file        dao_dbf.prg
* @package     biblioteca
* @author      ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version     1.0.0
* @since       1.0.0
* @class       dao_dbf
* @extends     dao
* @implements  interfaz_dao
* @method bool existe_codigo(int tnCodigo)
* @method bool existe_nombre(string tcNombre)
* @method bool esta_vigente(int tnCodigo)
* @method bool esta_relacionado(int tnCodigo)
* @method int contar()
* @method int obtener_nuevo_codigo()
* @method mixed obtener_por_codigo()
* @method mixed obtener_por_nombre()
* @method bool obtener_todos([[string tcCondicionFiltro], [string tcOrden]])
* @method string obtener_ultimo_error()
* @method bool agregar(object toModelo)
* @method bool modificar(object toModelo)
* @method bool borrar(int tnCodigo)
* @see         interfaz_dao, dao
* @uses        constantes.h
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf AS dao OF dao.prg
    **/
    * Verifica si un código ya existe en la tabla.
    *
    * Realiza una búsqueda rápida utilizando el índice principal ('indice1').
    *
    * @param int tnCodigo Código numérico a verificar.
    * @return bool .T. si el código existe u ocurre un error.
    *              .F. únicamente si el código no existe.
    * @access public
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

    **/
    * Verifica si un nombre ya existe en la tabla.
    *
    * Realiza una búsqueda no sensible a mayúsculas/minúsculas utilizando el
    * índice secundario ('indice2').
    *
    * @param string tcNombre Nombre a verificar.
    * @return bool .T. si el nombre existe u ocurre un error.
    *              .F. únicamente si el nombre no existe.
    * @access public
    */
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

    **/
    * Verifica si un registro está vigente.
    *
    * @param int tnCodigo Código numérico a verificar.
    * @return bool .T. si el registro existe y está vigente.
    *              .F. si no existe, no está vigente u ocurre un error.
    * @access public
    */
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

    **/
    * Cuenta la cantidad de registros que cumplen con la condición de filtrado.
    *
    * @param string tcCondicionFiltro (Opcional) Condición de filtrado válida.
    *                                            Si se omite, cuenta todos los
    *                                            registros no borrados.
    * @return int Número mayor o igual que cero si la operación es exitosa.
    *             -1 si ocurre un error.
    * @access public
    */
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

    **/
    * Obtiene el siguiente código numérico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de códigos a partir de 1.
    *
    * @return int Número positivo si la operación es exitosa.
    *             -1 si ocurre un error.
    * @access public
    */
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

    **/
    * Obtiene un registro, buscándolo por código.
    *
    * @param int tnCodigo Código del registro a obtener.
    * @return mixed Object modelo si encuentra el registro.
    *               .F. si no lo encuentra u ocurre un error.
    * @access public
    */
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

    **/
    * Obtiene un registro, buscándolo por nombre.
    *
    * @param string tcNombre Nombre del registro a obtener.
    * @return mixed Object modelo si encuentra el registro,
    *               .F. si no lo encuentra u ocurre un error.
    * @access public
    */
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

    **/
    * Obtiene una colección de registros en un cursor temporal.
    *
    * Ejecuta una consulta SELECT sobre la tabla y deja el resultado en un
    * cursor llamado 'tm_' + THIS.cModelo
    *
    * @param string tcCondicionFiltro (Opcional) La cláusula WHERE de la
    *                                            consulta.
    * @param string tcOrden (Opcional) La cláusula ORDER BY de la consulta.
    * @return bool .T. si la operación fue exitosa.
    *              .F. si ocurre un error.
    * @access public
    */
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

    **/
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo con los datos a agregar.
    * @return bool .T. si el agregado fue exitoso.
    *              .F. si ocurre un error.
    * @access public
    */
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

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos a modificar.
    * @return bool .T. si la modificación fue exitosa.
    *              .F. si ocurre un error.
    * @access public
    */
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

    **/
    * Borra un registro de la tabla.
    *
    * @param int tnCodigo Código del registro a borrar.
    * @return bool .T. si el borrado fue exitoso.
    *              .F. si ocurre un error.
    * @access public
    */
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
    *                            ~~~~~~~~~~~~~~~~~                            *
    * @method bool configurar()                                               *
    * @method mixed obtener_modelo()                                          *
    * @method bool conectar([bool tlModoEscritura])                           *
    * @method bool desconectar()                                              *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **/
    * Configura las propiedades por defecto del DAO.
    *
    * Infiere el nombre del modelo y establece valores predeterminados para las
    * cláusulas SQL si no se han especificado.
    *
    * @return bool .T. si la configuración fue exitosa.
    *              .F. si ocurre un error.
    * @access protected
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
    * Crea un objeto a partir del registro actual de la tabla.
    *
    * @return mixed Object Instancia de la clase modelo (ej: 'ciudades.prg').
    *              .F. si ocurre un error.
    * @access protected
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), vigente)
    ENDFUNC

    **/
    * Establece conexión con la base de datos.
    *
    * @param bool tlModoEscritura (Opcional) .T. para abrir en modo escritura.
    *                                        .F. para abrir en modo solo
    *                                        lectura.
    *                                        Si no se especifica,
    *                                        predeterminado .F.
    * @return bool .T. si la conexión fue exitosa.
    *              .F. si ocurre un error.
    * @access protected
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
    * Cierra la conexión con la base de datos.
    *
    * @return bool .T. (valor por defecto).
    * @access protected
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC
ENDDEFINE
