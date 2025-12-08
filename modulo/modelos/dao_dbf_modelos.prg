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
* @file dao_dbf_modelos.prg
* @package modulo\modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_modelos
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO).
*
* Esta clase hereda la funcionalidad básica de la clase 'dao_dbf' y la
* especializa para la tabla 'modelos'. Su propósito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones específicas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_modelos AS dao_dbf OF dao_dbf.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnMaquina, int tnMarca)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre, int tnMaquina, ;
                                       int tnMarca)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    */

    **/
    * Verifica si un nombre ya existe en la tabla; dentro de una máquina y
    * marca específicos.
    *
    * Realiza una búsqueda no sensible a mayúsculas/minúsculas utilizando el
    * índice secundario ('indice2').
    *
    * @param string tcNombre Nombre a verificar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
    * @return bool .T. si el nombre existe o si ocurre un error;
    *              .F. si no existe.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexión con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexión con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        LOCAL llExiste, lnAncho

        IF PARAMETERS() != 3 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !es_numero(tnMaquina, 0, 9999) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .T.
        ENDIF

        IF !es_numero(tnMarca, 0, 9999) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMarca')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(maquina, 4) + STR(marca, 4)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF maquina == tnMaquina AND marca == tnMarca THEN
                    llExiste = .T.
                    EXIT
                ENDIF
            ENDSCAN
        ENDIF

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
        lcCondicionFiltro = 'modelo == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN    && Órdenes de trabajo.
            llRelacionado = dao_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Devuelve un registro por su nombre; dentro de una maquina y marca
    * específicos.
    *
    * @param string tcNombre Nombre del registro a buscar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
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
    * @override
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        LOCAL loModelo, lnAncho

        IF PARAMETERS() != 3 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !es_numero(tnMaquina, 0, 9999) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .F.
        ENDIF

        IF !es_numero(tnMarca, 0, 9999) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMarca')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(maquina, 4) + STR(marca, 4)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF maquina == tnMaquina AND marca == tnMarca THEN
                    loModelo = THIS.obtener_modelo()
                    EXIT
                ENDIF
            ENDSCAN
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

        IF !es_cadena(tcOrden) OR !INLIST(tcOrden, 'a.codigo', 'a.nombre') THEN
            tcOrden = THIS.cSqlOrder
        ENDIF

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL lcSql
        lcSql = 'SELECT ' + THIS.cSqlSelect + ' ' + ;
            'FROM ' + THIS.cModelo + ' a ' + ;
            'LEFT JOIN maquinas b ON a.maquina == b.codigo ' + ;
            'LEFT JOIN marcas2 c ON a.marca == c.codigo'

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
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method string obtener_comando_insertar(object toModelo)
    * @method string obtener_comando_reemplazar(object toModelo)
    * @method string obtener_lista_campos(object toModelo)
    * @method bool cargar_valores_a_variables(object toModelo)
    * @method bool validar_modelo(object toModelo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * @method bool validar_agregar()
    * @method bool validar_modificar()
    */

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

        IF !tlModoEscritura THEN
            IF !abrir_dbf('maquinas') THEN
                THIS.desconectar()
                RETURN .F.
            ENDIF

            IF !abrir_dbf('marcas2') THEN
                THIS.desconectar()
                RETURN .F.
            ENDIF
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
        cerrar_dbf('maquinas')
        cerrar_dbf('marcas2')
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el método protegido 'agregar'.
    *
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_codigo(int tnCodigo)
    *       Para verifica si un código ya existe en la tabla.
    * @uses bool existe_nombre(string tcNombre, int tnMaquina, int tnMarca)
    *       Para verificar si un nombre ya existe en la tabla; dentro de un
    *       máquina y marca específicos.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos buscándolo
    *       por su código.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su código único.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
    */
    PROTECTED FUNCTION validar_agregar
        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.maquina, m.marca) THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF

        IF m.maquina > 0 AND !dao_existe_codigo('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !dao_existe_codigo('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
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
    *       Para verifica si un código ya existe en la tabla.
    * @uses mixed obtener_por_nombre(string tcNombre, int tnMaquina, ;
                                     int tnMarca)
    *       Para obtener un registro por su nombre; dentro de una máquina y
    *       marca específicos.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos buscándolo
    *       por su código.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su código único.
    * @uses mixed obtener_por_codigo(int tnCodigo)
    *       Para obtener un registro por su código.
    * @uses string cUltimoError Almacena el último mensaje de error ocurrido.
    * @override
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

        loModelo = THIS.obtener_por_nombre(m.nombre, m.maquina, m.marca)

        IF es_objeto(loModelo) AND loModelo.obtener('codigo') != m.codigo THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF

        IF m.maquina > 0 AND !dao_existe_codigo('maquinas', m.maquina) THEN
            THIS.cUltimoError = "El código de máquina '" + ;
                ALLTRIM(STR(m.maquina)) + "' no existe."
            RETURN .F.
        ENDIF

        IF m.marca > 0 AND !dao_existe_codigo('marcas2', m.marca) THEN
            THIS.cUltimoError = "El código de marca '" + ;
                ALLTRIM(STR(m.marca)) + "' no existe."
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
