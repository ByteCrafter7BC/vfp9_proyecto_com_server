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
* @file ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class ciudades
* @extends biblioteca\modelo_base
*/

**/
* Clase modelo de datos para la entidad 'ciudades'.
*/
DEFINE CLASS ciudades AS modelo_base OF modelo_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed campo_obtener(string tcCampo)
    * @method object campo_obtener_todos()
    * @method bool establecer(string tcCampo)
    * @method mixed obtener(string tcCampo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnDepartamen, ;
                        int tnSifen, bool tlVigente)
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param int tnCodigo Código numérico único del ciudad.
    * @param string tcNombre Nombre descriptivo del ciudad.
    * @param int tnDepartamen Código numérico del departamento.
    * @param int tnSifen Código numérico SIFEN de la ciudad.
    * @param bool tlVigente Estado de vigencia del ciudad.
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @uses bool campo_cargar()
    *       Para cargar los campos a la propiedad protegida 'oCampos'.
    * @uses bool campo_establecer_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !es_numero(tnDepartamen, 0, 999) ;
                OR !es_numero(tnSifen, 0) THEN
            RETURN .F.
        ENDIF

        IF !THIS.campo_cargar() THEN
            RETURN .F.
        ENDIF

        IF !THIS.campo_establecer_valor('departamen', tnDepartamen) ;
                OR !THIS.campo_establecer_valor('sifen', tnSifen) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades de la clase base y las propiedades específicas
    * ('departamen' y 'sifen') de la clase 'ciudades'.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
    * @uses mixed campo_obtener_valor(string tcCampo)
    *       Para obtener el valor de un campo.
    * @override
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnDepartamen, lnSifen

        WITH THIS
            lnDepartamen = .campo_obtener_valor('departamen')
            lnSifen = .campo_obtener_valor('sifen')
        ENDWITH

        IF toModelo.obtener('departamen') != lnDepartamen ;
                OR toModelo.obtener('sifen') != lnSifen THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_cargar()
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    */
ENDDEFINE
