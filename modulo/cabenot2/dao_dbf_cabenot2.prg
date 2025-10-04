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
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nota(int tnTipoNota, int tnNroNota)
    * @method bool existe_cdc(string tcCdc)
    */

    **/
    * Verifica si un documento ya existe en la tabla.
    *
    * @param int tnTipoDocu Tipo del documento.
    * @param int tnNroDocu Número único del documento según el tipo.
    * @return bool .T. si el documento existe o si ocurre un error;
    *              .F. si no existe.
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
    * @section MÉTODOS PROTEGIDOS
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool conectar()
    * @method bool desconectar()
    */

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
