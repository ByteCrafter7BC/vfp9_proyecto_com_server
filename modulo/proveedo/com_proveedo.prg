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
* @file com_proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_proveedo
* @extends biblioteca\com_base
*/

**/
* Componente COM para la gesti�n de marcas de art�culos.
*
* Esta clase act�a como un controlador o una capa de servicio (business object)
* para la entidad 'proveedo'. Se expone como un objeto COM para ser utilizado
* por otras aplicaciones.
*/
DEFINE CLASS com_proveedo AS com_base OF com_base.prg OLEPUBLIC
    **/
     * @var string Nombre de la clase modelo asociado a este componente.
    */
    cModelo = 'proveedo'

    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method string obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method mixed obtener_dto()
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toDto)
    * @method bool modificar(object toDto)
    * @method bool borrar(int tnCodigo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool existe_ruc(string tcRuc)
    * @method mixed obtener_por_ruc(string tcRuc)
    */

    **/
    * Verifica si un RUC ya existe en la tabla.
    *
    * @param string tcRuc RUC a verificar.
    * @return bool .T. si el RUC existe o si ocurre un error;
    *              .F. si no existe.
    */
    FUNCTION existe_ruc(tcRuc AS String) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el RUC o si ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_ruc(tcRuc)
    ENDFUNC

    **/
    * Devuelve un registro por su RUC.
    *
    * @param string tcRuc RUC del registro a buscar.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    */
    FUNCTION obtener_por_ruc(tcRuc AS String) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el RUC; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_ruc(tcRuc)
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method void establecer_entorno()
    * @method bool establecer_dao()
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method mixed convertir_dto_a_modelo(object toDto)
    */

    **/
    * Convierte un objeto DTO (Data Transfer Object) a su objeto modelo
    * correspondiente.
    *
    * Extrae los datos de un DTO para instanciar y devolver un nuevo objeto del
    * modelo.
    *
    * @param object toDto DTO que se va a convertir.
    * @return mixed object si la conversi�n se completa correctamente;
    *               .F. si el par�metro de entrada no es un objeto v�lido.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @override
    */
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF !es_objeto(toDto) THEN
            RETURN .F.
        ENDIF

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', toDto)
    ENDFUNC
ENDDEFINE
