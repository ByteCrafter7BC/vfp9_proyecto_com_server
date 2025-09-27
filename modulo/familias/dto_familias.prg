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
* @file dto_familias.prg
* @package modulo\familias
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_familias
* @extends biblioteca\dto_base
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'familias'.
*
* Esta clase se utiliza para transportar datos de familias de artículos entre
* diferentes capas de la aplicación. Hereda de 'dto_base' y añade propiedades
* para cinco parámetros numéricos específicos (P1 a P5) con sus respectivos
* getters y setters para validación.
*/
DEFINE CLASS dto_familias AS dto_base OF dto_base.prg
    **/
    * @var float Porcentaje para la lista de precios de venta 1.
    */
    PROTECTED nP1

    **/
    * @var float Porcentaje para la lista de precios de venta 2.
    */
    PROTECTED nP2

    **/
    * @var float Porcentaje para la lista de precios de venta 3.
    */
    PROTECTED nP3

    **/
    * @var float Porcentaje para la lista de precios de venta 4.
    */
    PROTECTED nP4

    **/
    * @var float Porcentaje para la lista de precios de venta 5.
    */
    PROTECTED nP5

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init([int tnCodigo], [string tcNombre], [float tnP1], ;
                        [float tnP2], [float tnP3], [float tnP4], ;
                        [float tnP5], [bool tlVigente])
    * @method float obtener_p1()
    * @method float obtener_p2()
    * @method float obtener_p3()
    * @method float obtener_p4()
    * @method float obtener_p5()
    * @method bool establecer_p1(float tnP1)
    * @method bool establecer_p2(float tnP2)
    * @method bool establecer_p3(float tnP3)
    * @method bool establecer_p4(float tnP4)
    * @method bool establecer_p5(float tnP5)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'dto_familias'. Si no se
    * proporcionan parámetros, todas las propiedades se inicializan con
    * valores predeterminados (0, '', .F.).
    *
    * @param int [tnCodigo] Código numérico único de la familia.
    * @param string [tcNombre] Nombre o descripción de la familia.
    * @param float [tnP1] Porcentaje para la lista de precios de venta 1.
    * @param float [tnP2] Porcentaje para la lista de precios de venta 2.
    * @param float [tnP3] Porcentaje para la lista de precios de venta 3.
    * @param float [tnP4] Porcentaje para la lista de precios de venta 4.
    * @param float [tnP5] Porcentaje para la lista de precios de venta 5.
    * @param bool [tlVigente] Indica si la familia está vigente.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnP1, tnP2, tnP3, tnP4, tnP5, tlVigente

        IF PARAMETERS() != 8 THEN
            tnCodigo = 0
            tcNombre = ''
            tnP1 = 0
            tnP2 = 0
            tnP3 = 0
            tnP4 = 0
            tnP5 = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_p1(tnP1) ;
                OR !THIS.establecer_p2(tnP2) ;
                OR !THIS.establecer_p3(tnP3) ;
                OR !THIS.establecer_p4(tnP4) ;
                OR !THIS.establecer_p5(tnP5) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Obtiene el porcentaje para la lista de precios de venta 1.
    *
    * @return float
    */
    FUNCTION obtener_p1
        RETURN THIS.nP1
    ENDFUNC

    **/
    * Obtiene el porcentaje para la lista de precios de venta 2.
    *
    * @return float
    */
    FUNCTION obtener_p2
        RETURN THIS.nP2
    ENDFUNC

    **/
    * Obtiene el porcentaje para la lista de precios de venta 3.
    *
    * @return float
    */
    FUNCTION obtener_p3
        RETURN THIS.nP3
    ENDFUNC

    **/
    * Obtiene el porcentaje para la lista de precios de venta 4.
    *
    * @return float
    */
    FUNCTION obtener_p4
        RETURN THIS.nP4
    ENDFUNC

    **/
    * Obtiene el porcentaje para la lista de precios de venta 5.
    *
    * @return float
    */
    FUNCTION obtener_p5
        RETURN THIS.nP5
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el porcentaje para la lista de precios de venta 1.
    *
    * @param float tnP1
    * @return bool
    */
    FUNCTION establecer_p1
        LPARAMETERS tnP1

        IF VARTYPE(tnP1) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP1 = tnP1
    ENDFUNC

    **/
    * Establece el porcentaje para la lista de precios de venta 2.
    *
    * @param float tnP2
    * @return bool
    */
    FUNCTION establecer_p2
        LPARAMETERS tnP2

        IF VARTYPE(tnP2) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP2 = tnP2
    ENDFUNC

    **/
    * Establece el porcentaje para la lista de precios de venta 3.
    *
    * @param float tnP3
    * @return bool
    */
    FUNCTION establecer_p3
        LPARAMETERS tnP3

        IF VARTYPE(tnP3) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP3 = tnP3
    ENDFUNC

    **/
    * Establece el porcentaje para la lista de precios de venta 4.
    *
    * @param float tnP4
    * @return bool
    */
    FUNCTION establecer_p4
        LPARAMETERS tnP4

        IF VARTYPE(tnP4) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP4 = tnP4
    ENDFUNC

    **/
    * Establece el porcentaje para la lista de precios de venta 5.
    *
    * @param float tnP5
    * @return bool
    */
    FUNCTION establecer_p5
        LPARAMETERS tnP5

        IF VARTYPE(tnP5) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP5 = tnP5
    ENDFUNC
ENDDEFINE
