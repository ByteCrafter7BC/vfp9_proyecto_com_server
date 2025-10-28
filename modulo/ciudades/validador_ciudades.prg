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
* @file validador_ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_ciudades
* @extends biblioteca\validador_base
* @uses constantes.h
*/

**
* Clase de validación para el modelo 'ciudades'.
*
* Hereda de la clase 'validador_base' y añade dos campos numéricos específicos:
* 'departamen' y 'sifen'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_ciudades AS validador_base OF validador_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error(string tcCampo)
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_establecer_ultimo_error(string tcCampo, ;
                                                 string tcUltimoError)
    * @method bool campo_existe_error()
    * @method string campo_obtener_ultimo_error()
    * @method bool validar()
    * @method bool validar_codigo()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool validar_nombre()
    * @method bool validar_departamen()
    * @method bool validar_sifen()
    */

    **/
    * Valida el nombre del modelo.
    *
    * @return bool .T. si el nombre del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el último mensaje de error del campo.
    * @override
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcCampo
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
    ENDFUNC

    **/
    * Valida la propiedad 'departamen' del modelo.
    *
    * @return bool .T. si a propiedad 'departamen' del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el último mensaje de error del campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su código único.
    * @uses object oModelo Modelo que contiene los datos a validar.
    * @uses object oDao DAO para la interacción con la base de datos.
    */
    PROTECTED FUNCTION validar_departamen
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'departamen'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        * Verifica que el campo 'codigo' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('codigo')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('codigo'))
            RETURN .F.
        ENDIF

        * Verifica que el campo 'nombre' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('nombre')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('nombre'))
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = dao_obtener_por_codigo('depar', .obtener_valor())
        ENDWITH

        IF !es_objeto(loModelo) THEN
            loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_EXISTE)
            RETURN .F.
        ENDIF

        IF !loModelo.obtener('vigente') THEN
            loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_VIGENTE)
            RETURN .F.
        ENDIF

        loModelo = THIS.oDao.obtener_por_nombre( ;
            THIS.oModelo.obtener('nombre'), ;
            THIS.oModelo.obtener('departamen'))

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) THEN
                loCampo.establecer_ultimo_error('Nombre: ' + MSG_YA_EXISTE)
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
                loCampo.establecer_ultimo_error('Nombre: ' + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Valida la propiedad 'sifen' del modelo.
    *
    * @return bool .T. si a propiedad 'sifen' del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el último mensaje de error del campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses mixed dao_obtener_por_codigo(string tcModelo, int tnCodigo)
    *       Para obtener un objeto modelo utilizando su código único.
    * @uses object oModelo Modelo que contiene los datos a validar.
    * @uses object oDao DAO para la interacción con la base de datos.
    */
    PROTECTED FUNCTION validar_sifen
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'sifen'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        * Verifica que el campo 'codigo' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('codigo')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('codigo'))
            RETURN .F.
        ENDIF

        * Verifica que el campo 'nombre' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('nombre')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('nombre'))
            RETURN .F.
        ENDIF

        * Verifica que el campo 'departamen' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('departamen')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('departamen'))
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = NEWOBJECT('sifen_ciudades', 'sifen_ciudades.prg', '', ;
                .obtener_valor())
        ENDWITH

        IF !es_objeto(loModelo) THEN
            loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_EXISTE)
            RETURN .F.
        ENDIF

        IF loModelo.obtener_departamento() != ;
                THIS.oModelo.obtener('departamen') THEN
            loCampo.establecer_ultimo_error(lcEtiqueta + ;
                'Código de departamento no coincide.')
            RETURN .F.
        ENDIF

        loModelo = THIS.oDao.obtener_por_sifen(loCampo.obtener_valor())

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
