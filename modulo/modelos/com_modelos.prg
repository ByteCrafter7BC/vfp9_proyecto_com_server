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
* @file com_modelos.prg
* @package modulo\com_modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_modelos
* @extends biblioteca\com_base
*/

**/
* Componente COM para la gesti�n de modelos para �rdenes de trabajo.
*
* Esta clase act�a como un controlador o una capa de servicio (business object)
* para la entidad 'modelos'. Se expone como un objeto COM para ser utilizado
* por otras aplicaciones.
*/
DEFINE CLASS com_modelos AS com_base OF com_base.prg OLEPUBLIC
    **/
    * @var string Nombre de la clase modelo asociado a este componente.
    */
    cModelo = 'modelos'

    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar([string tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method string obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method mixed obtener_dto()
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toDto)
    * @method bool modificar(object toDto)
    * @method bool borrar(int tnCodigo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnMaquina, int tnMarca)
    * @method mixed obtener_por_nombre(string tcNombre, int tnMaquina, ;
                                       int tnMarca)
    */

    **/
    * Verifica la existencia de un modelo por su nombre, m�quina y marca.
    *
    * @param string tcNombre Nombre del modelo a verificar.
    * @param int tnMaquina C�digo de la m�quina.
    * @param int tnMarca C�digo de la marca.
    * @return bool .T. si el nombre existe o si ocurre un error, o
    *              .F. si el nombre no existe.
    * @override
    */
    FUNCTION existe_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_nombre(tcNombre, tnMaquina, tnMarca)
    ENDFUNC

    **/
    * Realiza la b�squeda de un modelo por su nombre, m�quina y marca.
    *
    * @param string tcNombre Nombre del modelo a buscar.
    * @param int tnMaquina C�digo de la m�quina.
    * @param int tnMarca C�digo de la marca.
    * @return mixed object modelo si el modelo se encuentra, o
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_nombre(tcNombre, tnMaquina, tnMarca)
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
    * Convierte un DTO (Data Transfer Object) a su objeto modelo
    * correspondiente.
    *
    * Extrae los datos de un DTO de tipo 'dto_modelos' para instanciar
    * y devolver un nuevo objeto del modelo 'modelos'.
    *
    * @param object toDto DTO (dto_modelos) que se va a convertir.
    * @return mixed object modelo si la conversi�n se completa correctamente, o
    *               .F. si el par�metro de entrada no es un objeto v�lido.
    * @override
    */
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnMaquina = .obtener_maquina()
            lnMarca = .obtener_marca()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente)
    ENDFUNC
ENDDEFINE
