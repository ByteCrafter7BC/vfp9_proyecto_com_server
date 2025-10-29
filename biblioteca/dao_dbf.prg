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
* @file dao_dbf.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf
* @extends dao
* @implements interfaz_dao
* @see interfaz_dao, dao
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO) para tablas DBF; deriva de una clase abstracta.
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas nativas de Visual FoxPro (.DBF).
*
* Esta clase está diseñada para ser heredada por clases DAO específicas de cada
* tabla o ser instanciada directamente, configurando la propiedad 'cModelo' con
* el alias de la tabla a gestionar.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf AS dao OF dao.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool esta_relacionado(int tnCodigo)
    * @method string obtener_ultimo_error()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    */

    **/
    * Verifica si un código ya existe en la tabla.
    *
    * Realiza una búsqueda rápida utilizando el índice principal ('indice1').
    *
    * @param int tnCodigo Código numérico único a verificar.
    * @return bool .T. si el código existe o si ocurre un error;
    *              .F. si no existe.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @override
    */
    FUNCTION existe_codigo
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_numero(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        llExiste = SEEK(tnCodigo)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

    **/
    * Verifica si un nombre ya existe en la tabla.
    *
    * Realiza una búsqueda no sensible a mayúsculas/minúsculas utilizando el
    * índice secundario ('indice2').
    *
    * @param string tcNombre Nombre a verificar.
    * @return bool .T. si el nombre existe o si ocurre un error;
    *              .F. si no existe.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @override
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre

        LOCAL llExiste, lnAncho

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        lnAncho = campo_obtener_ancho(THIS.cModelo, 'nombre')

        IF lnAncho == 0 THEN
            THIS.cUltimoError = STRTRAN(STRTRAN(MSG_ERROR_ANCHO_CAMPO, ;
                '{0}', 'nombre'), '{1}', THIS.cModelo)
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(lnAncho), lnAncho)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && UPPER(nombre)
        llExiste = SEEK(tcNombre)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llExiste
    ENDFUNC

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
            llVigente = vigente
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN llVigente
    ENDFUNC

    **/
    * Cuenta el número de registros que cumplen con una condición de filtro.
    *
    * @param string [tcCondicionFiltro] La cláusula WHERE de la consulta, sin
    *                                   la palabra "WHERE".
    * @return int Número de registros contados. Devuelve -1 si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @override
    */
    FUNCTION contar
        LPARAMETERS tcCondicionFiltro

        IF !es_cadena(tcCondicionFiltro, 5, 150) THEN
            tcCondicionFiltro = '!DELETED()'
        ELSE
            tcCondicionFiltro = tcCondicionFiltro + ' AND !DELETED()'
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCantidad

        SELECT (THIS.cModelo)
        COUNT FOR EVALUATE(tcCondicionFiltro) TO lnCantidad

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN lnCantidad
    ENDFUNC


    **/
    * Devuelve el siguiente código numérico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de códigos a partir de 1.
    *
    * @return int Número entero positivo que representa el siguiente código
    *             disponible. Devuelve -1 si ocurre un error.
    * @override
    */
    FUNCTION obtener_nuevo_codigo
        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN -1
        ENDIF

        LOCAL lnCodigo
        lnCodigo = 1

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        SEEK(lnCodigo)
        DO WHILE FOUND()
            lnCodigo = lnCodigo + 1
            SEEK(lnCodigo)
        ENDDO

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN lnCodigo
    ENDFUNC

    **/
    * Devuelve un registro por su código.
    *
    * @param int tnCodigo Código numérico único del registro a buscar.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @override
    */
    FUNCTION obtener_por_codigo
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

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **/
    * Devuelve un registro por su nombre.
    *
    * @param string tcNombre Nombre del registro a buscar.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @override
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre

        LOCAL loModelo, lnAncho

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        lnAncho = campo_obtener_ancho(THIS.cModelo, 'nombre')

        IF lnAncho == 0 THEN
            THIS.cUltimoError = STRTRAN(STRTRAN(MSG_ERROR_ANCHO_CAMPO, ;
                '{0}', 'nombre'), '{1}', THIS.cModelo)
            RETURN .F.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(lnAncho), lnAncho)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && nombre
        IF SEEK(tcNombre) THEN
            loModelo = THIS.obtener_modelo()
        ENDIF

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH

        RETURN loModelo
    ENDFUNC

    **/
    * Devuelve todos los registros aplicando, opcionalmente, filtro y orden.
    *
    * El resultado se coloca en un cursor temporal llamado 'tm_' +
    * THIS.cModelo.
    *
    * @param string [tcCondicionFiltro] Cláusula WHERE de la consulta.
    * @param string [tcOrden] Cláusula ORDER BY de la consulta.
    * @return bool .T. si la consulta se ejecuta correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @override
    */
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF !es_cadena(tcCondicionFiltro, 5, 150) THEN
            tcCondicionFiltro = ''
        ENDIF

        IF !es_cadena(tcOrden) OR !INLIST(tcOrden, 'codigo', 'nombre') THEN
            tcOrden = THIS.cSqlOrder
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lcSql
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo

        IF !EMPTY(tcCondicionFiltro) THEN
            lcSql = lcSql + ' WHERE ' + tcCondicionFiltro
        ENDIF

        lcSql = lcSql + ' ORDER BY ' + tcOrden + ' ' + ;
            'INTO CURSOR tm_' + THIS.cModelo
        &lcSql

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **/
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si el registro se agrega correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses string obtener_lista_campos(object toModelo)
    *       Para obtener una cadena de caracteres que contiene la lista de
    *       campos del modelo, donde cada campo está precedido por el prefijo
    *       'm.'.
    * @uses string obtener_comando_insertar(object toModelo)
    *       Para obtener una cadena de caracteres con la instrucción INSERT -
    *       SQL para agregar un nuevo registro a la tabla.
    * @uses bool cargar_valores_a_variables(object toModelo)
    *       Para recuperar los datos de un modelo y los almacena en variables
    *       de memoria.
    * @uses bool validar_agregar()
    *       Para realizar las validaciones de datos para el método protegido
    *       'agregar'.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexión con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexión con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    FUNCTION agregar
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_objeto(toModelo, THIS.cModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL lcListaCampos, lcSql, lcDeclararVariablePrivada, ;
              lcInicializarVariablePrivada, lcLiberarVariablePrivada
        lcListaCampos = THIS.obtener_lista_campos(toModelo)
        lcSql = THIS.obtener_comando_insertar(toModelo)

        IF EMPTY(lcListaCampos) THEN
            THIS.cUltimoError = ;
                'No se pudo obtener la lista de campos del modelo.'
            RETURN .F.
        ENDIF

        IF EMPTY(lcSql) THEN
            THIS.cUltimoError = ;
                'No se pudo obtener la instrucción INSERT - SQL.'
            RETURN .F.
        ENDIF

        lcDeclararVariablePrivada = 'PRIVATE ' + lcListaCampos
        lcInicializarVariablePrivada = 'STORE .F. TO ' + lcListaCampos
        lcLiberarVariablePrivada = 'RELEASE ' + lcListaCampos

        &lcDeclararVariablePrivada
        &lcInicializarVariablePrivada

        IF !THIS.cargar_valores_a_variables(toModelo) THEN
            THIS.cUltimoError = ;
                'No se pudo cargar los valores a las variables privadas.'
            RETURN .F.
        ENDIF

        IF !THIS.validar_agregar() THEN
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        &lcSql
        &lcLiberarVariablePrivada

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos actualizados del registro.
    * @return bool .T. si el registro se modifica correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses string obtener_lista_campos(object toModelo)
    *       Para obtener una cadena de caracteres que contiene la lista de
    *       campos del modelo, donde cada campo está precedido por el prefijo
    *       'm.'.
    * @uses string obtener_comando_reemplazar(object toModelo)
    *       Para obtener una cadena de caracteres con la instrucción REPLACE
    *       para actualizar un registro existente en la tabla.
    * @uses bool cargar_valores_a_variables(object toModelo)
    *       Para recuperar los datos de un modelo y los almacena en variables
    *       de memoria.
    * @uses bool validar_modificar(object toModelo)
    *       Para realizar las validaciones de datos para el método protegido
    *       'modificar'.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexión con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexión con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    FUNCTION modificar
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_objeto(toModelo, THIS.cModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL lcListaCampos, lcComando, lcDeclararVariablePrivada, ;
              lcInicializarVariablePrivada, lcLiberarVariablePrivada
        lcListaCampos = THIS.obtener_lista_campos(toModelo)
        lcComando = THIS.obtener_comando_reemplazar(toModelo)

        IF EMPTY(lcListaCampos) THEN
            THIS.cUltimoError = ;
                'No se pudo obtener la lista de campos del modelo.'
            RETURN .F.
        ENDIF

        IF EMPTY(lcComando) THEN
            THIS.cUltimoError = 'No se pudo obtener la instrucción REPLACE.'
            RETURN .F.
        ENDIF

        lcDeclararVariablePrivada = 'PRIVATE ' + lcListaCampos
        lcInicializarVariablePrivada = 'STORE .F. TO ' + lcListaCampos
        lcLiberarVariablePrivada = 'RELEASE ' + lcListaCampos

        &lcDeclararVariablePrivada
        &lcInicializarVariablePrivada

        IF !THIS.cargar_valores_a_variables(toModelo) THEN
            THIS.cUltimoError = ;
                'No se pudo cargar los valores a las variables privadas.'
            RETURN .F.
        ENDIF

        IF !THIS.validar_modificar(toModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(m.codigo) THEN
            &lcComando
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                'No se pudo modificar el registro porque no existe.'
        ENDIF

        &lcLiberarVariablePrivada

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **/
    * Borra un registro de la tabla.
    *
    * @param int tnCodigo Código numérico único del registro a borrar.
    * @return bool .T. si el registro se borra correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @override
    */
    FUNCTION borrar
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_numero(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .F.
        ENDIF

        IF THIS.esta_relacionado(tnCodigo) THEN
            THIS.cUltimoError = ;
                'El registro figura en otros archivos; no se puede borrar.'
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(tnCodigo) THEN
            DELETE
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                'No se pudo borrar el registro porque no existe.'
        ENDIF

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * @method string obtener_comando_insertar(object toModelo)
    * @method string obtener_comando_reemplazar(object toModelo)
    * @method string obtener_lista_campos(object toModelo)
    * @method bool cargar_valores_a_variables(object toModelo)
    * @method bool validar_agregar()
    * @method bool validar_modificar()
    */

    **/
    * Configura las propiedades por defecto del DAO.
    *
    * Infiere el nombre del modelo y establece valores predeterminados para las
    * cláusulas SQL si no se han especificado.
    *
    * @return bool .T. si la configuración se completada correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @override
    */
    PROTECTED FUNCTION configurar
        IF !es_cadena(THIS.cModelo) THEN
            IF ATC('dao_dbf_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 9)
        ENDIF

        IF !es_cadena(THIS.cSqlOrder) THEN
            THIS.cSqlOrder = IIF(THIS.cModelo != 'modelos', ;
                'nombre', 'nombre_completo')
        ENDIF

        IF !es_cadena(THIS.cSqlSelect, 5, 254) THEN
            DO CASE
            CASE THIS.cModelo == 'barrios'
                THIS.cSqlSelect = 'codigo, nombre, departamen, ciudad, vigente'
            CASE THIS.cModelo == 'ciudades'
                THIS.cSqlSelect = 'codigo, nombre, departamen, sifen, vigente'
            CASE THIS.cModelo == 'familias'
                THIS.cSqlSelect = 'codigo, nombre, p1, p2, p3, p4, p5, vigente'
            CASE THIS.cModelo == 'modelos'
                THIS.cSqlSelect = ;
                    'a.codigo, a.nombre, a.maquina, a.marca, a.vigente, ' + ;
                    "IIF(!ISNULL(b.nombre), ALLTRIM(b.nombre) + ' ', '') + " + ;
                    "IIF(!ISNULL(c.nombre), ALLTRIM(c.nombre) + ' ', '') + " + ;
                    'ALLTRIM(a.nombre) AS nombre_completo'
            OTHERWISE
                THIS.cSqlSelect = 'codigo, nombre, vigente'
            ENDCASE
        ENDIF
    ENDFUNC

    **/
    * Crea un objeto modelo a partir del registro actual de la tabla.
    *
    * @return mixed object modelo si la operación se completa correctamente;
    *               .F. si ocurre un error.
    * @uses campo_obtener_lista(string tcModelo)
    *       Para obtener una cadena de caracteres que contiene la lista de
    *       campos del modelo.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @override
    */
    PROTECTED FUNCTION obtener_modelo
        LOCAL lcListaCampos, lcComando
        lcListaCampos = campo_obtener_lista(THIS.cModelo)
        lcComando = "NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', {})"

        IF EMPTY(lcListaCampos) THEN
            THIS.cUltimoError = ;
                'No se pudo obtener la lista de campos del modelo.'
            RETURN .F.
        ENDIF

        lcComando = STRTRAN(lcComando, '{}', lcListaCampos)

        RETURN &lcComando
    ENDFUNC

    **/
    * Establece conexión con la base de datos.
    *
    * @param bool [tlModoEscritura] .T. para abrir en modo lectura/escritura;
    *                               .F. para abrir en modo solo lectura.
    *                               Si no se especifica, por defecto .F.
    * @return bool .T. si la conexión se establece correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses bool abrir_dbf(string tcTabla, bool [tlModoEscritura])
    *       Para abrir un archivo DBF ubicado en la carpeta definida por
    *       la constante CARPETA_DATOS.
    * @override
    */
    PROTECTED FUNCTION conectar
        LPARAMETERS tlModoEscritura

        IF !es_logico(tlModoEscritura) THEN
            tlModoEscritura = .F.
        ENDIF

        IF !abrir_dbf(THIS.cModelo, tlModoEscritura) THEN
            THIS.desconectar()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Cierra la conexión con la base de datos.
    *
    * @return bool .T. si la conexión se cierra correctamente;
    *              .F. si ocurre un error.
    * @uses bool cerrar_dbf(string tcTabla)
    *       Para cerrar una tabla DBF previamente abierta en el entorno de
    *       trabajo.
    * @override
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
    ENDFUNC

    **/
    * Devuelve una cadena de caracteres con la instrucción INSERT - SQL para
    * agregar un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return string Si se ejecuta correctamente, devuelve la cadena INSERT -
    *                SQL. En caso contrario, devuelve una cadena vacía.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    */
    PROTECTED FUNCTION obtener_comando_insertar
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 ;
                OR !es_objeto(toModelo) ;
                OR !es_cadena(THIS.cModelo) THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL loCampos, lcSql, lcCampos, lcValores, loCampo, lcNombre
        loCampos = toModelo.campo_obtener_todos()

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN SPACE(0)
        ENDIF

        lcSql = 'INSERT INTO ' + THIS.cModelo + ' ({0}) VALUES ({1})'
        STORE '' TO lcCampos, lcValores

        FOR EACH loCampo IN loCampos
            lcNombre = loCampo.obtener_nombre()

            IF !EMPTY(lcCampos) THEN
                lcCampos = lcCampos + ', '
                lcValores = lcValores + ', '
            ENDIF

            lcCampos = lcCampos + lcNombre
            lcValores = lcValores + 'm.' + lcNombre
        ENDFOR

        RETURN STRTRAN(STRTRAN(lcSql, '{0}', lcCampos), '{1}', lcValores)
    ENDFUNC

    **/
    * Devuelve una cadena de caracteres con la instrucción REPLACE para
    * actualizar un registro existente en la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return string Si se ejecuta correctamente, devuelve la cadena REPLACE.
    *                En caso contrario, devuelve una cadena vacía.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    */
    PROTECTED FUNCTION obtener_comando_reemplazar
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 OR !es_objeto(toModelo) THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL loCampos, lcComando, loCampo, lcNombre
        loCampos = toModelo.campo_obtener_todos()
        lcComando = ''

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN SPACE(0)
        ENDIF

        FOR EACH loCampo IN loCampos
            lcNombre = loCampo.obtener_nombre()

            IF lcNombre == 'codigo' THEN
                LOOP
            ENDIF

            IF !EMPTY(lcComando) THEN
                lcComando = lcComando + ', '
            ENDIF

            lcComando = lcComando + lcNombre + ' WITH m.' + lcNombre
        ENDFOR

        RETURN 'REPLACE ' + lcComando
    ENDFUNC

    **/
    * Devuelve una cadena de caracteres que contiene la lista de campos del
    * modelo, donde cada campo está precedido por el prefijo 'm.'.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return string Si se ejecuta correctamente, devuelve la lista de campos.
    *                En caso contrario, devuelve una cadena vacía.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    */
    PROTECTED FUNCTION obtener_lista_campos
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 OR !es_objeto(toModelo)  THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL loCampos, lcLista, loCampo
        loCampos = toModelo.campo_obtener_todos()
        lcLista = ''

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN SPACE(0)
        ENDIF

        FOR EACH loCampo IN loCampos
            IF !EMPTY(lcLista) THEN
                lcLista = lcLista + ', '
            ENDIF

            lcLista = lcLista + 'm.' + loCampo.obtener_nombre()
        ENDFOR

        RETURN lcLista
    ENDFUNC

    **/
    * Recupera los datos de un modelo y los almacena en variables de memoria.
    * Las variables de memoria ya deben estar declaradas e inicializadas con
    * .F. en la función llamadora para no tener problemas en la alcance de
    * las variables.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    */
    PROTECTED FUNCTION cargar_valores_a_variables
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 OR !es_objeto(toModelo)  THEN
            RETURN .F.
        ENDIF

        LOCAL loCampos, loCampo, lcComando
        loCampos = toModelo.campo_obtener_todos()

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN .F.
        ENDIF

        FOR EACH loCampo IN loCampos
            lcComando = 'm.' + loCampo.obtener_nombre() + ;
                ' = loCampo.obtener_valor()'
            &lcComando
        ENDFOR
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el método protegido 'agregar'.
    *
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_codigo(int tnCodigo)
    *       Para verificar si un código ya existe en la tabla.
    * @uses bool existe_nombre(string tcNombre)
    *       Para verificar si un nombre ya existe en la tabla.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    */
    PROTECTED FUNCTION validar_agregar
        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre) THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el método protegido 'modificar'.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool existe_codigo(int tnCodigo)
    *       Para verificar si un código ya existe en la tabla.
    * @uses mixed obtener_por_nombre(string tcNombre)
    *       Para obtener un registro por su nombre.
    * @uses mixed obtener_por_codigo(int tnCodigo)
    *       Para obtener un registro por su código.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    */
    PROTECTED FUNCTION validar_modificar
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 OR !es_objeto(toModelo)  THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL loModelo

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre)

        IF es_objeto(loModelo) AND loModelo.obtener('codigo') != m.codigo THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_codigo(m.codigo)

        IF !es_objeto(loModelo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
