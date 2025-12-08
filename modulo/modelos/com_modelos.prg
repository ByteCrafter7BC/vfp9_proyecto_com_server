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
* @file com_modelos.prg
* @package modulo\modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_modelos
* @extends biblioteca\com_base
*/

**/
* Componente COM para la gestión de modelos para órdenes de trabajo.
*
* Esta clase actúa como un controlador o una capa de servicio (business object)
* para la entidad 'modelos'. Se expone como un objeto COM para ser utilizado
* por otras aplicaciones.
*/
DEFINE CLASS com_modelos AS com_base OF com_base.prg OLEPUBLIC
    **/
     * @var string Nombre de la clase modelo asociado a este componente.
    */
    cModelo = 'modelos'

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method string obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method mixed obtener_dto()
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toDto)
    * @method bool modificar(object toDto)
    * @method bool borrar(int tnCodigo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnMaquina, int tnMarca)
    * @method mixed obtener_por_nombre(string tcNombre, int tnMaquina, ;
                                       int tnMarca)
    */

    **/
    * Verifica si un nombre ya existe en la tabla; dentro de una máquina y
    * marca específicos.
    *
    * @param string tcNombre Nombre a verificar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
    * @return bool .T. si el nombre existe o si ocurre un error;
    *              .F. si no existe.
    * @override
    */
    FUNCTION existe_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_nombre(tcNombre, tnMaquina, tnMarca)
    ENDFUNC

    **/
    * Devuelve un registro por su nombre; dentro de una máquina y marca
    * específicos.
    *
    * @param string tcNombre Nombre del registro a buscar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_nombre(tcNombre, tnMaquina, tnMarca)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method void establecer_entorno()
    * @method bool establecer_dao()
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
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
    * @return mixed object si la conversión se completa correctamente;
    *               .F. si el parámetro de entrada no es un objeto válido.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @override
    */
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF !es_objeto(toDto) THEN
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente

        WITH toDto
            m.codigo = .obtener('codigo')
            m.nombre = .obtener('nombre')
            m.maquina = .obtener('maquina')
            m.marca = .obtener('marca')
            m.vigente = .obtener('vigente')
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            m.codigo, m.nombre, m.maquina, m.marca, m.vigente)
    ENDFUNC
ENDDEFINE
