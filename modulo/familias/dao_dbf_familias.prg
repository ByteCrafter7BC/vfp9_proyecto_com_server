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
* @file dao_dbf_familias.prg
* @package modulo\familias
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_familias
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO).
*
* Esta clase hereda la funcionalidad básica de la clase 'dao_dbf' y la
* especializa para la tabla 'familias'. Su propósito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones específicas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_familias AS dao_dbf OF dao_dbf.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool borrar(int tnCodigo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool esta_relacionado(int tnCodigo)
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    */

    **
    * Verifica si el código de una familia está relacionado con otros registros
    * de la base de datos.
    *
    * @param int tnCodigo Código de familia a verificar.
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

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'familia == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN
            llRelacionado = dao_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
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

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = .esta_vigente()
        ENDWITH

        IF THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF THIS.existe_nombre(m.nombre) THEN
            THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                "' ya existe."
            RETURN .F.
        ENDIF

        IF !THIS.conectar(.T.) THEN
            THIS.cUltimoError = MSE_ERROR_CONEXION
            RETURN .F.
        ENDIF

        INSERT INTO (THIS.cModelo) FROM MEMVAR

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

        LOCAL m.codigo, m.nombre, m.p1, m.p2, m.p3, m.p4, m.p5, m.vigente, ;
              loModelo

        WITH toModelo
            m.codigo = .obtener_codigo()
            m.nombre = .obtener_nombre()
            m.p1 = .obtener_p1()
            m.p2 = .obtener_p2()
            m.p3 = .obtener_p3()
            m.p4 = .obtener_p4()
            m.p5 = .obtener_p5()
            m.vigente = .esta_vigente()
        ENDWITH

        IF !THIS.existe_codigo(m.codigo) THEN
            THIS.cUltimoError = "El código '" + ALLTRIM(STR(m.codigo)) + ;
                "' no existe."
            RETURN .F.
        ENDIF

        loModelo = THIS.obtener_por_nombre(m.nombre)

        IF VARTYPE(loModelo) == 'O' THEN
            IF loModelo.obtener_codigo() != m.codigo THEN
                THIS.cUltimoError = "El nombre '" + ALLTRIM(m.nombre) + ;
                    "' ya existe."
                RETURN .F.
            ENDIF
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
                    p1 WITH m.p1, ;
                    p2 WITH m.p2, ;
                    p3 WITH m.p3, ;
                    p4 WITH m.p4, ;
                    p5 WITH m.p5, ;
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
    * @method bool tnP_Valid(float tnP)
    * @method bool toModelo_Valid(object toModelo)
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
            codigo, ALLTRIM(nombre), p1, p2, p3, p4, p5, vigente)
    ENDFUNC

    **/
    * Valida el tipo de dato y el rango de un porcentaje (P1 a P5).
    *
    * @param float tnP Porcentaje a validar.
    * @return bool .T. si es un porcentaje válido (numérico entre 0 y 999.99), o
    *              .F. si no lo es.
    */
    PROTECTED FUNCTION tnP_Valid
        LPARAMETERS tnP

        IF VARTYPE(tnP) != 'N' OR !BETWEEN(tnP, 0, 999.99) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida todas las propiedades del objeto modelo. Sobrescribe la validación
    * base e incluye la validación de los campos P1 a P5.
    *
    * @param object toModelo Modelo a validar.
    * @return bool .T. si el objeto es válido, o .F. si no lo es.
    * @override
    */
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF !dao_dbf::toModelo_Valid(toModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnLista, lcCondicion

        FOR lnLista = 1 TO 5
            lcCondicion = '!THIS.tnP_Valid(toModelo.obtener_p' + ;
                STR(lnLista, 1) + '())'
            IF EVALUATE(lcCondicion) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC
ENDDEFINE
