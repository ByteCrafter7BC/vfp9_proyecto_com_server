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
* @file prueba_com_marcas1.prg
* @package prueba
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @description Programa principal para ejecutar las pruebas de 'com_marcas1'.
*/

**/
* Programa principal que crea un conjunto de pruebas y ejecuta todas las pruebas
* definidas en la clase 'prueba_com_marcas1'.
*/
CLEAR

LOCAL loConjuntoPrueba
loConjuntoPrueba = CREATEOBJECT('prueba_com_marcas1')

IF VARTYPE(loConjuntoPrueba) != 'O' THEN
    ? 'ERROR: No se pudo crear el conjunto de pruebas.'
    RETURN .F.
ENDIF

? "Iniciando pruebas de 'com_marcas1'..."
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

loConjuntoPrueba = NULL
RELEASE loConjuntoPrueba

**/
* Clase de pruebas para 'com_marcas1'.
*/
DEFINE CLASS prueba_com_marcas1 AS conjunto_prueba OF conjunto_prueba.prg
    **/
    * @var object Objeto de la capa de negocio 'com_marcas1'.
    */
    PROTECTED oCom

    **/
    * @var object Objeto de transferencia de datos utilizado en las pruebas.
    */
    PROTECTED oDto

    **/
    * Ejecuta las pruebas sobre el método 'existe_codigo' y 'existe_nombre'.
    *
    * @return void
    */
    PROCEDURE prueba_existe
        THIS.ejecutar_prueba('Método: existe_codigo | tnCodigo: 3', ;
            THIS.afirmar_verdadero(THIS.oCom.existe_codigo(3), ;
                'Debe existir el código 3.'))

        THIS.ejecutar_prueba('Método: existe_codigo | tnCodigo: 888', ;
            THIS.afirmar_falso(THIS.oCom.existe_codigo(888), ;
                'No debe existir el código 888.'))

        THIS.ejecutar_prueba([Método: existe_nombre | tcNombre: 'Husqvarna'], ;
            THIS.afirmar_verdadero(THIS.oCom.existe_nombre('Husqvarna'), ;
                "Debe existir el nombre 'Husqvarna'."))

        THIS.ejecutar_prueba([Método: existe_nombre | tcNombre: 'Monark' ], ;
            THIS.afirmar_falso(THIS.oCom.existe_nombre('Monark'), ;
                "No debe existir el nombre 'Monark'."))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'esta_vigente'.
    *
    * @return void
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
    * @return void
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
    * @return void
    */
    PROCEDURE prueba_contar
        LOCAL lcCondicionFiltro

        THIS.ejecutar_prueba('Método: contar', ;
            THIS.afirmar_verdadero(THIS.oCom.contar() > 0, ;
                'El resultado de contar() debe ser mayor que cero.'))

        lcCondicionFiltro = 'nombre == [CALOI                         ]'
        THIS.ejecutar_prueba('Método: contar | tcCondicionFiltro: ' + ;
            "'" + lcCondicionFiltro + "'", ;
            THIS.afirmar_verdadero(THIS.oCom.contar(lcCondicionFiltro) == 1, ;
                'El resultado de contar() debe ser igual a uno.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre métodos de obtención de datos.
    *
    * @return void
    */
    PROCEDURE prueba_obtener
        LOCAL lcNombre, lcXml

        THIS.ejecutar_prueba('Método: obtener_nuevo_codigo', ;
            THIS.afirmar_verdadero(THIS.oCom.obtener_nuevo_codigo() > 0, ;
                'El resultado de obtener_nuevo_codigo() ' + ;
                'debe ser mayor que cero.'))

        THIS.ejecutar_prueba('Método: obtener_por_codigo | tnCodigo: 3', ;
            THIS.afirmar_verdadero( ;
                VARTYPE(THIS.oCom.obtener_por_codigo(3)) == 'O', ;
                'Debe existir el código 3.'))

        THIS.ejecutar_prueba('Método: obtener_por_codigo | tnCodigo: 888', ;
            THIS.afirmar_falso( ;
                VARTYPE(THIS.oCom.obtener_por_codigo(888)) == 'O', ;
                'No debe existir el código 888.'))

        lcNombre = 'Briggs & Stratton'
        THIS.ejecutar_prueba( ;
            "Método: obtener_por_nombre | tcNombre: '" + lcNombre + "'", ;
            THIS.afirmar_verdadero( ;
                VARTYPE(THIS.oCom.obtener_por_nombre(lcNombre)) == 'O', ;
                "Debe existir el nombre '" + lcNombre + "'."))

        lcNombre = 'Monark'
        THIS.ejecutar_prueba( ;
            "Método: obtener_por_nombre | tcNombre: '" + lcNombre + "'", ;
            THIS.afirmar_falso( ;
                VARTYPE(THIS.oCom.obtener_por_nombre(lcNombre)) == 'O', ;
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

        lcXml = THIS.oCom.obtener_todos('nombre LIKE [A%]', 'codigo')
        XMLTOCURSOR(lcXml, 'cur_resultado')
        THIS.ejecutar_prueba( ;
            'Método: obtener_todos | ' + ;
                "tcCondicionFiltro: 'nombre LIKE [A%]'; tcOrden: 'codigo'", ;
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
            THIS.afirmar_verdadero(VARTYPE(THIS.oCom.obtener_dto()) == 'O', ;
                'El resultado de obtener_dto() debe ser un objeto.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'agregar'.
    *
    * @return void
    */
    PROCEDURE prueba_agregar
        LOCAL llAgregado
        THIS.oDto = THIS.oCom.obtener_dto()

        IF VARTYPE(THIS.oDto) == 'O' THEN
            WITH THIS.oDto
                .establecer_codigo(THIS.oCom.obtener_nuevo_codigo())
                .establecer_nombre('Nombre ' + ALLTRIM(STR(.obtener_codigo())))
                .establecer_vigente(.T.)
            ENDWITH
        ENDIF

        llAgregado = THIS.oCom.agregar(THIS.oDto)
        THIS.ejecutar_prueba('Método: agregar', ;
            THIS.afirmar_verdadero(VARTYPE(llAgregado) == 'L' AND llAgregado, ;
                'No se pudo agregar el nuevo registro.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'modificar'.
    *
    * @return void
    */
    PROCEDURE prueba_modificar
        LOCAL llModificado

        IF VARTYPE(THIS.oDto) == 'O' THEN
            WITH THIS.oDto
                .establecer_nombre('Nombre ' + ;
                    ALLTRIM(STR(.obtener_codigo())) + ' (modificado)')
                .establecer_vigente(.F.)
            ENDWITH
        ENDIF

        llModificado = THIS.oCom.modificar(THIS.oDto)
        THIS.ejecutar_prueba('Método: modificar', ;
            THIS.afirmar_verdadero( ;
                VARTYPE(llModificado) == 'L' AND llModificado, ;
                'No se pudo agregar el nuevo registro.'))
    ENDPROC

    **/
    * Ejecuta las pruebas sobre el método 'borrar'.
    *
    * @return void
    */
    PROCEDURE prueba_borrar
        LOCAL llBorrado

        llBorrado = THIS.oCom.borrar(3)
        THIS.ejecutar_prueba('Método: borrar', ;
            THIS.afirmar_falso(VARTYPE(llBorrado) == 'L' AND llBorrado, ;
                'Se pudo borrar el registro con código 3.'))
    ENDPROC

    **/
    * Constructor de la clase.
    *
    * Inicializa los contadores de pruebas en cero y el objeto de la capa de
    * negocio 'com_marcas1'.
    *
    * @return .T. si la inicialización se realizó correctamente
    */
    PROTECTED FUNCTION Init
        DODEFAULT()    && Llama al Init de la clase padre.

        THIS.oCom = NEWOBJECT('com_marcas1', 'com_marcas1.prg')

        IF VARTYPE(THIS.oCom) != 'O' THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Destructor de la clase.
    *
    * Libera los recursos utilizados por la instancia, en particular el objeto
    * de la capa de negocio 'oCom'.
    *
    * @return void
    */
    PROTECTED PROCEDURE Destroy
        THIS.oCom = NULL
    ENDPROC
ENDDEFINE
