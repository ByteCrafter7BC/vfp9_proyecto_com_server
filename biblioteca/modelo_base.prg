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
    * @var int Código numérico único del registro.
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
    * @param int tnCodigo Código numérico único del modelo.
    * @param string tcNombre Nombre descriptivo del modelo.
    * @param bool tlVigente Estado de vigencia del modelo.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
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
    * Devuelve el código del registro.
    *
    * @return int Código numérico único del registro.
    */
    FUNCTION obtener_codigo
        RETURN THIS.nCodigo
    ENDFUNC

    **/
    * Devuelve el nombre del registro.
    *
    * @return string Nombre descriptivo del registro.
    */
    FUNCTION obtener_nombre
        RETURN THIS.cNombre
    ENDFUNC

    **
    * Verifica si el registro está vigente.
    *
    * @return bool .T. si el registro está vigente; .F. si no lo está.
    */
    FUNCTION esta_vigente
        RETURN THIS.lVigente
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades 'código', 'nombre' y 'vigente' del objeto actual
    * con las del otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
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

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool asignar_cadena(string tcPropiedad, string tcValor)
    * @method bool asignar_numerico(string tcPropiedad, double tnValor)
    */

    **/
    * Asigna un valor de tipo cadena de caracteres a una propiedad del objeto.
    *
    * @param string tcPropiedad Nombre de la propiedad a la que se asignará el
    *               valor.
    * @param string tcValor Valor que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @example
    * && Asigna 'José' a THIS.cNombre si la propiedad existe.
    * THIS.asignar_cadena('cNombre', ' José ')
    *
    * @throws void No lanza excepciones, pero retorna .F. si los parámetros no
    *              son válidos o la propiedad no existe.
    *
    * @see PEMSTATUS() Para verificar existencia y accesibilidad de propiedades.
    * @see ALLTRIM() Para eliminar espacios en blanco antes y después del valor.
    * @see STORE TO  Para asignar valor a una propiedad dinámica.
    */
    PROTECTED FUNCTION asignar_cadena
        LPARAMETERS tcPropiedad, tcValor

        IF VARTYPE(tcPropiedad) != 'C' ;
                OR EMPTY(tcPropiedad) ;
                OR !PEMSTATUS(THIS, tcPropiedad, 5)
                OR VARTYPE(tcValor) != 'C' THEN
            RETURN .F.
        ENDIF

        STORE ALLTRIM(tcValor) TO ('THIS.' + tcPropiedad)
    ENDFUNC

    **/
    * Asigna un valor numérico a una propiedad del objeto con validación de
    * signo.
    *
    * @param string tcPropiedad Nombre de la propiedad a la que se asignará el
    *               valor.
    * @param double tnValor Valor numérico que se asignará a la propiedad.
    * @param  bool [tlSinSigno] Indica si el valor debe ser positivo (.T.) o
    *                           permite negativos (.F.).
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @example
    * && Asignar un valor positivo obligatorio.
    * THIS.asignar_numerico('nEdad', 25, .T.)
    *
    * && Asignar un valor que puede ser negativo.
    * THIS.asignar_numerico('nSaldo', -150.50, .F.)
    *
    * && Esto fallará porque el valor es negativo pero se requiere positivo.
    * THIS.asignar_numerico('nCantidad', -5, .T.)    && Retorna .F.
    *
    * @see PEMSTATUS() Para verificar existencia y accesibilidad de propiedades.
    * @see STORE TO  Para asignar valor a una propiedad dinámica.
    */
    PROTECTED FUNCTION asignar_numerico
        LPARAMETERS tcPropiedad, tnValor, tlSinSigno

        IF VARTYPE(tcPropiedad) != 'C' ;
                OR EMPTY(tcPropiedad) ;
                OR !PEMSTATUS(THIS, tcPropiedad, 5)
                OR VARTYPE(tnValor) != 'N' ;
                OR VARTYPE(tlSinSigno) != 'L' THEN
            RETURN .F.
        ENDIF

        IF tlSinSigno THEN    && Unsigned: solo puede ser positivo o cero.
            IF tnValor < 0 THEN
                RETURN .F.
            ENDIF
        ENDIF

        STORE tnValor TO ('THIS.' + tcPropiedad)
    ENDFUNC

    **/
    * Asigna un valor lógico (.T. o .F.) a una propiedad del objeto actual.
    *
    * @param string tcPropiedad Nombre de la propiedad a la que se asignará el
    *               valor.
    * @param bool tlValor Valor lógico que se asignará a la propiedad.
    *
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @example
    * THIS.asignar_logico('lVigente', .T.)    && Establece THIS.lVigente a .T.
    *
    * @see PEMSTATUS() Para verificar existencia y accesibilidad de propiedades.
    * @see VARTYPE() Para evaluar el tipo de dato de una variable.
    * @see STORE TO  Para asignar valor a una propiedad dinámica.
    */
    PROTECTED FUNCTION asignar_logico
        LPARAMETERS tcPropiedad, tlValor

        IF VARTYPE(tcPropiedad) != 'C' ;
                OR EMPTY(tcPropiedad) ;
                OR !PEMSTATUS(THIS, tcPropiedad, 5)
                OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        STORE tlValor TO ('THIS.' + tcPropiedad)
    ENDFUNC
ENDDEFINE
