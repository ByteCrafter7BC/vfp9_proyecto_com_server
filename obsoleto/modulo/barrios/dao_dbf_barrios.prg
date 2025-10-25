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
* @file dao_dbf_barrios.prg
* @package modulo\barrios
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_barrios
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO).
*
* Esta clase hereda la funcionalidad básica de la clase 'dao_dbf' y la
* especializa para la tabla 'barrios'. Su propósito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones específicas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_barrios AS dao_dbf OF dao_dbf.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool borrar(int tnCodigo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnDepartamen, ;
                                 int tnCiudad)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre, int tnDepartamen, ;
                                       int tnCiudad)
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    */

    **/
    * Verifica la existencia de un barrio por su nombre dentro de un
    * departamento y ciudad específicos.
    *
    * @param string tcNombre Nombre del barrio a verificar.
    * @param int tnDepartamen Código del departamento.
    * @param int tnCiudad Código de la ciudad.
    * @return bool .T. si el nombre existe o si ocurre un error, o
    *              .F. si el nombre no existe.
    * @override
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .T.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCiudad')
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
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(departamen, 3) + STR(ciudad, 5)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF departamen == tnDepartamen AND ciudad == tnCiudad THEN
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
    * Verifica si el código de un barrio está relacionado con otros registros
    * de la base de datos.
    *
    * @param int tnCodigo Código del barrio a verificar.
    * @return bool .T. si el registro está relacionado o si ocurre un error, o
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
        lcCondicionFiltro = 'barrio == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN   && Clientes.
            llRelacionado = dao_existe_referencia('clientes', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && Órdenes de trabajo.
            llRelacionado = dao_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Realiza la búsqueda de un barrio por su nombre dentro de un
    * departamento y ciudad específicos.
    *
    * @param string tcNombre Nombre del barrio a buscar.
    * @param int tnDepartamen Código del departamento.
    * @param int tnCiudad Código de la ciudad.
    * @return mixed object modelo si el barrio se encuentra, o
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        IF !THIS.tcNombre_Valid(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !THIS.tnDepartamen_Valid(tnDepartamen) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .F.
        ENDIF

        IF !THIS.tnCiudad_Valid(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCiudad')
            RETURN .T.
        ENDIF

        tcNombre = LEFT(UPPER(ALLTRIM(tcNombre)) + SPACE(THIS.nAnchoNombre), ;
            THIS.nAnchoNombre)

        IF !THIS.conectar() THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        LOCAL loModelo

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice2'    && UPPER(nombre) + STR(departamen, 3) + STR(ciudad, 5)
        IF SEEK(tcNombre) THEN
            SCAN WHILE UPPER(nombre) == tcNombre
                IF departamen == tnDepartamen AND ciudad == tnCiudad THEN
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
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si el registro se agrega correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION agregar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.departamen, m.ciudad) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !dao_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !dao_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) ;
            (codigo, nombre, departamen, ciudad, vigente) ;
        VALUES ;
            (m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente)

        WITH THIS
            .cUltimoError = ''
            .desconectar()
        ENDWITH
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos actualizados del registro.
    * @return bool .T. si el registro se modifica correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION modificar
        LPARAMETERS toModelo

        IF !THIS.toModelo_Valid(toModelo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'toModelo')
            RETURN .F.
        ENDIF

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.departamen = .obtener_departamen()
            m.ciudad = .obtener_ciudad()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.departamen, m.ciudad)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
        ENDIF

        IF !dao_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El código de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        IF !dao_existe_codigo('ciudades', m.ciudad) THEN
            THIS.cUltimoError = "El código de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
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
                    departamen WITH m.departamen, ;
                    ciudad WITH m.ciudad, ;
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
    * @method bool conectar([bool tlModoEscritura])
    * @method bool desconectar()
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
    * @method bool toModelo_Valid(object toModelo)
    * @method bool tnDepartamen_Valid(int tnDepartamen)
    * @method bool tnCiudad_Valid(int tnCiudad)
    */

    **/
    * Crea un objeto modelo a partir del registro actual de la tabla.
    *
    * @return mixed object modelo si la operación se completa correctamente, o
    *               .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            codigo, ALLTRIM(nombre), departamen, ciudad, vigente)
    ENDFUNC

    **/
    * Valida todas las propiedades del objeto modelo. Sobrescribe la validación
    * base e incluye la validación de los campos 'maquina' y 'marca'.
    *
    * @param object toModelo Modelo a validar.
    * @return bool .T. si el objeto es válido, o .F. si no lo es.
    * @override
    */
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !dao_base::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnDepartamen_Valid(toModelo.obtener_departamen()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnCiudad_Valid(toModelo.obtener_ciudad()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida el argumento 'tnDepartamen'. Verifica el tipo de dato y el rango del
    * código referencial.
    *
    * @param int tnDepartamen Código del departamento a validar.
    * @return bool .T. si el código es válido, o .F. si no lo es.
    */
    PROTECTED FUNCTION tnDepartamen_Valid
        LPARAMETERS tnDepartamen
        RETURN THIS.validar_codigo_referencial('depar', tnDepartamen)
    ENDFUNC

    **/
    * Valida el argumento 'tnCiudad'. Verifica el tipo de dato y el rango del
    * código referencial.
    *
    * @param int tnCiudad Código de la ciudad a validar.
    * @return bool .T. si el código es válido, o .F. si no lo es.
    */
    PROTECTED FUNCTION tnCiudad_Valid
        LPARAMETERS tnCiudad
        RETURN THIS.validar_codigo_referencial('ciudades', tnCiudad)
    ENDFUNC
ENDDEFINE
