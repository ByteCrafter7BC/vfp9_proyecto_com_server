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
* @file barrios.prg
* @package modulo\barrios
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class barrios
* @extends biblioteca\modelo_base
*/

**
* Clase modelo de datos para la entidad 'barrios'.
*
* Hereda de la clase 'modelo_base' y añade dos propiedades numéricas
* específicas: 'departamen' y 'ciudad'.
*/
DEFINE CLASS barrios AS modelo_base OF modelo_base.prg
    **/
    * @var int Código numérico del departamento.
    */
    PROTECTED nDepartamen

    **/
    * @var int Código numérico de la ciudad.
    */
    PROTECTED nCiudad

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnDepartamen, ;
                        int tnCiudad, bool tlVigente)
    * @method int obtener_departamen()
    * @method int obtener_ciudad()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'barrios'.
    *
    * Además de los parámetros de la clase base, inicializa los dos parámetros
    * numéricos específicos de esta clase.
    *
    * @param int tnCodigo Código numérico único del barrio.
    * @param string tcNombre Nombre o descripción del barrio.
    * @param int tnDepartamen Código numérico del departamento.
    * @param int tnCiudad Código numérico de la ciudad.
    * @param bool tlVigente Indica si el barrio está vigente.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnCiudad, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnDepartamen) != 'N' ;
                OR VARTYPE(tnCiudad) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nDepartamen = tnDepartamen
            .nCiudad = tnCiudad
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el código del departamento.
    *
    * @return int Código numérico del departamento.
    */
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el código de la ciudad.
    *
    * @return int Código numérico de la ciudad.
    */
    FUNCTION obtener_ciudad
        RETURN THIS.nCiudad
    ENDFUNC

    **/
    * Compara la instancia actual con otro objeto para determinar si son
    * iguales.
    *
    * Compara las propiedades de la clase base y las propiedades específicas
    * ('departamen' y 'ciudad') de la clase 'barrios'.
    *
    * @param object toModelo Objeto de tipo 'barrios' con el que se comparará.
    * @return bool .T. si los objetos son iguales, o .F. si no lo son.
    * @override
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_departamen() != THIS.nDepartamen ;
                OR toModelo.obtener_ciudad() != THIS.nCiudad THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
