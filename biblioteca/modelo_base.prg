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
* @file modelo_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class modelo_base
* @extends Custom
*/

**/
* Clase base abstracta para modelos de datos.
*
* Esta clase sirve como plantilla para los objetos que representan los datos
* de una tabla. Define las propiedades y métodos comunes (código, nombre,
* estado de vigencia) que deben tener todos los modelos para interactuar con
* las clases DAO (Data Access Object).
*
* Su propósito es asegurar la consistencia y la reutilización de código en
* todas las clases modelo.
*/
DEFINE CLASS modelo_base AS Custom
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
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param int tnCodigo Código numérico del modelo.
    * @param string tcNombre Nombre descriptivo del modelo.
    * @param bool tlVigente Estado de vigencia del modelo.
    *
    * @return bool .T. si la inicialización fue completada correctamente.
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF VARTYPE(tnCodigo) != 'N' ;
                OR VARTYPE(tcNombre) != 'C' ;
                OR VARTYPE(tlVigente) != 'L' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nCodigo = tnCodigo
            .cNombre = tcNombre
            .lVigente = tlVigente
        ENDWITH
    ENDFUNC

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
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades 'código', 'nombre' y 'vigente' del objeto actual
    * con las de otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    *
    * @return bool .T. si los objetos son idénticos.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.Name) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_codigo() != THIS.nCodigo ;
                OR toModelo.obtener_nombre() != THIS.cNombre ;
                OR toModelo.esta_vigente() != THIS.lVigente THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
