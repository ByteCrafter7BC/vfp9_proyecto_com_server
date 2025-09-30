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
* @file dto_ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_ciudades
* @extends biblioteca\dto_base
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'ciudades'.
*
* Esta clase se utiliza para transportar datos de ciudades entre diferentes
* capas de la aplicaci�n. Hereda de 'dto_base' y a�ade propiedades para dos
* par�metros num�ricos espec�ficos ('departamen' y 'sifen') con sus
* respectivos getters y setters para validaci�n.
*/
DEFINE CLASS dto_ciudades AS dto_base OF dto_base.prg
    **/
    * @var int C�digo del departamento.
    */
    PROTECTED nDepartamen

    **/
    * @var int C�digo SIFEN de la ciudad.
    */
    PROTECTED nSifen

    **/
    * @section M�TODOS P�BLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnDepartamen, ;
                        int tnSifen, bool tlVigente)
    * @method int obtener_departamen()
    * @method int obtener_sifen()
    * @method bool establecer_departamen(int tnDepartamen)
    * @method bool establecer_sifen(int tnSifen)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'dto_ciudades'. Si no se
    * proporcionan par�metros, todas las propiedades se inicializan con
    * valores predeterminados (0, '', .F.).
    *
    * @param int [tnCodigo] C�digo num�rico �nico de la ciudad.
    * @param string [tcNombre] Nombre o descripci�n de la ciudad.
    * @param int [tnDepartamen] C�digo del departamento.
    * @param int [tnSifen] C�digo SIFEN de la ciudad.
    * @param bool [tlVigente] Indica si la ciudad est� vigente.
    * @return bool .T. si la inicializaci�n se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF PARAMETERS() != 5 THEN
            tnCodigo = 0
            tcNombre = ''
            tnDepartamen = 0
            tnSifen = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_departamen(tnDepartamen) ;
                OR !THIS.establecer_sifen(tnSifen) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Devuelve el c�digo del departamento.
    *
    * @return int
    */
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el c�digo SIFEN de la ciudad.
    *
    * @return int
    */
    FUNCTION obtener_sifen
        RETURN THIS.nSifen
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el c�digo del departamento.
    *
    * @param int tnDepartamen
    * @return bool
    */
    FUNCTION establecer_departamen
        LPARAMETERS tnDepartamen

        IF VARTYPE(tnDepartamen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **/
    * Establece el c�digo SIFEN de la ciudad.
    *
    * @param int tnSifen
    * @return bool
    */
    FUNCTION establecer_sifen
        LPARAMETERS tnSifen

        IF VARTYPE(tnSifen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nSifen = tnSifen
    ENDFUNC
ENDDEFINE
