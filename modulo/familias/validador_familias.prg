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
* @file validador_familias.prg
* @package modulo\familias
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_familias
* @extends biblioteca\validador_base
* @uses constantes.h
*/

**
* Clase de validaci�n para el modelo 'familias'.
*
* Hereda de la clase 'validador_base' y a�ade propiedades espec�ficas para
* cinco par�metros num�ricos (P1 a P5). Estos par�metros representan los
* porcentajes de incremento sobre el precio de costo para las diferentes
* listas de precios de venta.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_familias AS validador_base OF validador_base.prg
    **/
    * @var string Mensaje de error para el porcentaje de la lista 1.
    */
    PROTECTED cErrorP1

    **/
    * @var string Mensaje de error para el porcentaje de la lista 2.
    */
    PROTECTED cErrorP2

    **/
    * @var string Mensaje de error para el porcentaje de la lista 3.
    */
    PROTECTED cErrorP3

    **/
    * @var string Mensaje de error para el porcentaje de la lista 4.
    */
    PROTECTED cErrorP4

    **/
    * @var string Mensaje de error para el porcentaje de la lista 5.
    */
    PROTECTED cErrorP5

    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool es_valido()
    * @method string obtener_error_p1()
    * @method string obtener_error_p2()
    * @method string obtener_error_p3()
    * @method string obtener_error_p4()
    * @method string obtener_error_p5()
    */

    **/
    * Verifica si el modelo es v�lido seg�n la operaci�n (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe alg�n
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que la familia no est�
    *   relacionada con otros registros de la base de datos antes de permitir
    *   la operaci�n.
    *
    * @return bool .T. si el modelo es v�lido para la operaci�n.
    * @override
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorP1) ;
                    OR !EMPTY(THIS.cErrorP2) ;
                    OR !EMPTY(THIS.cErrorP3) ;
                    OR !EMPTY(THIS.cErrorP4) ;
                    OR !EMPTY(THIS.cErrorP5) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **
    * Obtiene el mensaje de error para el porcentaje de la lista 1, o una
    * cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_p1
        RETURN IIF(VARTYPE(THIS.cErrorP1) == 'C', THIS.cErrorP1, '')
    ENDFUNC

    **
    * Obtiene el mensaje de error para el porcentaje de la lista 2, o una
    * cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_p2
        RETURN IIF(VARTYPE(THIS.cErrorP2) == 'C', THIS.cErrorP2, '')
    ENDFUNC

    **
    * Obtiene el mensaje de error para el porcentaje de la lista 3, o una
    * cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_p3
        RETURN IIF(VARTYPE(THIS.cErrorP3) == 'C', THIS.cErrorP3, '')
    ENDFUNC

    **
    * Obtiene el mensaje de error para el porcentaje de la lista 4, o una
    * cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_p4
        RETURN IIF(VARTYPE(THIS.cErrorP4) == 'C', THIS.cErrorP4, '')
    ENDFUNC

    **
    * Obtiene el mensaje de error para el porcentaje de la lista 5, o una
    * cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_p5
        RETURN IIF(VARTYPE(THIS.cErrorP5) == 'C', THIS.cErrorP5, '')
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method string validar_codigo()
    * @method string validar_nombre()
    * @method string validar_vigente()
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method void validar()
    * @method string validar_p(int tnLista)
    */

    **
    * Ejecuta todas las reglas de validaci�n para la familia.
    *
    * Llama al m�todo de validaci�n de la clase base y luego ejecuta las
    * validaciones espec�ficas para los par�metros P1 a P5.
    *
    * Este m�todo es llamado por el constructor ('Init') para las operaciones
    * de agregar (bandera 1) y modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los m�todos de validaci�n
    * en las propiedades de error de la clase.
    *
    * @override
    */
    PROTECTED PROCEDURE validar
        validador_base::validar()

        WITH THIS
            .cErrorP1 = THIS.validar_p(1)
            .cErrorP2 = THIS.validar_p(2)
            .cErrorP3 = THIS.validar_p(3)
            .cErrorP4 = THIS.validar_p(4)
            .cErrorP5 = THIS.validar_p(5)
        ENDWITH
    ENDPROC

    **/
    * Valida un par�metro num�rico espec�fico (P1 a P5).
    *
    * Verifica que el valor del par�metro sea num�rico, mayor o igual a cero
    * y no exceda el l�mite de 999.99.
    *
    * @param int tnLista N�mero del par�metro a validar (de 1 a 5).
    * @return string Una cadena vac�a si la validaci�n es exitosa, o el mensaje
    *                de error correspondiente en caso de fallo.
    */
    PROTECTED FUNCTION validar_p
        LPARAMETERS tnLista

        IF VARTYPE(tnLista) != 'N' OR !BETWEEN(tnLista, 1, 5) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tnLista')
        ENDIF

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        LOCAL lcEtiqueta, lnP
        lcEtiqueta = '% ' + STR(tnLista, 1) + ': '

        lnP = EVALUATE('THIS.oModelo.obtener_p' + STR(tnLista, 1) + '()')

        IF VARTYPE(lnP) != 'N' THEN
            RETURN lcEtiqueta + TIPO_NUMERICO
        ENDIF

        IF lnP < 0 THEN
            RETURN lcEtiqueta + MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnP > 999.99 THEN
            RETURN lcEtiqueta + STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(999 + 1)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
