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
* @file conjunto_prueba.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class conjunto_prueba
* @extends Custom
*/

**/
* Clase que representa un conjunto de pruebas unitarias.
*
* Define un conjunto de herramientas para realizar pruebas unitarias de forma
* sencilla. Permite ejecutar pruebas, realizar aserciones y obtener un informe
* de resultados.
*/
DEFINE CLASS conjunto_prueba AS Custom
    **/
    * @var int Número total de pruebas ejecutadas.
    */
    PROTECTED nPruebasEjecutadas

    **/
    * @var int Número de pruebas que han pasado exitosamente.
    */
    PROTECTED nPruebasAprobadas

    **/
    * @var int Número de pruebas que han fallado.
    */
    PROTECTED nPruebasFallidas

    **/
    * @section MÉTODOS PÚBLICOS
    * @method void obtener_informe()
    */

    **/
    * Muestra un informe final del conjunto de pruebas.
    *
    * Este método imprime el total de pruebas ejecutadas, aprobadas y fallidas,
    * y muestra un mensaje final indicando si todas las pruebas pasaron o si
    * se encontraron fallos.
    */
    PROCEDURE obtener_informe
        ? REPLICATE('=', 40)
        ? 'Total de pruebas: ' + TRANSFORM(THIS.nPruebasEjecutadas)
        ? 'Pruebas aprobadas: ' + TRANSFORM(THIS.nPruebasAprobadas)
        ? 'Pruebas fallidas: ' + TRANSFORM(THIS.nPruebasFallidas)
        ? '' && línea en blanco explícita.

        IF THIS.nPruebasFallidas > 0 THEN
            ? 'El conjunto de pruebas contiene fallos.'
        ELSE
            ? '¡Todas las pruebas pasaron!'
        ENDIF
    ENDPROC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method void Init()
    * @method void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    * @method bool afirmar_igual(mixed tvEsperado, mixed tvObtenido, ;
                                 string tcMensaje)
    * @method bool afirmar_verdadero(bool tlValor, string tcMensaje)
    * @method bool afirmar_falso(bool tlValor, string tcMensaje)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa los contadores de pruebas en cero al crear una nueva instancia.
    */
    PROTECTED PROCEDURE Init
        STORE 0 TO THIS.nPruebasEjecutadas, ;
                   THIS.nPruebasAprobadas, ;
                   THIS.nPruebasFallidas
    ENDPROC

    **/
    * Ejecuta una prueba individual y actualiza los contadores.
    *
    * Muestra el nombre de la prueba y su resultado (Aprobado o Fallido).
    *
    * @param string tcNombrePrueba Nombre o descripción de la prueba.
    * @param bool tlResultado Resultado de la prueba (.T. = pasó, .F. = falló).
    */
    PROTECTED PROCEDURE ejecutar_prueba
        LPARAMETERS tcNombrePrueba, tlResultado

        THIS.nPruebasEjecutadas = THIS.nPruebasEjecutadas + 1

        ? 'Prueba: ' + TRANSFORM(THIS.nPruebasEjecutadas) + ' | ' + ;
            tcNombrePrueba

        IF tlResultado THEN
            THIS.nPruebasAprobadas = THIS.nPruebasAprobadas + 1
            ? 'Resultado: Pasó'
        ELSE
            THIS.nPruebasFallidas = THIS.nPruebasFallidas + 1
            ? 'Resultado: Falló'
        ENDIF
    ENDPROC

    **/
    * Afirma que dos valores son iguales.
    *
    * Compara un valor esperado con un valor obtenido. Si no son iguales,
    * imprime un mensaje detallado del fallo.
    *
    * @param mixed tvEsperado Valor esperado de la prueba.
    * @param mixed tvObtenido Valor obtenido de la ejecución del código.
    * @param string tcMensaje Mensaje descriptivo del fallo.
    *
    * @return bool .T. si los valores son iguales.
    */
    PROTECTED FUNCTION afirmar_igual
        LPARAMETERS tvEsperado, tvObtenido, tcMensaje

        * inicio { validaciones de parámetros }
        IF VARTYPE(tvEsperado) != VARTYPE(tvObtenido) ;
                OR VARTYPE(tcMensaje) != 'C' OR EMPTY(tcMensaje) THEN
            ? 'ERROR: Parámetros inválidos en afirmar_igual().'
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL llResultado
        llResultado = tvEsperado == tvObtenido

        IF !llResultado THEN
            ? '    > Fallo: ' + tcMensaje
            ? '    > Esperado: ' + TRANSFORM(tvEsperado)
            ? '    > Obtenido: ' + TRANSFORM(tvObtenido)
        ENDIF

        RETURN llResultado
    ENDFUNC

    **/
    * Afirma que un valor es verdadero.
    *
    * Este es un método de conveniencia que llama a {@see afirmar_igual}
    * para verificar si un valor es verdadero.
    *
    * @param bool tlValor Valor lógico a evaluar.
    * @param string tcMensaje Mensaje descriptivo del fallo.
    * @return bool .T. si el valor es verdadero.
    */
    PROTECTED FUNCTION afirmar_verdadero
        LPARAMETERS tlValor, tcMensaje
        RETURN THIS.afirmar_igual(.T., tlValor, tcMensaje)
    ENDFUNC

    **/
    * Afirma que un valor es falso.
    *
    * Este es un método de conveniencia que llama a {@see afirmar_igual}
    * para verificar si un valor es falso.
    *
    * @param bool tlValor Valor lógico a evaluar.
    * @param string tcMensaje Mensaje descriptivo del fallo.
    * @return bool .T. si el valor es falso.
    */
    PROTECTED FUNCTION afirmar_falso
        LPARAMETERS tlValor, tcMensaje
        RETURN THIS.afirmar_igual(.F., tlValor, tcMensaje)
    ENDFUNC
ENDDEFINE
