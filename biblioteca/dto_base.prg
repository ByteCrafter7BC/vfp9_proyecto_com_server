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
* @extends modelo_base
*/

**/
* Clase base abstracta para objetos de transferencia de datos (DTO) mutables.
*
* Esta clase sirve como una plantilla para crear objetos que transportan datos
* entre las capas de la aplicaci�n. Representa un registro de una tabla con las
* propiedades b�sicas de c�digo, nombre y estado de vigencia, las cuales pueden
* ser modificadas despu�s de la creaci�n del objeto a trav�s del m�todo p�blico
* de 'establecer'.
*
* Su prop�sito es asegurar la consistencia y la reutilizaci�n de c�digo en
* todas las clases de DTO.
*/
DEFINE CLASS dto_base AS modelo_base OF modelo_base.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    */

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool Init()
    * @method bool campo_cargar()
    */

    **/
    * Constructor de la clase.
    *
    * @return bool .T. si la inicializaci�n se completa correctamente, o
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
