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
* @file validador_barrios.prg
* @package modulo\barrios
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_barrios
* @extends biblioteca\validador_base
* @uses constantes.h
*/

**
* Clase de validaci�n para el modelo 'barrios'.
*
* Hereda de la clase 'validador_base' y a�ade dos propiedades num�ricas
* espec�ficas: 'departamen' y 'ciudad'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_barrios AS validador_base OF validador_base.prg
    **/
    * @var string Mensaje de error para la propiedad 'departamen'.
    */
    PROTECTED cErrorDepartamen

    **/
    * @var string Mensaje de error para la propiedad 'ciudad'.
    */
    PROTECTED cErrorCiudad

    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool es_valido()
    * @method string obtener_error_departamen()
    * @method string obtener_error_ciudad()
    */

    **/
    * Verifica si el modelo es v�lido seg�n el contexto (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe alg�n
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que el modelo no est�
    *   relacionada con otros registros de la base de datos.
    *
    * @return bool .T. si el modelo es v�lido, o .F. si no lo es.
    * @override
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorDepartamen) ;
                    OR !EMPTY(THIS.cErrorCiudad) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'departamen',
    * o una cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_departamen
        RETURN IIF(VARTYPE(THIS.cErrorDepartamen) == 'C', ;
            THIS.cErrorDepartamen, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'ciudad',
    * o una cadena vac�a si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_ciudad
        RETURN IIF(VARTYPE(THIS.cErrorCiudad) == 'C', THIS.cErrorCiudad, '')
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method string validar_codigo()
    * @method string validar_vigente()
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method void validar()
    * @method string validar_nombre()
    * @method string validar_departamen()
    * @method string validar_ciudad()
    */

    **
    * Ejecuta todas las reglas de validaci�n para el modelo.
    *
    * Llama al m�todo de validaci�n de la clase base y luego ejecuta las
    * validaciones espec�ficas para las propiedades 'departamen' y 'ciudad'.
    *
    * Este m�todo es invocado por el constructor ('Init') para las operaciones
    * de agregar (bandera 1) y modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los m�todos de validaci�n
    * en las propiedades de error de la clase.
    *
    * @override
    */
    PROTECTED FUNCTION validar
        validador_base::validar()

        WITH THIS
            .cErrorDepartamen = .validar_departamen()
            .cErrorCiudad = .validar_ciudad()
        ENDWITH
    ENDFUNC

    **/
    * Valida la propiedad 'nombre' del modelo.
    *
    * @return string Si la propiedad es v�lida, devuelve una cadena vac�a;
    *                de lo contrario, devuelve un mensaje de error.
    * @override
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + MSG_NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'departamen' del modelo.
    *
    * @return string Si la propiedad es v�lida, devuelve una cadena vac�a;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_departamen
        LOCAL lcEtiqueta, lnDepartamen, loModelo
        lcEtiqueta = 'Departamento: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        lnDepartamen = THIS.oModelo.obtener_departamen()

        IF lnDepartamen <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnDepartamen > 999 THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(999 + 1)))
        ENDIF

        loModelo = dao_obtener_por_codigo('depar', lnDepartamen)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_EXISTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        IF !loModelo.esta_vigente() THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_VIGENTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'ciudad' del modelo.
    *
    * @return string Si la propiedad es v�lida, devuelve una cadena vac�a;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_ciudad
        LOCAL lcEtiqueta, lcNombre, lnDepartamen, lnCiudad, loModelo
        lcEtiqueta = 'Ciudad: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        IF !EMPTY(THIS.cErrorDepartamen) THEN
            RETURN THIS.cErrorDepartamen
        ENDIF

        WITH THIS.oModelo
            lcNombre = .obtener_nombre()
            lnDepartamen = .obtener_departamen()
            lnCiudad = .obtener_ciudad()
        ENDWITH

        IF lnCiudad <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnCiudad > 99999 THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(99999 + 1)))
        ENDIF

        loModelo = dao_obtener_por_codigo('ciudades', lnCiudad)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_EXISTE, '{}', ALLTRIM(STR(lnCiudad)))
        ENDIF

        IF !loModelo.esta_vigente() THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_VIGENTE, '{}', ALLTRIM(STR(lnCiudad)))
        ENDIF

        loModelo = THIS.oDao.obtener_por_nombre(lcNombre, ;
            lnDepartamen, lnCiudad)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN 'Nombre: ' + MSG_YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN 'Nombre: ' + MSG_YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
