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
* Esta clase se utiliza para transportar datos de modelos para órdenes de
* trabajo entre diferentes capas de la aplicación. Hereda de 'dto_base' y
* añade propiedades para dos parámetros numéricos específicos ('maquina'
* y 'marca') con sus respectivos getters y setters para validación.
*/
DEFINE CLASS dto_modelos AS dto_base OF dto_base.prg
    **/
    * @var int Código de la máquina.
    */
    PROTECTED nMaquina

    **/
    * @var int Código de la marca.
    */
    PROTECTED nMarca

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
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
    * proporcionan parámetros, todas las propiedades se inicializan con
    * valores predeterminados (0, '', .F.).
    *
    * @param int [tnCodigo] Código numérico único del modelo.
    * @param string [tcNombre] Nombre o descripción del modelo.
    * @param int [tnMaquina] Código de la máquina.
    * @param int [tnMarca] Código de la marca.
    * @param bool [tlVigente] Indica si el modelo está vigente.
    * @return bool .T. si la inicialización se completa correctamente, o
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
    * Devuelve el código de la máquina.
    *
    * @return int
    */
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **/
    * Devuelve el código de la marca.
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
    * Establece el código de la máquina.
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
    * Establece el código de la marca.
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
