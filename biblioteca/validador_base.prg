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
* @file validador_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class validador_base
* @extends Custom
* @uses constantes.h
*/

**/
* Clase base abstracta para la validaci�n de modelos.
*
* Esta clase implementa la l�gica de validaci�n gen�rica para operaciones de
* Agregar (1), Modificar (2) y Borrar (3) sobre un modelo de datos. Las
* validaciones se realizan sobre todas las propiedades.
*
* Est� dise�ada para ser implementada por clases validadoras espec�ficas para
* cada modelo, proporcionando un marco de trabajo reutilizable y consistente.

* Se pueden implementar validaciones de propiedades espec�ficas siguiendo las
* siguientes reglas:
* a) Nombre del m�todo: 'validar_' + nombre_propiedad,
* b) El m�todo debe retornar un valor l�gico (.T. o .F.).
* Ejemplos: bool validar_codigo(), bool validar_nombre().
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_base AS Custom
    **/
    * @var int Bandera que indica el tipo de operaci�n a validar.
    * 1 = Agregar, 2 = Modificar y 3 = Borrar.
    */
    PROTECTED nBandera

    **
    * @var object Modelo que contiene los datos a validar.
    */
    PROTECTED oModelo

    **/
    * @var object DAO para la interacci�n con la base de datos.
    */
    PROTECTED oDao

    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error(string tcCampo)
    */

    **/
    * Constructor de la clase validadora.
    *
    * Inicializa la clase con los par�metros necesarios y ejecuta la validaci�n
    * si la bandera indica una operaci�n de Agregar o Modificar.
    *
    * @param int tnBandera Bandera que indica la operaci�n:
    *                      1 para Agregar, 2 para Modificar y 3 para Borrar.
    * @param object toModelo Modelo con los datos a validar.
    * @param object toDao DAO para las consultas de validaci�n.
    * @return bool .T. si la inicializaci�n se completa correctamente;
    *              .F. en caso contrario.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es num�rico y se encuentra dentro de un
    *       rango espec�fico.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses bool validar()
    *       Para ejecutar las validaciones de todos los campos del modelo.
    */
    FUNCTION Init
        LPARAMETERS tnBandera, toModelo, toDao

        IF !es_numero(tnBandera, 1, 3) ;
                OR !es_objeto(toModelo) ;
                OR !es_objeto(toDao) THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nBandera = tnBandera
            .oModelo = toModelo
            .oDao = toDao
        ENDWITH

        IF es_numero(THIS.nBandera, 1, 2) THEN
            RETURN THIS.validar()
        ENDIF
    ENDFUNC

    **/
    * Verifica si el modelo es v�lido seg�n la operaci�n (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe alg�n
    *   mensaje de error en cada uno de los campos del modelo.
    * - Para otras banderas (borrar), verifica que el registro no est�
    *   relacionado con otros registros de la base de datos antes de permitir
    *   la operaci�n.
    *
    * @return bool .T. si el modelo es v�lido para la operaci�n;
    *              .F. en caso contrario.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es num�rico y se encuentra dentro de un
    *       rango espec�fico.
    * @uses bool campo_existe_error()
    *       Para verificar el �ltimo mensaje de error de todos los campos del
    *       modelo.
    * @uses object oDao DAO para la interacci�n con la base de datos.
    */
    FUNCTION es_valido
        IF es_numero(THIS.nBandera, 1, 2) THEN
            RETURN !THIS.campo_existe_error()
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener('codigo'))
        ENDIF
    ENDFUNC

    **/
    * Obtiene el mensaje de error de un campo espec�fico.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return string Mensaje de error. Cadena vac�a si no hay error.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el �ltimo mensaje de error del campo.
    */
    FUNCTION obtener_error
        LPARAMETERS tcCampo
        RETURN THIS.campo_obtener_ultimo_error(tcCampo)
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool campo_establecer_ultimo_error(string tcCampo, ;
                                                 string tcUltimoError)
    * @method bool campo_existe_error()
    * @method string campo_obtener_ultimo_error()
    * @method bool validar()
    * @method bool validar_codigo()
    * @method bool validar_nombre()
    */

    **/
    * Establece el �ltimo mensaje de error del campo.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @param string tcUltimoError Mensaje de error a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       est� dentro de un rango espec�fico.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    */
    PROTECTED FUNCTION campo_establecer_ultimo_error
        LPARAMETERS tcCampo, tcUltimoError

        IF !es_cadena(tcCampo) OR !es_cadena(tcUltimoError, 0, 254) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo
        loCampo = THIS.oModelo.campo_obtener(tcCampo)

        IF !es_objeto(loCampo) THEN
            RETURN .F.
        ENDIF

        RETURN loCampo.establecer_ultimo_error(tcUltimoError)
    ENDFUNC

    **/
    * Verifica el �ltimo mensaje de error de todos los campos del modelo.
    *
    * @return bool .T. si existe un error o si ocurre uno;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    */
    PROTECTED FUNCTION campo_existe_error
        LOCAL loCampos, loCampo
        loCampos = THIS.oModelo.campo_obtener_todos()

        IF !es_objeto(loCampos) THEN
            RETURN .T.
        ENDIF

        * Busca errores si encuentra uno devuelve .T. y termina el ciclo.
        FOR EACH loCampo IN loCampos
            IF !EMPTY(loCampo.obtener_ultimo_error()) THEN
                RETURN .T.
            ENDIF
        ENDFOR

        RETURN .F.
    ENDFUNC

    **/
    * Devuelve el �ltimo mensaje de error del campo.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return string Mensaje de error si ocurre una falla;
    *                cadena vac�a si no hay error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       est� dentro de un rango espec�fico.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    */
    PROTECTED FUNCTION campo_obtener_ultimo_error
        LPARAMETERS tcCampo

        IF !es_cadena(tcCampo) THEN
            RETURN "ERROR: El par�metro 'tcCampo' no es v�lido."
        ENDIF

        LOCAL loCampo
        loCampo = THIS.oModelo.campo_obtener(tcCampo)

        IF !es_objeto(loCampo) THEN
            RETURN STRTRAN(MSG_CAMPO_NO_EXISTE, '{}', tcCampo)
        ENDIF

        RETURN loCampo.obtener_ultimo_error()
    ENDFUNC

    **/
    * Ejecuta las validaciones de todos los campos del modelo.
    *
    * Este m�todo es llamado por el constructor ('Init') para las operaciones
    * de Agregar (bandera 1) y Modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los m�todos de validaci�n
    * en la propiedad 'cUltimoError' de cada campo.
    *
    * @return bool .T. si las validaciones se ejecutan correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.

    */
    PROTECTED FUNCTION validar
        LOCAL loCampos, loCampo, lcCampo
        loCampos = THIS.oModelo.campo_obtener_todos()

        IF !es_objeto(loCampos) THEN
            RETURN .F.
        ENDIF

        * Ejecuta todas las validaciones espec�ficas.
        FOR EACH loCampo IN loCampos
            lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

            IF PEMSTATUS(THIS, 'validar_' + lcCampo, 5) THEN
                EVALUATE('THIS.validar_' + lcCampo + '()')
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Valida el c�digo del modelo.
    *
    * @return bool .T. si el c�digo del modelo es v�lido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el �ltimo mensaje de error del campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    * @uses object oDao DAO para la interacci�n con la base de datos.
    */
    PROTECTED FUNCTION validar_codigo
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'codigo'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = THIS.oDao.obtener_por_codigo(.obtener_valor())
        ENDWITH

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + ;
                        THIS.oDao.obtener_ultimo_error())
                    RETURN .F.
                ENDIF

                IF !es_objeto(loModelo) THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_EXISTE)
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Valida el nombre del modelo.
    *
    * @return bool .T. si el nombre del modelo es v�lido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el �ltimo mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el �ltimo mensaje de error del campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase espec�fica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    * @uses object oDao DAO para la interacci�n con la base de datos.
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'nombre'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        * Verifica que el campo 'codigo' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('codigo')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('codigo'))
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = THIS.oDao.obtener_por_nombre(.obtener_valor())
        ENDWITH

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && Modificar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) AND loModelo.obtener('codigo') != ;
                    THIS.oModelo.obtener('codigo') THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC
ENDDEFINE
