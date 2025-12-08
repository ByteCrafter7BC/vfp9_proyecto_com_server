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
* @file modelos.prg
* @package modulo\modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class modelos
* @extends biblioteca\modelo_base
*/

**
* Clase modelo de datos para la entidad 'modelos'.
*
* Hereda de la clase 'modelo_base' y añade dos propiedades numéricas
* específicas: 'maquina' y 'marca'.
*/
DEFINE CLASS modelos AS modelo_base OF modelo_base.prg
    **/
    * @var int Código numérico de la máquina.
    */
    PROTECTED nMaquina

    **/
    * @var int Código numérico de la marca.
    */
    PROTECTED nMarca

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnMaquina, ;
                        int tnMarca, bool tlVigente)
    * @method int obtener_maquina()
    * @method int obtener_marca()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'modelos'.
    *
    * Además de los parámetros de la clase base, inicializa los dos parámetros
    * numéricos específicos de esta clase.
    *
    * @param int tnCodigo Código numérico único del modelo.
    * @param string tcNombre Nombre o descripción del modelo.
    * @param int tnMaquina Código numérico de la máquina.
    * @param int tnMarca Código numérico de la marca.
    * @param bool tlVigente Indica si el modelo está vigente.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMaquina) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMarca) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nMaquina = tnMaquina
            .nMarca = tnMarca
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el código de la máquina.
    *
    * @return int Código numérico de la máquina.
    */
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **/
    * Devuelve el código de la marca.
    *
    * @return int Código numérico de la marca.
    */
    FUNCTION obtener_marca
        RETURN THIS.nMarca
    ENDFUNC

    **/
    * Compara la instancia actual con otro objeto para determinar si son
    * iguales.
    *
    * Compara las propiedades de la clase base y las propiedades específicas
    * ('maquina' y 'marca') de la clase 'modelos'.
    *
    * @param object toModelo Objeto de tipo 'modelos' con el que se comparará.
    * @return bool .T. si los objetos son iguales, o .F. si no lo son.
    * @override
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_maquina() != THIS.nMaquina ;
                OR toModelo.obtener_marca() != THIS.nMarca THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
