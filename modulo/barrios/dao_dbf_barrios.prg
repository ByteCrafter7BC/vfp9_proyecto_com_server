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
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool borrar(int tnCodigo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnDepartamen, ;
                                 int tnCiudad)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre, int tnDepartamen, ;
                                       int tnCiudad)
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    */

    **/
    * Verifica si un nombre ya existe en la tabla; dentro de un departamento
    * y ciudad específicos.
    *
    * Realiza una búsqueda no sensible a mayúsculas/minúsculas utilizando el
    * índice secundario ('indice2').
    *
    * @param string tcNombre Nombre a verificar.
    * @param int tnDepartamen Código del departamento.
    * @param int tnCiudad Código de la ciudad.
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
    * @override
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        LOCAL llExiste, lnAncho

        IF PARAMETERS() != 3 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .T.
        ENDIF

        IF !es_numero(tnDepartamen, 1, 999) THEN
            THIS.cUltimoError = ;
                STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .T.
        ENDIF

        IF !es_numero(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCiudad')
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
    * Devuelve un registro por su nombre; dentro de un departamento y ciudad
    * específicos.
    *
    * @param string tcNombre Nombre del registro a buscar.
    * @param int tnDepartamen Código del departamento.
    * @param int tnCiudad Código de la ciudad.
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
        LPARAMETERS tcNombre, tnDepartamen, tnCiudad

        LOCAL loModelo, lnAncho

        IF PARAMETERS() != 3 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .F.
        ENDIF

        IF !es_cadena(tcNombre) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcNombre')
            RETURN .F.
        ENDIF

        IF !es_numero(tnDepartamen, 1, 999) THEN
            THIS.cUltimoError = ;
                STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnDepartamen')
            RETURN .F.
        ENDIF

        IF !es_numero(tnCiudad) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCiudad')
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
    * @return bool .T. si el registro se agrega correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos buscándolo
    *       por su código.
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

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente

        WITH toModelo
            m.codigo = .obtener('codigo')
            m.nombre = .obtener('nombre')
            m.departamen = .obtener('departamen')
            m.ciudad = .obtener('ciudad')
            m.vigente = .obtener('vigente')
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.departamen, m.ciudad) THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
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
    * @return bool .T. si el registro se modifica correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos buscándolo
    *       por su código.
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

        LOCAL m.codigo, m.nombre, m.departamen, m.ciudad, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener('codigo')
            m.nombre = .obtener('nombre')
            m.departamen = .obtener('departamen')
            m.ciudad = .obtener('ciudad')
            m.vigente = .obtener('vigente')
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.departamen, m.ciudad)

        IF es_objeto(loModelo) AND loModelo.obtener('codigo') != m.codigo THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
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

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSG_ERROR_CONEXION
            RETURN .F.
        ENDIF

        SELECT (THIS.cModelo)
        SET ORDER TO TAG 'indice1'    && codigo
        IF SEEK(m.codigo) THEN
            REPLACE nombre WITH m.nombre, ;
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
    * @method bool Init()
    * @method bool configurar()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method mixed obtener_modelo()
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
            codigo, nombre, departamen, ciudad, vigente)
    ENDFUNC
ENDDEFINE
