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
* entre las capas de la aplicación. Representa un registro de una tabla con las
* propiedades básicas de código, nombre y estado de vigencia, las cuales pueden
* ser modificadas después de la creación del objeto a través de sus métodos
* públicos de 'establecer'.
*
* Su propósito es asegurar la consistencia y la reutilización de código en
* todas las clases de DTO.
*/
DEFINE CLASS dto_base AS Custom
    **/
    * @var int Código numérico del registro.
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
    * @section MÉTODOS PÚBLICOS
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
    * no se proporcionan parámetros, los inicializa con valores predeterminados.
    * La inicialización se realiza a través de los métodos 'establecer',
    * asegurando la validación del tipo de dato.
    *
    * @param int [tnCodigo = 0] Código numérico del DTO.
    * @param string [tcNombre = ''] Nombre descriptivo del DTO.
    * @param bool [tlVigente = .F.] Estado de vigencia del DTO.
    *
    * @return bool .T. si la inicialización fue completada correctamente.
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
    * Obtiene el código del registro.
    *
    * @return int Código numérico del registro.
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
    * Verifica si el registro está vigente.
    *
    * @return bool .T. si el registro está vigente.
    */
    FUNCTION esta_vigente
        RETURN THIS.lVigente
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el código numérico del DTO.
    *
    * @param int tnCodigo Código a establecer.
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
    * @param bool tlVigente Valor lógico a establecer.
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
