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
* @file dto_modelos.prg
* @package modulo\modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_modelos
* @extends biblioteca\dto_base
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'modelos'.
*
* Esta clase se utiliza para transportar datos de modelos para �rdenes de
* trabajo entre diferentes capas de la aplicaci�n. Hereda de 'dto_base' y
* a�ade propiedades para dos par�metros num�ricos espec�ficos ('maquina'
* y 'marca') con sus respectivos getters y setters para validaci�n.
*/
DEFINE CLASS dto_modelos AS dto_base OF dto_base.prg
    **/
    * @var int C�digo de la m�quina.
    */
    PROTECTED nMaquina

    **/
    * @var int C�digo de la marca.
    */
    PROTECTED nMarca

    **/
    * @section M�TODOS P�BLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnMaquina, ;
                        int tnMarca, bool tlVigente)
    * @method int obtener_maquina()
    * @method int obtener_marca()
    * @method bool establecer_maquina(int tnMaquina)
    * @method bool establecer_marca(int tnMarca)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'dto_modelos'. Si no se
    * proporcionan par�metros, todas las propiedades se inicializan con
    * valores predeterminados (0, '', .F.).
    *
    * @param int [tnCodigo] C�digo num�rico �nico del modelo.
    * @param string [tcNombre] Nombre o descripci�n del modelo.
    * @param int [tnMaquina] C�digo de la m�quina.
    * @param int [tnMarca] C�digo de la marca.
    * @param bool [tlVigente] Indica si el modelo est� vigente.
    * @return bool .T. si la inicializaci�n se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF PARAMETERS() != 5 THEN
            tnCodigo = 0
            tcNombre = ''
            tnMaquina = 0
            tnMarca = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_maquina(tnMaquina) ;
                OR !THIS.establecer_marca(tnMarca) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Devuelve el c�digo de la m�quina.
    *
    * @return int
    */
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **/
    * Devuelve el c�digo de la marca.
    *
    * @return int
    */
    FUNCTION obtener_marca
        RETURN THIS.nMarca
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el c�digo de la m�quina.
    *
    * @param int tnMaquina
    * @return bool
    */
    FUNCTION establecer_maquina
        LPARAMETERS tnMaquina

        IF VARTYPE(tnMaquina) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nMaquina = tnMaquina
    ENDFUNC

    **/
    * Establece el c�digo de la marca.
    *
    * @param int tnMarca
    * @return bool
    */
    FUNCTION establecer_marca
        LPARAMETERS tnMarca

        IF VARTYPE(tnMarca) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nMarca = tnMarca
    ENDFUNC
ENDDEFINE
