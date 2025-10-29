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
* Esta clase hereda la funcionalidad b�sica de la clase 'dao_dbf' y la
* especializa para la tabla 'barrios'. Su prop�sito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones espec�ficas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_barrios AS dao_dbf OF dao_dbf.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnDepartamen, ;
                                 int tnCiudad)
    * @method bool esta_relacionado(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre, int tnDepartamen, ;
                                       int tnCiudad)
    */

    **/
    * Verifica si un nombre ya existe en la tabla; dentro de un departamento
    * y ciudad espec�ficos.
    *
    * Realiza una b�squeda no sensible a may�sculas/min�sculas utilizando el
    * �ndice secundario ('indice2').
    *
    * @param string tcNombre Nombre a verificar.
    * @param int tnDepartamen C�digo del departamento.
    * @param int tnCiudad C�digo de la ciudad.
    * @return bool .T. si el nombre existe o si ocurre un error;
    *              .F. si no existe.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       est� dentro de un rango espec�fico.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es num�rico y se encuentra dentro de un
    *       rango espec�fico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexi�n con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexi�n con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
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
    * Verifica si un c�digo est� relacionado con otros registros de la base
    * de datos.
    *
    * @param int tnCodigo C�digo num�rico �nico a verificar.
    * @return bool .T. si el registro est� relacionado o si ocurre un error;
    *              .F. si no est� relacionado.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es num�rico y se encuentra dentro de un
    *       rango espec�fico.
    * @uses bool dao_existe_referencia(string tcModelo, ;
                                       string tcCondicionFiltro)
    *       Para verificar la existencia de registros referenciales en una
    *       tabla.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
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

        IF !llRelacionado THEN    && Clientes.
            llRelacionado = dao_existe_referencia('clientes', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && �rdenes de trabajo.
            llRelacionado = dao_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Devuelve un registro por su nombre; dentro de un departamento y ciudad
    * espec�ficos.
    *
    * @param string tcNombre Nombre del registro a buscar.
    * @param int tnDepartamen C�digo del departamento.
    * @param int tnCiudad C�digo de la ciudad.
    * @return mixed object modelo si el registro se encuentra;
    *               .F. si no se encuentra o si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       est� dentro de un rango espec�fico.
    * @uses int campo_obtener_ancho(string tcModelo, string tcCampo)
    *       Para obtener el ancho del campo de un modelo.
    * @uses bool conectar(bool [tlModoEscritura])
    *       Para establecer conexi�n con la base de datos.
    * @uses bool desconectar()
    *       Para cerrar la conexi�n con la base de datos.
    * @uses string cModelo Nombre de la clase que representa el modelo de datos.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
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
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * @method string obtener_comando_insertar(object toModelo)
    * @method string obtener_comando_reemplazar(object toModelo)
    * @method string obtener_lista_campos(object toModelo)
    * @method bool cargar_valores_a_variables(object toModelo)
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool validar_agregar()
    * @method bool validar_modificar()
    */

    **/
    * Realiza las validaciones de datos para el m�todo protegido 'agregar'.
    *
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_codigo(int tnCodigo)
    *       Para verifica si un c�digo ya existe en la tabla.
    * @uses bool existe_nombre(string tcNombre, int tnDepartamen, int tnCiudad)
    *       Para verificar si un nombre ya existe en la tabla; dentro de un
    *       departamento y ciudad espec�ficos.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos busc�ndolo
    *       por su c�digo.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su c�digo �nico.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
    * @override
    */
    PROTECTED FUNCTION validar_agregar
        LOCAL loModelo

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El c�digo '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre, m.departamen, m.ciudad) THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF

        IF !dao_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El c�digo de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        loModelo = dao_obtener_por_codigo('ciudades', m.ciudad)

        IF !es_objeto(loModelo) THEN
            THIS.cUltimoError = "El c�digo de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.obtener('departamen') != m.departamen THEN
            THIS.cUltimoError = "El c�digo de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no coincide con el c�digo '" + ;
                ALLTRIM(STR(loModelo.obtener('departamen'))) + "' de la ciudad."
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Realiza las validaciones de datos para el m�todo protegido 'modificar'.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    * @return bool .T. si se ejecuta correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses bool existe_codigo(int tnCodigo)
    *       Para verifica si un c�digo ya existe en la tabla.
    * @uses mixed obtener_por_nombre(string tcNombre, int tnDepartamen, ;
                                     int tnCiudad)
    *       Para obtener un registro por su nombre; dentro de un departamento y
    *       ciudad espec�ficos.
    * @uses bool dao_existe_codigo(string tcModelo, int tnCodigo)
    *       Para verificar si un registro existe en la base de datos busc�ndolo
    *       por su c�digo.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su c�digo �nico.
    * @uses mixed obtener_por_codigo(int tnCodigo)
    *       Para obtener un registro por su c�digo.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
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
            THIS.cUltimoError = "El c�digo '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre, m.departamen, m.ciudad)

        IF es_objeto(loModelo) AND loModelo.obtener('codigo') != m.codigo THEN
            THIS.cUltimoError = "El nombre '" + m.nombre + "' ya existe."
            RETURN .F.
        ENDIF

        IF !dao_existe_codigo('depar', m.departamen) THEN
            THIS.cUltimoError = "El c�digo de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no existe."
            RETURN .F.
        ENDIF

        loModelo = dao_obtener_por_codigo('ciudades', m.ciudad)

        IF !es_objeto(loModelo) THEN
            THIS.cUltimoError = "El c�digo de ciudad '" + ;
                ALLTRIM(STR(m.ciudad)) + "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.obtener('departamen') != m.departamen THEN
            THIS.cUltimoError = "El c�digo de departamento '" + ;
                ALLTRIM(STR(m.departamen)) + "' no coincide con el c�digo '" + ;
                ALLTRIM(STR(loModelo.obtener('departamen'))) + "' de la ciudad."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_codigo(m.codigo)

        IF !es_objeto(loModelo) THEN
            THIS.cUltimoError = "El c�digo '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        IF loModelo.es_igual(toModelo) THEN
            THIS.cUltimoError = "El c�digo '" + ALLTRIM(STR(m.codigo)) + ;
                "' no tiene cambios que guardar."
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
