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
* Clase abstracta que implementa la interfaz de acceso a datos (DAO).
*
* Implementa el patr�n de dise�o Data Access Object para proporcionar una
* interfaz gen�rica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase est� dise�ada para ser implementada por clases DAO espec�ficas de
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
    * @var string Sentencia SQL para la cl�usula ORDER BY.
    */
    PROTECTED cSqlOrder

    **
    * @var string Sentencia SQL para la cl�usula SELECT.
    */
    PROTECTED cSqlSelect

    **
    * @var string Almacena el �ltimo mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * @section M�TODOS P�BLICOS
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
    * Obtiene el �ltimo mensaje de error registrado.
    *
    * @return string Descripci�n del mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
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
    * Este m�todo se llama autom�ticamente al crear una instancia de la clase.
    * Delega la l�gica de configuraci�n al m�todo 'configurar()'.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **/
    * Obtiene el nombre de un registro referencial a partir de su c�digo.
    *
    * @param string tcModelo Nombre del modelo o tabla de la que se desea
    *                        obtener el nombre.
    * @param int tnCodigo C�digo del registro a buscar.
    *
    * @return string Nombre del registro, mensaje de error si el par�metro es
    *                inv�lido, o un mensaje de 'No existe' si el c�digo no
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
    * Valida si un c�digo referencial est� dentro de los rangos permitidos.
    *
    * El rango de c�digos aceptados var�a seg�n el modelo.
    * Esta funci�n ajusta los l�mites de validaci�n de acuerdo al modelo.
    *
    * @param string tcModelo Nombre del modelo o tabla a la que pertenece el
    *                        c�digo.
    * @param int tnCodigo C�digo a validar.
    *
    * @return bool .T. si el c�digo es v�lido para el modelo especificado.
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
    * Valida un c�digo num�rico contra el ancho del c�digo de la clase.
    *
    * Este m�todo gen�rico asegura que el c�digo num�rico tenga un formato
    * correcto y no exceda el ancho m�ximo definido para los c�digos de la
    * tabla.
    *
    * @param int tnCodigo C�digo a validar.
    *
    * @return bool .T. si el c�digo es un n�mero v�lido y est� dentro del rango.
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
    * @return bool .T. si el nombre es una cadena no vac�a y no excede la
    *              longitud m�xima.
    */
    PROTECTED FUNCTION tcNombre_Valid
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' OR EMPTY(tcNombre) ;
                OR LEN(tcNombre) > THIS.nAnchoNombre THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida si un valor es de tipo l�gico.
    *
    * @param bool tlVigente Valor a validar.
    *
    * @return bool .T. si el valor es de tipo l�gico
    */
    PROTECTED FUNCTION tlVigente_Valid
        LPARAMETERS tlVigente
        RETURN VARTYPE(tlVigente) == 'L'
    ENDFUNC

    **/
    * Valida un objeto modelo contra la estructura de la clase DAO.
    *
    * Este m�todo es una validaci�n completa que chequea si el objeto 'toModelo'
    * es del tipo correcto, y si sus propiedades 'codigo', 'nombre' y 'vigente'
    * son v�lidas seg�n los m�todos de validaci�n individuales.
    *
    * @param object toModelo Modelo a validar.
    *
    * @return bool .T. si el objeto es v�lido y cumple con las reglas de
    *              validaci�n de sus propiedades.
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
    * Valida una cadena de texto que se usar� como condici�n de filtrado.
    *
    * Se utiliza para evitar inyecciones de c�digo.
    *
    * @param string tcCondicionFiltro Cadena a validar.
    *
    * @return bool .T. si la cadena no est� vac�a y no excede la longitud
    *              m�xima.
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
    * Este m�todo asegura que la ordenaci�n se realice solo por los campos
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
