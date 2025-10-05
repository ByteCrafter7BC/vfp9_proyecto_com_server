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
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method string obtener_ultimo_error()
    * @method bool borrar(int tnCodigo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    */

    **/
    * Verifica la existencia de un modelo por su nombre, máquina y marca.
    *
    * @param string tcNombre Nombre del modelo a verificar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
    * @return bool .T. si el nombre existe o si ocurre un error;
    *              .F. si el nombre no existe.
    * @override
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .T.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMarca')
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .T.
        ENDIF

        LOCAL llExiste

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

    **
    * Verifica si el código de un modelo está relacionado con otros registros
    * de la base de datos.
    *
    * @param int tnCodigo Código del modelo a verificar.
    * @return bool .T. si el registro está relacionado o si ocurre un error;
    *              .F. si no está relacionado.
    * @override
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL lcCondicionFiltro, llRelacionado
        lcCondicionFiltro = 'modelo == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN    && Órdenes de trabajo (OT).
            llRelacionado = dao_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Realiza la búsqueda de un modelo por su nombre, máquina y marca.
    *
    * @param string tcNombre Nombre del modelo a buscar.
    * @param int tnMaquina Código de la máquina.
    * @param int tnMarca Código de la marca.
    * @return mixed object modelo si el modelo se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre, tnMaquina, tnMarca

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnMaquina_Valid(tnMaquina) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMaquina')
            RETURN .F.
        ENDIF

        IF !THIS.tnMarca_Valid(tnMarca) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnMarca')
            RETURN .F.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

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
    * @override
    */
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden

        IF !THIS.tcCondicionFiltro_Valid(tcCondicionFiltro) THEN
            tcCondicionFiltro = ''
        ENDIF

        IF !THIS.tcOrden_Valid(tcOrden) THEN
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
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si el registro se agrega correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.maquina, m.marca) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
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

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) ;
            (codigo, nombre, maquina, marca, vigente) ;
        VALUES ;
            (m.codigo, m.nombre, m.maquina, m.marca, m.vigente)

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
    * @override
    */
    FUNCTION modificar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.maquina, m.marca, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.maquina = .obtener_maquina()
            m.marca = .obtener_marca()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.maquina, m.marca)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
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

        IF VARTYPE(loModelo) != 'O' THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(m.codigo) THEN
            REPLACE nombre WITH ALLTRIM(m.nombre), ;
                    maquina WITH m.maquina, ;
                    marca WITH m.marca, ;
                    vigente WITH m.vigente
            THIS.cUltimoError = ''
        ELSE
            THIS.cUltimoError = ;
                "No se pudo modificar el registro porque no existe."
        ENDIF

        THIS.desconectar()

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method bool Init()
    * @method string obtener_nombre_referencial(string tcModelo, int tnCodigo)
    * @method bool validar_codigo_referencial(string tcModelo, int tnCodigo)
    * @method bool tnCodigo_Valid(int tnCodigo)
    * @method bool tcNombre_Valid(string tcNombre)
    * @method bool tlVigente_Valid(bool tlVigente)
    * @method bool tcCondicionFiltro_Valid(string tcCondicionFiltro)
    * @method bool tcOrden_Valid(string tcOrden)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method mixed obtener_modelo()
    * @method bool conectar([bool tlModoEscritura])
    * @method bool desconectar()
    * @method bool toModelo_Valid(object toModelo)
    * @method bool tnMaquina_Valid(int tnMaquina)
    * @method bool tnMarca_Valid(int tnMarca)
    */

    **/
    * Crea un objeto modelo a partir del registro actual de la tabla.
    *
    * @return mixed object modelo si la operación se completa correctamente;
    *               .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), maquina, marca, vigente)
    ENDFUNC

    **/
    * Establece conexión con la base de datos.
    *
    * @param bool [tlModoEscritura] .T. para abrir en modo lectura/escritura;
    *                               .F. para abrir en modo solo lectura.
    *                               Si no se especifica, predeterminado .F.
    * @return bool .T. si la conexión se establece correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION conectar
        LPARAMETERS tlModoEscritura

        IF VARTYPE(tlModoEscritura) != 'L' THEN
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
    * @override
    */
    PROTECTED FUNCTION desconectar
        cerrar_dbf(THIS.cModelo)
        cerrar_dbf('maquinas')
        cerrar_dbf('marcas2')
    ENDFUNC

    **/
    * Valida todas las propiedades del objeto modelo. Sobrescribe la validación
    * base e incluye la validación de los campos 'maquina' y 'marca'.
    *
    * @param object toModelo Modelo a validar.
    * @return bool .T. si el objeto es válido; .F. si no lo es.
    * @override
    */
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !dao_base::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnMaquina_Valid(toModelo.obtener_maquina()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnMarca_Valid(toModelo.obtener_marca()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida el argumento 'tnMaquina'. Verifica el tipo de dato y el rango del
    * código referencial.
    *
    * @param int tnMaquina Código de la máquina a validar.
    * @return bool .T. si el código es válido; .F. si no lo es.
    */
    PROTECTED FUNCTION tnMaquina_Valid
        LPARAMETERS tnMaquina
        RETURN THIS.validar_codigo_referencial('maquinas', tnMaquina)
    ENDFUNC

    **/
    * Valida el argumento 'tnMarca'. Verifica el tipo de dato y el rango del
    * código referencial.
    *
    * @param int tnMarca Código de la marca a validar.
    * @return bool .T. si el código es válido; .F. si no lo es.
    */
    PROTECTED FUNCTION tnMarca_Valid
        LPARAMETERS tnMarca
        RETURN THIS.validar_codigo_referencial('marcas2', tnMarca)
    ENDFUNC
ENDDEFINE
