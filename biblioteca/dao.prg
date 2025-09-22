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
* Clase abstracta que implementa la interfaz de acceso a datos (DAO).
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase está diseñada para ser implementada por clases DAO específicas de
* cada tabla a gestionar.
*
* @file dao.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class dao
* @extends interfaz_dao
* @implements interfaz_dao
* @see interfaz_dao
* @uses constantes.h
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao AS interfaz_dao OF interfaz_dao.prg
    **/
    * @var string Nombre de la clase que representa el modelo de datos.
    */
    PROTECTED cModelo

    **/
    * @var int Ancho del campo 'codigo' de la tabla.
    */
    PROTECTED nAnchoCodigo

    **/
    * @var int Ancho del campo 'nombre' de la tabla.
    */
    PROTECTED nAnchoNombre

    **
    * @var string Sentencia SQL para la cláusula ORDER BY.
    */
    PROTECTED cSqlOrder

    **
    * @var string Sentencia SQL para la cláusula SELECT.
    */
    PROTECTED cSqlSelect

    **
    * @var string Almacena el último mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method string obtener_ultimo_error() !!
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    */

    **/
    * Obtiene el último mensaje de error registrado.
    *
    * @return string Descripción del mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar([bool tlModoEscritura])
    * @method bool desconectar()
    * @method bool Init() !
    * @method string obtener_nombre_referencial(string tcModelo, int tnCodigo) !
    * @method bool validar_codigo_referencial(string tcModelo, int tnCodigo) !
    * @method bool tnCodigo_Valid(int tnCodigo) !
    * @method bool tcNombre_Valid(string tcNombre) !
    * @method bool tlVigente_Valid(bool tlVigente) !
    * @method bool toModelo_Valid(object toModelo) !
    * @method bool tcCondicionFiltro_Valid(string tcCondicionFiltro) !
    * @method bool tcOrden_Valid(string tcOrden) !
    */

    **/
    * Constructor de la clase DAO.
    *
    * Este método se llama automáticamente al crear una instancia de la clase.
    * Delega la lógica de configuración al método 'configurar()'.
    *
    * @return bool .T. si la inicialización fue completada correctamente.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **/
    * Obtiene el nombre de un registro referencial a partir de su código.
    *
    * @param string tcModelo Nombre del modelo o tabla de la que se desea
    *                        obtener el nombre.
    * @param int tnCodigo Código del registro a buscar.
    *
    * @return string Nombre del registro, mensaje de error si el parámetro es
    *                inválido, o un mensaje de 'No existe' si el código no
    *                existe.
    */
    PROTECTED FUNCTION obtener_nombre_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tcModelo')
        ENDIF

        IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 0, 9999) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
        ENDIF

        IF tnCodigo == 0 THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL lcNombre
        lcNombre = dao_obtener_nombre(tcModelo, tnCodigo)

        IF EMPTY(lcNombre) THEN
            RETURN NO_EXISTE
        ENDIF

        RETURN lcNombre
    ENDFUNC

    **/
    * Valida si un código referencial está dentro de los rangos permitidos.
    *
    * El rango de códigos aceptados varía según el modelo.
    * Esta función ajusta los límites de validación de acuerdo al modelo.
    *
    * @param string tcModelo Nombre del modelo o tabla a la que pertenece el
    *                        código.
    * @param int tnCodigo Código a validar.
    *
    * @return bool .T. si el código es válido para el modelo especificado.
    */
    PROTECTED FUNCTION validar_codigo_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnMinimo, lnMaximo
        lnMinimo = 1
        lnMaximo = 9999

        DO CASE
        CASE INLIST(tcModelo, 'cobrador', 'depar', 'maquinas', 'mecanico', ;
                'vendedor')
            lnMaximo = 999
        CASE INLIST(tcModelo, 'barrios', 'ciudades', 'sifen')
            lnMaximo = 99999
        CASE INLIST(tcModelo, 'maquinas', 'marcas2')
            lnMinimo = 0
        ENDCASE

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, lnMinimo, lnMaximo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida un código numérico contra el ancho del código de la clase.
    *
    * Este método genérico asegura que el código numérico tenga un formato
    * correcto y no exceda el ancho máximo definido para los códigos de la
    * tabla.
    *
    * @param int tnCodigo Código a validar.
    *
    * @return bool .T. si el código es un número válido y está dentro del rango.
    */
    PROTECTED FUNCTION tnCodigo_Valid
        LPARAMETERS tnCodigo

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, 1, THIS.nAnchoCodigo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida un nombre contra el ancho del nombre de la clase.
    *
    * Se utiliza para verificar la integridad de la entrada del usuario para
    * los campos de nombre.
    *
    * @param string tcNombre Nombre a validar.
    *
    * @return bool .T. si el nombre es una cadena no vacía y no excede la
    *              longitud máxima.
    */
    PROTECTED FUNCTION tcNombre_Valid
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' OR EMPTY(tcNombre) ;
                OR LEN(tcNombre) > THIS.nAnchoNombre THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida si un valor es de tipo lógico.
    *
    * @param bool tlVigente Valor a validar.
    *
    * @return bool .T. si el valor es de tipo lógico
    */
    PROTECTED FUNCTION tlVigente_Valid
        LPARAMETERS tlVigente
        RETURN VARTYPE(tlVigente) == 'L'
    ENDFUNC

    **/
    * Valida un objeto modelo contra la estructura de la clase DAO.
    *
    * Este método es una validación completa que chequea si el objeto 'toModelo'
    * es del tipo correcto, y si sus propiedades 'codigo', 'nombre' y 'vigente'
    * son válidas según los métodos de validación individuales.
    *
    * @param object toModelo Modelo a validar.
    *
    * @return bool .T. si el objeto es válido y cumple con las reglas de
    *              validación de sus propiedades.
    */
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.cModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnCodigo_Valid(toModelo.obtener_codigo()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tcNombre_Valid(toModelo.obtener_nombre()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tlVigente_Valid(toModelo.esta_vigente()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida una cadena de texto que se usará como condición de filtrado.
    *
    * Se utiliza para evitar inyecciones de código.
    *
    * @param string tcCondicionFiltro Cadena a validar.
    *
    * @return bool .T. si la cadena no está vacía y no excede la longitud
    *              máxima.
    */
    PROTECTED FUNCTION tcCondicionFiltro_Valid
        LPARAMETERS tcCondicionFiltro

        IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) ;
                OR LEN(tcCondicionFiltro) > 150 THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida una cadena de texto que indica el ordenamiento de los datos.
    *
    * Este método asegura que la ordenación se realice solo por los campos
    * permitidos para la clase DAO.
    *
    * @param string tcOrden Cadena a validar ('codigo' o 'nombre').
    *
    * @return bool .T. si la cadena es 'codigo' o 'nombre'
    */
    PROTECTED FUNCTION tcOrden_Valid
        LPARAMETERS tcOrden

        IF VARTYPE(tcOrden) != 'C' OR EMPTY(tcOrden) ;
                OR !INLIST(tcOrden, 'codigo', 'nombre') THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
