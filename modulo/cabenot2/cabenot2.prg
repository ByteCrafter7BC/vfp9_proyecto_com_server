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
* @file cabenot2.prg
* @package modulo\cabenot2
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class cabenot2
* @extends Custom
*/

**/
* Clase modelo de datos para la entidad 'cabenot2'.
*/
DEFINE CLASS cabenot2 AS Custom
    **/
    * @var int Tipo de documento.
    */
    PROTECTED nTipoNota

    **/
    * @var int Número único de documento según el tipo.
    */
    PROTECTED nNroNota

    **/
    * @var string CDC de 44 dígitos.
    */
    PROTECTED cCdc

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnTipoNota, int tnNroNota, string tcCdc)
    * @method int obtener_tiponota()
    * @method int obtener_nronota()
    * @method string obtener_cdc()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param int tnTipoNota Tipo de documento.
    * @param int tnNroNota Número único de documento según el tipo.
    * @param string tcCdc CDC de 44 dígitos.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    */
    FUNCTION Init
        LPARAMETERS tnTipoNota, tnNroNota, tcCdc

        IF VARTYPE(tnTipoNota) != 'N' ;
                OR VARTYPE(tnNroNota) != 'N' ;
                OR VARTYPE(tcCdc) != 'C' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nTipoNota = tnTipoNota
            .nNroNota = tnNroNota
            .cCdc = tcCdc
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el tipo de documento.
    *
    * @return int Tipo de documento.
    */
    FUNCTION obtener_tiponota
        RETURN THIS.nTipoNota
    ENDFUNC

    **/
    * Devuelve el número de documento.
    *
    * @return int Número único de documento según el tipo.
    */
    FUNCTION obtener_nronota
        RETURN THIS.nNroNota
    ENDFUNC

    **/
    * Devuelve el Código de Control (CDC) del documento.
    *
    * @return string CDC de 44 dígitos.
    */
    FUNCTION obtener_cdc
        RETURN THIS.cCdc
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades 'tiponota', 'nronota' y 'cdc' del objeto actual
    * con las del otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.Name) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_tiponota() != THIS.nTipoNota ;
                OR toModelo.obtener_nronota() != THIS.nNroNota ;
                OR toModelo.obtener_cdc() != THIS.cCdc THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
