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
* de una tabla. Define las propiedades y m�todos comunes (c�digo, nombre,
* estado de vigencia) que deben tener todos los modelos para interactuar con
* las clases DAO (Data Access Object).
*
* Su prop�sito es asegurar la consistencia y la reutilizaci�n de c�digo en
* todas las clases modelo.
*/
DEFINE CLASS modelo_base AS Custom
    **/
    * @var int C�digo num�rico del registro.
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
    * @section M�TODOS P�BLICOS
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
    * @param int tnCodigo C�digo num�rico del modelo.
    * @param string tcNombre Nombre descriptivo del modelo.
    * @param bool tlVigente Estado de vigencia del modelo.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente.
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
    * Obtiene el c�digo del registro.
    *
    * @return int C�digo num�rico del registro.
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
    * Verifica si el registro est� vigente.
    *
    * @return bool .T. si el registro est� vigente.
    */
    FUNCTION esta_vigente
        RETURN THIS.lVigente
    ENDFUNC

    **/
    * Compara si dos objetos modelo son id�nticos.
    *
    * Compara las propiedades 'c�digo', 'nombre' y 'vigente' del objeto actual
    * con las de otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    *
    * @return bool .T. si los objetos son id�nticos.
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
