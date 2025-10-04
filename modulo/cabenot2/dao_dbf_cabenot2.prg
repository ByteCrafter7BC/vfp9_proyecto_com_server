**/
* Derechos de autor (C) 2000-2025 ByteCrafter7BC <bytecrafter7bc@gmail.com>
*
* Este programa es software libre: puede redistribuirlo y/o modificarlo
* bajo los t�rminos de la Licencia P�blica General GNU publicada por
* la Free Software Foundation, ya sea la versi�n 3 de la Licencia, o
* (a su elecci�n) cualquier versi�n posterior.
*
* Este programa se distribuye con la esperanza de que sea �til,
* pero SIN NINGUNA GARANT�A; sin siquiera la garant�a impl�cita de
* COMERCIABILIDAD o IDONEIDAD PARA UN PROP�SITO PARTICULAR. Consulte la
* Licencia P�blica General de GNU para obtener m�s detalles.
*
* Deber�a haber recibido una copia de la Licencia P�blica General de GNU
* junto con este programa. Si no es as�, consulte
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
* Implementa el patr�n de dise�o Data Access Object para proporcionar una
* interfaz gen�rica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas nativas de Visual FoxPro (.DBF).
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_cabenot2 AS dao_cabenot2 OF dao_cabenot2.prg
    **/
    * @section M�TODOS P�BLICOS
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool existe_nota(int tnTipoNota, int tnNroNota)
    * @method bool existe_cdc(string tcCdc)
    */

    **/
    * Verifica si un documento ya existe en la tabla.
    *
    * @param int tnTipoDocu Tipo del documento.
    * @param int tnNroDocu N�mero �nico del documento seg�n el tipo.
    * @return bool .T. si el documento existe o si ocurre un error;
    *              .F. si no existe.
    */
    FUNCTION existe_nota
        LPARAMETERS tnTipoNota, tnNroNota

        * inicio { validaciones de par�metros }
        IF !THIS.tnTipoNota_Valid(tnTipoNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnTipoNota')
            RETURN .T.
        ENDIF

        IF !THIS.tnNroNota_Valid(tnNroNota) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnNroNota')
            RETURN .T.
        ENDIF
        * fin { validaciones de par�metros }

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
    * @param string tcCdc CDC de 44 d�gitos.
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
    * @section M�TODOS PROTEGIDOS
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool conectar()
    * @method bool desconectar()
    */

    **/
    * Establece conexi�n con la base de datos.
    *
    * @param bool [tlModoEscritura] .T. para abrir en modo lectura/escritura, o
    *                               .F. para abrir en modo solo lectura.
    *                               Si no se especifica, predeterminado .F.
    * @return bool .T. si la conexi�n se establece correctamente, o
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
    * Cierra la conexi�n con la base de datos.
    *
    * @return bool .T. si la conexi�n se cierra correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC
ENDDEFINE
