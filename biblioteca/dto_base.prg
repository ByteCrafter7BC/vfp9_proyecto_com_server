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
* @file dto_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class dto_base
* @extends Custom
*/

**/
* Clase base abstracta para objetos de transferencia de datos (DTO) mutables.
*
* Esta clase sirve como una plantilla para crear objetos que transportan datos
* entre las capas de la aplicaci�n. Representa un registro de una tabla con las
* propiedades b�sicas de c�digo, nombre y estado de vigencia, las cuales pueden
* ser modificadas despu�s de la creaci�n del objeto a trav�s de sus m�todos
* p�blicos de 'establecer'.
*
* Su prop�sito es asegurar la consistencia y la reutilizaci�n de c�digo en
* todas las clases de DTO.
*/
DEFINE CLASS dto_base AS Custom
    **/
    * @var int C�digo num�rico del registro.
    */
    PROTECTED nCodigo

    **/
    * @var string Nombre descriptivo del registro.
    */
    PROTECTED cNombre

    **/
    * @var bool Indica si el registro se encuentra vigente.
    */
    PROTECTED lVigente

    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init([int tnCodigo], [string tcNombre], [bool tlVigente])
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados. Si
    * no se proporcionan par�metros, los inicializa con valores predeterminados.
    * La inicializaci�n se realiza a trav�s de los m�todos 'establecer',
    * asegurando la validaci�n del tipo de dato.
    *
    * @param int [tnCodigo = 0] C�digo num�rico del DTO.
    * @param string [tcNombre = ''] Nombre descriptivo del DTO.
    * @param bool [tlVigente = .F.] Estado de vigencia del DTO.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente.
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF PARAMETERS() != 3 THEN
            tnCodigo = 0
            tcNombre = ''
            tlVigente = .F.
        ENDIF

        IF !THIS.establecer_codigo(tnCodigo) ;
                OR !THIS.establecer_nombre(tcNombre) ;
                OR !THIS.establecer_vigente(tlVigente) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Obtiene el c�digo del registro.
    *
    * @return int C�digo num�rico del registro.
    */
    FUNCTION obtener_codigo
        RETURN THIS.nCodigo
    ENDFUNC

    **/
    * Obtiene el nombre del registro.
    *
    * @return string Nombre descriptivo del registro.
    */
    FUNCTION obtener_nombre
        RETURN THIS.cNombre
    ENDFUNC

    **
    * Verifica si el registro est� vigente.
    *
    * @return bool .T. si el registro est� vigente.
    */
    FUNCTION esta_vigente
        RETURN THIS.lVigente
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el c�digo num�rico del DTO.
    *
    * @param int tnCodigo C�digo a establecer.
    *
    * @return bool .T. si el valor fue establecido correctamente.
    */
    FUNCTION establecer_codigo
        LPARAMETERS tnCodigo

        IF VARTYPE(tnCodigo) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nCodigo = tnCodigo
    ENDFUNC

    **/
    * Establece el nombre del DTO, eliminando los espacios en blanco.
    *
    * @param string tcNombre Nombre a establecer.
    *
    * @return bool .T. si el valor fue establecido correctamente.
    */
    FUNCTION establecer_nombre
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' THEN
            RETURN .F.
        ENDIF

        THIS.cNombre = ALLTRIM(tcNombre)
    ENDFUNC

    **/
    * Establece el estado de vigencia del DTO.
    *
    * @param bool tlVigente Valor l�gico a establecer.
    *
    * @return bool .T. si el valor fue establecido correctamente.
    */
    FUNCTION establecer_vigente
        LPARAMETERS tlVigente

        IF VARTYPE(tlVigente) != 'L' THEN
            RETURN .F.
        ENDIF

        THIS.lVigente = tlVigente
    ENDFUNC
ENDDEFINE
