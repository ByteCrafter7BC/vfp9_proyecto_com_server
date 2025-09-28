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
* @file familias.prg
* @package modulo\familias
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class familias
* @extends biblioteca\modelo_base
*/

**/
* Clase que representa a una familia de art�culos.
*
* Hereda de la clase 'modelo_base' y a�ade propiedades espec�ficas para
* cinco par�metros num�ricos (P1 a P5). Estos par�metros representan los
* porcentajes de incremento sobre el precio de costo para las diferentes
* listas de precios de venta.
*/
DEFINE CLASS familias AS modelo_base OF modelo_base.prg
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
    * @section M�TODOS P�BLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool es_igual(object toModelo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, float tnP1, ;
                        float tnP2, float tnP3, float tnP4, float tnP5, ;
                        bool tlVigente)
    * @method float obtener_p1()
    * @method float obtener_p2()
    * @method float obtener_p3()
    * @method float obtener_p4()
    * @method float obtener_p5()
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'familias'.
    *
    * Adem�s de los par�metros de la clase base, inicializa los cinco
    * par�metros num�ricos espec�ficos de esta clase.
    *
    * @param int tnCodigo C�digo num�rico �nico de la familia.
    * @param string tcNombre Nombre o descripci�n de la familia.
    * @param float tnP1 Porcentaje para la lista de precios de venta 1.
    * @param float tnP2 Porcentaje para la lista de precios de venta 2.
    * @param float tnP3 Porcentaje para la lista de precios de venta 3.
    * @param float tnP4 Porcentaje para la lista de precios de venta 4.
    * @param float tnP5 Porcentaje para la lista de precios de venta 5.
    * @param bool tlVigente Indica si la familia est� vigente.
    * @return bool .T. si la inicializaci�n se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnP1, tnP2, tnP3, tnP4, tnP5, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnP1) != 'N' ;
                OR VARTYPE(tnP2) != 'N' ;
                OR VARTYPE(tnP3) != 'N' ;
                OR VARTYPE(tnP4) != 'N' ;
                OR VARTYPE(tnP5) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nP1 = tnP1
            .nP2 = tnP2
            .nP3 = tnP3
            .nP4 = tnP4
            .nP5 = tnP5
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista de precios de venta 1.
    *
    * @return float
    */
    FUNCTION obtener_p1
        RETURN THIS.nP1
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista de precios de venta 2.
    *
    * @return float
    */
    FUNCTION obtener_p2
        RETURN THIS.nP2
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista de precios de venta 3.
    *
    * @return float
    */
    FUNCTION obtener_p3
        RETURN THIS.nP3
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista de precios de venta 4.
    *
    * @return float
    */
    FUNCTION obtener_p4
        RETURN THIS.nP4
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista de precios de venta 5.
    *
    * @return float
    */
    FUNCTION obtener_p5
        RETURN THIS.nP5
    ENDFUNC

    **/
    * Compara la instancia actual con otro objeto para determinar si son
    * iguales.
    *
    * Compara las propiedades de la clase base y las propiedades espec�ficas
    * (P1 a P5) de la clase 'familias'.
    *
    * @param object toModelo Objeto de tipo 'familias' con el que se comparar�.
    * @return bool .T. si los objetos son iguales, o .F. si no lo son.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_p1() != THIS.nP1 ;
                OR toModelo.obtener_p2() != THIS.nP2 ;
                OR toModelo.obtener_p3() != THIS.nP3 ;
                OR toModelo.obtener_p4() != THIS.nP4 ;
                OR toModelo.obtener_p5() != THIS.nP5 THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
