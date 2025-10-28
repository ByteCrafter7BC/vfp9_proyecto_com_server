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
* @file prueba_com_barrios.prg
* @package prueba
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @description Programa principal para ejecutar las pruebas de 'com_barrios'.
*/

**/
* Programa principal que crea un conjunto de pruebas y ejecuta todas las pruebas
* definidas en la clase 'prueba_com_barrios'.
*
* @uses bool es_objeto(object toObjeto, string [tcClase])
*       Para validar si un valor es un objeto y, opcionalmente, corresponde
*       a una clase específica.
*/
CLEAR

LOCAL loConjuntoPrueba
loConjuntoPrueba = CREATEOBJECT('prueba_com_barrios')

IF !es_objeto(loConjuntoPrueba) THEN
    ? 'ERROR: No se pudo crear el conjunto de pruebas.'
    RETURN .F.
ENDIF

? "Iniciando pruebas de 'com_barrios'..."
? REPLICATE('=', 40)

WITH loConjuntoPrueba
    .prueba_existe()
    .prueba_vigente()
    .prueba_relacionado()
    .prueba_contar()
    .prueba_obtener()
    .prueba_agregar()
    .prueba_modificar()
    .prueba_borrar()
    .obtener_informe()
ENDWITH

loConjuntoPrueba = .F.
RELEASE loConjuntoPrueba

**/
* Clase de pruebas para 'com_barrios'.
*/
DEFINE CLASS prueba_com_barrios AS conjunto_prueba OF conjunto_prueba.prg
    **/
    * @var object Objeto de la capa de negocio 'com_barrios'.
    */
    PROTECTED oCom

    **/
    * @var object Objeto de transferencia de datos utilizado en las pruebas.
    */
    PROTECTED oDto

    **/
    * @section MÉTODOS PÚBLICOS
    * @method void obtener_informe()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method void prueba_existe()
    * @method void prueba_vigente()
    * @method void prueba_relacionado()
    * @method void prueba_contar()
    * @method void prueba_obtener()
    * @method void prueba_agregar()
    * @method void prueba_modificar()
    * @method void prueba_borrar()
    */

    **/
    * Ejecuta las pruebas sobre el método 'existe_codigo' y 'existe_nombre'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool afirmar_falso(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es falso.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_existe
        THIS.ejecutar_prueba('Método: existe_codigo | tnCodigo: 3', ;
            THIS.afirmar_verdadero(THIS.oCom.existe_codigo(3), ;
                'Debe existir el código 3.'))

        THIS.ejecutar_prueba('Método: existe_codigo | tnCodigo: 888', ;
            THIS.afirmar_falso(THIS.oCom.existe_codigo(888), ;
                'No debe existir el código 888.'))

        THIS.ejecutar_prueba( ;
            'Método: existe_nombre | ' + ;
                "tcNombre: '12 de octubre', " + ;
                'tnDepartamen: 13, ' + ;
                'tnCiudad: 171', ;
            THIS.afirmar_verdadero( ;
                THIS.oCom.existe_nombre('12 de octubre', 13, 171), ;
                "Debe existir el nombre '12 de octubre'."))

        THIS.ejecutar_prueba( ;
            'Método: existe_nombre | ' + ;
                "tcNombre: 'Monark', " + ;
                'tnDepartamen: 13, ' + ;
                'tnCiudad: 171', ;
            THIS.afirmar_falso(THIS.oCom.existe_nombre('Monark', 13, 171), ;
                "No debe existir el nombre 'Monark'."))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'esta_vigente'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool afirmar_falso(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es falso.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_vigente
        THIS.ejecutar_prueba('Método: esta_vigente | tnCodigo: 3', ;
            THIS.afirmar_verdadero(THIS.oCom.esta_vigente(3), ;
                'El código 3 debe estar vigente.'))

        THIS.ejecutar_prueba('Método: esta_vigente | tnCodigo: 888', ;
            THIS.afirmar_falso(THIS.oCom.esta_vigente(888), ;
                'El código 888 no debe estar vigente.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'esta_relacionado'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool afirmar_falso(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es falso.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_relacionado
        THIS.ejecutar_prueba('Método: esta_relacionado | tnCodigo: 3', ;
            THIS.afirmar_verdadero(THIS.oCom.esta_relacionado(3), ;
                'El código 3 debe estar relacionado.'))

        THIS.ejecutar_prueba('Método: esta_relacionado | tnCodigo: 888', ;
            THIS.afirmar_falso(THIS.oCom.esta_relacionado(888), ;
                'El código 888 no debe estar relacionado.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'contar'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_contar
        LOCAL lcCondicionFiltro

        THIS.ejecutar_prueba('Método: contar', ;
            THIS.afirmar_verdadero(THIS.oCom.contar() > 0, ;
                'El resultado de contar() debe ser mayor que cero.'))

        lcCondicionFiltro = 'nombre == [VILLA BONITA                  ]'
        THIS.ejecutar_prueba('Método: contar | tcCondicionFiltro: ' + ;
            "'" + lcCondicionFiltro + "'", ;
            THIS.afirmar_verdadero(THIS.oCom.contar(lcCondicionFiltro) == 1, ;
                'El resultado de contar() debe ser igual a uno.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre métodos de obtención de datos.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool afirmar_falso(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es falso.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_obtener
        LOCAL lcNombre, lnDepartamen, lnCiudad, lcXml

        THIS.ejecutar_prueba('Método: obtener_nuevo_codigo', ;
            THIS.afirmar_verdadero(THIS.oCom.obtener_nuevo_codigo() > 0, ;
                'El resultado de obtener_nuevo_codigo() ' + ;
                'debe ser mayor que cero.'))

        THIS.ejecutar_prueba('Método: obtener_por_codigo | tnCodigo: 3', ;
            THIS.afirmar_verdadero( ;
                es_objeto(THIS.oCom.obtener_por_codigo(3)), ;
                'Debe existir el código 3.'))

        THIS.ejecutar_prueba('Método: obtener_por_codigo | tnCodigo: 888', ;
            THIS.afirmar_falso( ;
                es_objeto(THIS.oCom.obtener_por_codigo(888)), ;
                'No debe existir el código 888.'))

        lcNombre = 'Domingo Savio'
        lnDepartamen = 12
        lnCiudad = 154
        THIS.ejecutar_prueba( ;
            'Método: obtener_por_nombre | ' + ;
                "tcNombre: '" + lcNombre + "', " + ;
                'tnDepartamen: 12, ' + ;
                'tnCiudad: 154', ;
            THIS.afirmar_verdadero( ;
                es_objeto(THIS.oCom.obtener_por_nombre( ;
                    lcNombre, lnDepartamen, lnCiudad)), ;
                "Debe existir el nombre '" + lcNombre + "'."))

        lcNombre = 'Monark'
        lnDepartamen = 12
        lnCiudad = 154
        THIS.ejecutar_prueba( ;
            'Método: obtener_por_nombre | ' + ;
                "tcNombre: '" + lcNombre + "', " + ;
                'tnDepartamen: 12, ' + ;
                'tnCiudad: 154', ;
            THIS.afirmar_falso( ;
                es_objeto(THIS.oCom.obtener_por_nombre(;
                    lcNombre, lnDepartamen, lnCiudad)), ;
                "Nos debe existir el nombre '" + lcNombre + "'."))

        lcXml = THIS.oCom.obtener_todos()
        XMLTOCURSOR(lcXml, 'cur_resultado')
        THIS.ejecutar_prueba('Método: obtener_todos', ;
            THIS.afirmar_verdadero(RECCOUNT('cur_resultado') > 0, ;
                'Debe obtener algún resultado.'))
        USE IN cur_resultado

        lcXml = THIS.oCom.obtener_todos('nombre LIKE [C%]')
        XMLTOCURSOR(lcXml, 'cur_resultado')
        THIS.ejecutar_prueba( ;
            "Método: obtener_todos | tcCondicionFiltro: 'nombre LIKE [C%]'", ;
            THIS.afirmar_verdadero(RECCOUNT('cur_resultado') > 0, ;
                'Debe obtener algún resultado.'))
        USE IN cur_resultado

        lcXml = THIS.oCom.obtener_todos('nombre LIKE [V%]', 'codigo')
        XMLTOCURSOR(lcXml, 'cur_resultado')
        THIS.ejecutar_prueba( ;
            'Método: obtener_todos | ' + ;
                "tcCondicionFiltro: 'nombre LIKE [V%]'; tcOrden: 'codigo'", ;
            THIS.afirmar_verdadero(RECCOUNT('cur_resultado') > 0, ;
                'Debe obtener algún resultado.'))
        USE IN cur_resultado

        lcXml = THIS.oCom.obtener_todos('nombre LIKE [a%]', 'codigo')
        XMLTOCURSOR(lcXml, 'cur_resultado')
        THIS.ejecutar_prueba( ;
            'Método: obtener_todos | ' + ;
                "tcCondicionFiltro: 'nombre LIKE [a%]'; tcOrden: 'codigo'", ;
            THIS.afirmar_falso(RECCOUNT('cur_resultado') > 0, ;
                'No debe obtener ningún resultado.'))
        USE IN cur_resultado

        THIS.ejecutar_prueba('Método: obtener_dto', ;
            THIS.afirmar_verdadero(es_objeto(THIS.oCom.obtener_dto()), ;
                'El resultado de obtener_dto() debe ser un objeto.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'agregar'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_agregar
        LOCAL llAgregado
        THIS.oDto = THIS.oCom.obtener_dto()

        IF es_objeto(THIS.oDto) THEN
            WITH THIS.oDto
                .establecer('codigo', THIS.oCom.obtener_nuevo_codigo())
                .establecer('nombre', 'Nombre ' + ;
                    ALLTRIM(STR(.obtener('codigo'))))
                .establecer('departamen', 13)
                .establecer('ciudad', 171)
                .establecer('vigente', .T.)
            ENDWITH
        ENDIF

        llAgregado = THIS.oCom.agregar(THIS.oDto)
        THIS.ejecutar_prueba('Método: agregar', ;
            THIS.afirmar_verdadero(es_logico(llAgregado) AND llAgregado, ;
                'No se pudo agregar el nuevo registro.'))

        IF !llAgregado THEN
            ? 'Mensaje de error DAO: ' + THIS.oCom.obtener_ultimo_error()
        ENDIF
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'modificar'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_verdadero(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es verdadero.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_modificar
        LOCAL llModificado

        IF es_objeto(THIS.oDto) THEN
            WITH THIS.oDto
                .establecer('nombre', 'Nombre ' + ;
                    ALLTRIM(STR(.obtener('codigo'))) + ' (modificado)')
                .establecer('departamen', 10)
                .establecer('ciudad', 129)
                .establecer('vigente', .F.)
            ENDWITH
        ENDIF

        llModificado = THIS.oCom.modificar(THIS.oDto)
        THIS.ejecutar_prueba('Método: modificar', ;
            THIS.afirmar_verdadero( ;
                es_logico(llModificado) AND llModificado, ;
                'No se pudo modificar el nuevo registro.'))

        IF !llModificado THEN
            ? 'Mensaje de error DAO: ' + THIS.oCom.obtener_ultimo_error()
        ENDIF
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'borrar'.
    *
    * @uses void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    *       Para ejecutar una prueba individual y actualiza los contadores.
    * @uses bool afirmar_falso(bool tlValor, string tcMensaje)
    *       Para afirmar que un valor es falso.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    */
    PROCEDURE prueba_borrar
        LOCAL llBorrado

        llBorrado = THIS.oCom.borrar(3)
        THIS.ejecutar_prueba('Método: borrar', ;
            THIS.afirmar_falso(es_logico(llBorrado) AND llBorrado, ;
                'Se pudo borrar el registro con código 3.'))
    ENDPROC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method void ejecutar_prueba(string tcNombrePrueba, bool tlResultado)
    * @method bool afirmar_igual(mixed tvEsperado, mixed tvObtenido, ;
                                 string tcMensaje)
    * @method bool afirmar_verdadero(bool tlValor, string tcMensaje)
    * @method bool afirmar_falso(bool tlValor, string tcMensaje)
    * @method void Destroy()
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method void Init()
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa los contadores de pruebas en cero y el objeto de la capa de
    * negocio 'com_barrios'.
    *
    * @return .T. si la inicialización se realizó correctamente
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses object oCom Objeto de la capa de negocio 'com_barrios'.
    * @override
    */
    PROTECTED FUNCTION Init
        DODEFAULT()    && Llama al Init de la clase padre.

        THIS.oCom = NEWOBJECT('com_barrios', 'com_barrios.prg')

        IF !es_objeto(THIS.oCom) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Destructor de la clase.
    *
    * Libera los recursos utilizados por la instancia, en particular el objeto
    * de la capa de negocio 'oCom'.
    * @uses oCom object Objeto de la capa de negocio 'com_barrios'.
    */
    PROTECTED PROCEDURE Destroy
        THIS.oCom = NULL
    ENDPROC
ENDDEFINE
