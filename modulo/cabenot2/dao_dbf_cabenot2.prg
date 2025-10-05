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
* @file dao_dbf_cabenot2.prg
* @package modulo\cabenot2
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_cabenot2
* @extends modulo\cabenot2\dao_cabenot2
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO) para tablas DBF; deriva de una clase abstracta.
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas nativas de Visual FoxPro (.DBF).
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_cabenot2 AS dao_cabenot2 OF dao_cabenot2.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method string obtener_ultimo_error()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nota(int tnTipoNota, int tnNroNota)
    * @method bool existe_cdc(string tcCdc)
    * @method int contar([string tcCondicionFiltro])
    * @method mixed obtener_por_nota(int tnTipoNota, int tnNroNota)
    * @method mixed obtener_por_cdc(string tcCdc)
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnTipoNota, int tnNroNota)
    */

    **/
    * Verifica si un documento ya existe en la tabla.
    *
    * @param int tnTipoDocu Tipo de documento.
    * @param int tnNroDocu Número único de documento según el tipo.
    * @return bool .T. si el documento existe o si ocurre un error;
    *              .F. si no existe.
    * @override
    */
    FUNCTION existe_nota
        LPARAMETERS tnTipoNota, tnNroNota

        * inicio { validaciones de parámetros }
        IF !THIS.tnTipoNota_Valid(tnTipoNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnTipoNota')
            RETURN .T.
        ENDIF

        IF !THIS.tnNroNota_Valid(tnNroNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnNroNota')
            RETURN .T.
        ENDIF
        * fin { validaciones de parámetros }

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR tiponota == tnTipoNota AND nronota == tnNroNota
        llExiste = FOUND()

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **/
    * Verifica si un CDC ya existe en la tabla.
    *
    * @param string tcCdc CDC de 44 dígitos.
    * @return bool .T. si el CDC existe o si ocurre un error; .F. si no existe.
    * @override
    */
    FUNCTION existe_cdc
        LPARAMETERS tcCdc

        IF !THIS.tcCdc_Valid(tcCdc) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcCdc')
            RETURN .T.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR cdc == tcCdc
        llExiste = FOUND()

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **/
    * Cuenta el número de registros que cumplen con una condición de filtro.
    *
    * @param string [tcCondicionFiltro] La cláusula WHERE de la consulta, sin
    *                                   la palabra "WHERE".
    * @return int Número de registros contados. Devuelve -1 si ocurre un error.
    * @override
    */
    FUNCTION contar
        LPARAMETERS tcCondicionFiltro

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = '!DELETED()'
        ELSE
            tcCondicionFiltro = tcCondicionFiltro + ' AND !DELETED()'
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
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
    * Realiza la búsqueda de un documento por su tipo y número.
    *
    * @param int tnTipoDocu Tipo de documento.
    * @param int tnNroDocu Número único de documento según el tipo.
    * @return mixed object modelo si el documento se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nota
        LPARAMETERS tnTipoNota, tnNroNota

        * inicio { validaciones de parámetros }
        IF !THIS.tnTipoNota_Valid(tnTipoNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnTipoNota')
            RETURN .F.
        ENDIF

        IF !THIS.tnNroNota_Valid(tnNroNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnNroNota')
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR tiponota == tnTipoNota AND nronota == tnNroNota
        IF FOUND() THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **/
    * Realiza la búsqueda de un documento por su CDC.
    *
    * @param string tcCdc CDC de 44 dígitos.
    * @return mixed object modelo si el documento se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_cdc
        LPARAMETERS tcCdc

        IF !THIS.tcCdc_Valid(tcCdc) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcCdc')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR cdc == tcCdc
        IF FOUND() THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **/
    * Devuelve todos los registros aplicando, opcionalmente, filtro y orden.
    *
    * El resultado se coloca en un cursor temporal llamado 'tm_' +
    * THIS.cModelo.
    *
    * @param string [tcCondicionFiltro] Cláusula WHERE de la consulta.
    * @param string [tcOrden] Cláusula ORDER BY de la consulta.
    * @return bool .T. si la consulta se ejecuta correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = ''
        ENDIF

        IF !THIS.tcOrden_Valid(tcOrden) THEN
            tcOrden = 'tiponota, nronota'
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lcSql
        lcSql = 'SELECT tiponota, nronota, cdc FROM ' + THIS.cModelo

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
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si el registro se agrega correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.tiponota, m.nronota, m.cdc

        WITH toModelo
            m.tiponota = .obtener_tiponota()
            m.nronota = .obtener_nronota()
            m.cdc = .obtener_cdc()
        ENDWITH

        IF THIS.existe_nota(m.tiponota, m.nronota) THEN
            THIS.cUltimoError = "El documento '" + ALLTRIM(STR(m.tiponota)) + ;
                '/' + ALLTRIM(STR(m.nronota)) + "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_cdc(m.cdc) THEN
            THIS.cUltimoError = "El CDC '" + ALLTRIM(m.cdc) + "' ya existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) ;
            (tiponota, nronota, cdc) ;
        VALUES ;
            (m.tiponota, m.nronota, ALLTRIM(m.cdc))

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos actualizados del registro.
    * @return bool .T. si el registro se modifica correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION modificar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.tiponota, m.nronota, m.cdc, ;
              loModelo

        WITH toModelo
            m.tiponota = .obtener_tiponota()
            m.nronota = .obtener_nronota()
            m.cdc = .obtener_cdc()
        ENDWITH

        IF !THIS.existe_nota(m.tiponota, m.nronota) THEN
            THIS.cUltimoError = "El documento '" + ALLTRIM(STR(m.tiponota)) + ;
                '/' + ALLTRIM(STR(m.nronota)) + "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_cdc(m.cdc)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_tiponota() != m.tiponota ;
                    AND loModelo.obtener_nronota() != m.nronota THEN
                THIS.cUltimoError = "El CDC '" + ALLTRIM(m.cdc) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        loModelo = THIS.obtener_por_nota(m.tiponota, m.nronota)

        IF VARTYPE(loModelo) != 'O' THEN
            THIS.cUltimoError = "El documento '" + ALLTRIM(STR(m.tiponota)) + ;
                '/' + ALLTRIM(STR(m.nronota)) + "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El documento '" + ALLTRIM(STR(m.tiponota)) + ;
                '/' + ALLTRIM(STR(m.nronota)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR tiponota == m.tiponota AND nronota == m.nronota
        IF FOUND() THEN
            REPLACE cdc WITH ALLTRIM(m.cdc)
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
    * @param int tnTipoDocu Tipo de documento.
    * @param int tnNroDocu Número único de documento según el tipo.
    * @return bool .T. si el registro se borra correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION borrar
        LPARAMETERS tnTipoNota, tnNroNota

        * inicio { validaciones de parámetros }
        IF !THIS.tnTipoNota_Valid(tnTipoNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnTipoNota')
            RETURN .F.
        ENDIF

        IF !THIS.tnNroNota_Valid(tnNroNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnNroNota')
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR tiponota == tnTipoNota AND nronota == tnNroNota
        IF FOUND() THEN
            DELETE
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                "No se pudo borrar el registro porque no existe."
        ENDIF

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool tnTipoNota_Valid(int tnTipoNota)
    * @method bool tnNroNota_Valid(int tnNroNota)
    * @method bool tcCdc_Valid(string tcCdc)
    * @method bool toModelo_Valid(object toModelo)
    * @method bool tcCondicionFiltro_Valid(string tcCondicionFiltro)
    * @method bool tcOrden_Valid(string tcOrden)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar()
    * @method bool desconectar()
    */

    **/
    * Configura las propiedades por defecto del DAO.
    *
    * Infiere el nombre del modelo.
    *
    * @return bool .T. si la configuración se completa correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('dao_dbf_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 9)
        ENDIF
    ENDFUNC

    **/
    * Crea un objeto modelo a partir del registro actual de la tabla.
    *
    * @return mixed object modelo si la operación se completa correctamente;
    *               .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            tiponota, nronota, ALLTRIM(cdc))
    ENDFUNC

    **/
    * Establece conexión con la base de datos.
    *
    * @param bool [tlModoEscritura] .T. para abrir en modo lectura/escritura, o
    *                               .F. para abrir en modo solo lectura.
    *                               Si no se especifica, predeterminado .F.
    * @return bool .T. si la conexión se establece correctamente, o
    *              .F. si ocurre un error.
    * @override
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
    * @return bool .T. si la conexión se cierra correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC
ENDDEFINE
