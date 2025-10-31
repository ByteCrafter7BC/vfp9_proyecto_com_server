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
* @file dao_dbf_proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_proveedo
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO).
*
* Esta clase hereda la funcionalidad básica de la clase 'dao_dbf' y la
* especializa para la tabla 'proveedo'. Su propósito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones específicas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_proveedo AS dao_dbf OF dao_dbf.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method bool esta_vigente(int tnCodigo)
    * @method bool existe_ruc(string tcRuc)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_ruc(string tcRuc)
    */

    **/
    * Verifica si un registro está vigente.
    *
    * @param int tnCodigo Código numérico único a verificar.
    * @return bool .T. si el registro existe y su estado es vigente.
    *              .F. si el registro no existe, no está vigente o si ocurre un
    *              error.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @override
    */
    FUNCTION esta_vigente
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_numero(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL llVigente

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            llVigente = vigente == 'S'
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llVigente
    ENDFUNC

    **/
    * Verifica si un RUC ya existe en la tabla.
    *
    * Realiza una búsqueda no sensible a mayúsculas/minúsculas.
    *
    * @param string tcRuc RUC a verificar.
    * @return bool .T. si el RUC existe o si ocurre un error;
    *              .F. si no existe.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexión con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexión con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    */
    FUNCTION existe_ruc
        LPARAMETERS tcRuc

        LOCAL llExiste, lnAncho

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_cadena(tcRuc) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcRuc')
            RETURN .T.
        ENDIF

        lnAncho = campo_obtener_ancho(THIS.cModelo, 'ruc')

        IF lnAncho == 0 THEN
            THIS.cUltimoError = STRTRAN(STRTRAN(MSG_ERROR_ANCHO_CAMPO, ;
                '{0}', 'ruc'), '{1}', THIS.cModelo)
            RETURN .T.
        ENDIF

        tcRuc = LEFT(UPPER(ALLTRIM(tcRuc)) + SPACE(lnAncho), lnAncho)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR UPPER(ruc) == tcRuc
        llExiste = FOUND()

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **/
    * Verifica si un código está relacionado con otros registros de la base
    * de datos.
    *
    * @param int tnCodigo Código numérico único a verificar.
    * @return bool .T. si el registro está relacionado o si ocurre un error;
    *              .F. si no está relacionado.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @uses bool dao_existe_referencia(string tcModelo, ;
                                       string tcCondicionFiltro)
    *       Para verificar la existencia de registros referenciales en una
    *       tabla.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_numero(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL lcCondicionFiltro, llRelacionado
        lcCondicionFiltro = 'proveedor == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN    && Compras a proveedores.
            llRelacionado = dao_existe_referencia('cabecomp', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Devoluciones a proveedores.
            llRelacionado = dao_existe_referencia('cabenotp', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Pagos a proveedores.
            llRelacionado = dao_existe_referencia('cabepag', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Cuotas de compras a proveedores.
            llRelacionado = dao_existe_referencia('cuotas_c', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Cuotas de devoluciones a proveedores.
            llRelacionado = dao_existe_referencia('cuotas_p', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Detalle de compras a proveedores.
            llRelacionado = dao_existe_referencia('detacomp', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Detalle de devoluciones a proveedores.
            llRelacionado = dao_existe_referencia('detanotp', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Detalle de pagos a proveedores.
            llRelacionado = dao_existe_referencia('detapag', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Artículos.
            llRelacionado = dao_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Devuelve un registro por su RUC.
    *
    * @param string tcRuc RUC del registro a buscar.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexión con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexión con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    */
    FUNCTION obtener_por_ruc
        LPARAMETERS tcRuc

        LOCAL loModelo, lnAncho

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_cadena(tcRuc) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcRuc')
            RETURN .F.
        ENDIF

        lnAncho = campo_obtener_ancho(THIS.cModelo, 'ruc')

        IF lnAncho == 0 THEN
            THIS.cUltimoError = STRTRAN(STRTRAN(MSG_ERROR_ANCHO_CAMPO, ;
                '{0}', 'ruc'), '{1}', THIS.cModelo)
            RETURN .F.
        ENDIF

        tcRuc = LEFT(UPPER(ALLTRIM(tcRuc)) + SPACE(lnAncho), lnAncho)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO 0
        LOCATE FOR UPPER(ruc) == tcRuc
        IF FOUND() THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * @method string obtener_comando_insertar(object toModelo)
    * @method string obtener_comando_reemplazar(object toModelo)
    * @method string obtener_lista_campos(object toModelo)
    * @method bool cargar_valores_a_variables(object toModelo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method mixed obtener_modelo()
    * @method bool validar_agregar()
    * @method bool validar_modificar()
    */

    **/
    * Crea un objeto modelo a partir del registro actual de la tabla.
    *
    * @return mixed object modelo si la operación se completa correctamente;
    *               .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @override
    */
    PROTECTED FUNCTION obtener_modelo
        LOCAL lcDto, loDto, loCampos, loCampo, lcNombre
        lcDto = 'dto_' + THIS.cModelo
        loDto = NEWOBJECT(lcDto, lcDto + '.prg')

        IF !es_objeto(loDto) THEN
            THIS.cUltimoError = STRTRAN(MSG_ERROR_INSTANCIA_CLASE, '{}', lcDto)
            RETURN .F.
        ENDIF

        loCampos = loDto.campo_obtener_todos()

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            THIS.cUltimoError = ;
                'No se pudo obtener la colección de campos del DTO.'
            RETURN .F.
        ENDIF

        FOR EACH loCampo IN loCampos
            lcNombre = loCampo.obtener_nombre()

            IF !loCampo.establecer_valor(EVALUATE(lcNombre)) THEN
                THIS.cUltimoError = ;
                    "No se pudo establecer el valor del campo '" + lcNombre + ;
                    "' del DTO."
                RETURN .F.
            ENDIF
        ENDFOR

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', loDto)
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el método protegido 'agregar'.
    *
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_ruc(string tcRuc)
    *       Para verificar si un RUC ya existe en la tabla.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    PROTECTED FUNCTION validar_agregar
        IF !dao_dbf::validar_agregar() THEN
            RETURN .F.
        ENDIF

        IF THIS.existe_ruc(m.ruc) THEN
            THIS.cUltimoError = "El RUC '" + m.ruc + "' ya existe."
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el método protegido 'modificar'.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses mixed obtener_por_ruc(string tcRuc)
    *       Para obtener un registro por su RUC.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    PROTECTED FUNCTION validar_modificar
        LPARAMETERS toModelo

        IF !dao_dbf::validar_modificar(toModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL loModelo
        loModelo = THIS.obtener_por_ruc(m.ruc)

        IF es_objeto(loModelo) AND loModelo.obtener('codigo') != m.codigo THEN
            THIS.cUltimoError = "El RUC '" + m.ruc + "' ya existe."
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
