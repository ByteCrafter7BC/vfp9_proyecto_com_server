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
* @extends modelo_base
*/

**/
* Clase base abstracta para objetos de transferencia de datos (DTO) mutables.
*
* Esta clase sirve como una plantilla para crear objetos que transportan datos
* entre las capas de la aplicación. Representa un registro de una tabla con las
* propiedades básicas de código, nombre y estado de vigencia, las cuales pueden
* ser modificadas después de la creación del objeto a través del método público
* de 'establecer'.
*
* Su propósito es asegurar la consistencia y la reutilización de código en
* todas las clases de DTO.
*/
DEFINE CLASS dto_base AS modelo_base OF modelo_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init()
    * @method bool campo_cargar()
    */

    **/
    * Constructor de la clase.
    *
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION Init
        IF !THIS.campo_cargar() THEN
            RETURN .F.
        ENDIF

        * Establece todos los setter a verdadero (.T.).
        IF !THIS.campo_establecer_setter_todos(.T.) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Carga los campos a la propiedad protegida 'oCampos'.
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @uses mixed campo_obtener_todos(string tcModelo)
    *       Para cargar los campos del modelo.
    * @override
    */
    PROTECTED FUNCTION campo_cargar
        IF ATC('dto_', THIS.Name) == 0 THEN
            RETURN .F.
        ENDIF

        LOCAL loCampos
        loCampos = campo_obtener_todos(SUBSTR(LOWER(THIS.Name), 5))

        IF VARTYPE(loCampos) != 'O' OR loCampos.Count == 0 THEN
            RETURN .F.
        ENDIF

        THIS.oCampos = loCampos
    ENDFUNC
ENDDEFINE
