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
* @file proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class proveedo
* @extends biblioteca\modelo_base
*/

**/
* Clase modelo de datos para la entidad 'proveedo'.
*/
DEFINE CLASS proveedo AS modelo_base OF modelo_base.prg
    **/
    * @var string Línea 1 de la dirección del proveedor.
    */
    PROTECTED cDirec1

    **/
    * @var string Línea 2 de la dirección del proveedor.
    */
    PROTECTED cDirec2

    **/
    * @var string Nombre de la ciudad del proveedor.
    */
    PROTECTED cCiudad

    **/
    * @var string Número de teléfono del proveedor.
    */
    PROTECTED cTelefono

    **/
    * @var string Número de fax del proveedor.
    */
    PROTECTED cFax

    **/
    * @var string Correo electrónico del proveedor.
    */
    PROTECTED cEmail

    **/
    * @var string Número de identificación tributaria (RUC) del proveedor.
    */
    PROTECTED cRuc

    **/
    * @var int Número de días de plazo de pago acordado con el proveedor.
    */
    PROTECTED nDiasPlazo

    **/
    * @var string Nombre del dueño de la empresa proveedora.
    */
    PROTECTED cDueno

    **/
    * @var string Número de teléfono del dueño de la empresa proveedora.
    */
    PROTECTED cTelDueno

    **/
    * @var string Nombre del gerente general de la empresa proveedora.
    */
    PROTECTED cGteGral

    **/
    * @var string Número de teléfono del gerente general de la empresa
    *             proveedora.
    */
    PROTECTED cTelGG

    **/
    * @var string Nombre del gerente de ventas de la empresa proveedora.
    */
    PROTECTED cGteVentas

    **/
    * @var string Número de teléfono del gerente de ventas de la empresa
    *             proveedora.
    */
    PROTECTED cTelGV

    **/
    * @var string Nombre del gerente de marketing de la empresa proveedora.
    */
    PROTECTED cGteMkg

    **/
    * @var string Número de teléfono del gerente de marketing de la empresa
    *             proveedora.
    */
    PROTECTED cTelGM

    **/
    * @var string Servicio técnico de la empresa proveedora.
    */
    PROTECTED cSTecnico

    **/
    * @var string Línea 1 de la dirección del servicio técnico de la empresa
    *             proveedora.
    */
    PROTECTED cSTDirec1

    **/
    * @var string Línea 2 de la dirección del servicio técnico de la empresa
    *             proveedora.
    */
    PROTECTED cSTDirec2

    **/
    * @var string Número de teléfono del contacto del servicio técnico de la
    *             empresa proveedora.
    */
    PROTECTED cSTTel

    **/
    * @var string Nombre del contacto del servicio técnico de la empresa
    *             proveedora.
    PROTECTED cSTHablar1

    **/
    * @var string Nombre del vendedor de la línea de artículos 1 de la empresa
    *             proveedora.
    */
    PROTECTED cVendedor1

    **/
    * @var string Nombre de la línea de artículos 1 de la empresa proveedora.
    */
    PROTECTED cLArti1

    **/
    * @var string Número de teléfono del vendedor de la línea de artículos 1
    *             de la empresa proveedora.
    */
    PROTECTED cTVend1

    **/
    * @var string Nombre del vendedor de la línea de artículos 2 de la empresa
    *             proveedora.
    */
    PROTECTED cVendedor2

    **/
    * @var string Nombre de la línea de artículos 2 de la empresa proveedora.
    */
    PROTECTED cLArti2

    **/
    * @var string Número de teléfono del vendedor de la línea de artículos 2
    *             de la empresa proveedora.
    */
    PROTECTED cTVend2

    **/
    * @var string Nombre del vendedor de la línea de artículos 3 de la empresa
    *             proveedora.
    */
    PROTECTED cVendedor3

    **/
    * @var string Nombre de la línea de artículos 3 de la empresa proveedora.
    */
    PROTECTED cLArti3

    **/
    * @var string Número de teléfono del vendedor de la línea de artículos 3
    *             de la empresa proveedora.
    */
    PROTECTED cTVend3

    **/
    * @var string Nombre del vendedor de la línea de artículos 4 de la empresa
    *             proveedora.
    */
    PROTECTED cVendedor4

    **/
    * @var string Nombre de la línea de artículos 4 de la empresa proveedora.
    */
    PROTECTED cLArti4

    **/
    * @var string Número de teléfono del vendedor de la línea de artículos 4
    *             de la empresa proveedora.
    */
    PROTECTED cTVend4

    **/
    * @var string Nombre del vendedor de la línea de artículos 5 de la empresa
    *             proveedora.
    */
    PROTECTED cVendedor5

    **/
    * @var string Nombre de la línea de artículos 5 de la empresa proveedora.
    */
    PROTECTED cLArti5

    **/
    * @var string Número de teléfono del vendedor de la línea de artículos 5
    *             de la empresa proveedora.
    */
    PROTECTED cTVend5

    **/
    * @var float Saldo actual adeudado al proveedor en moneda local.
    */
    PROTECTED nSaldoActu

    **/
    * @var float Saldo actual adeudado al proveedor en dólares estadounidenses.
    */
    PROTECTED nSaldoUSD

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(object toDto)
    * @method string obtener_direc1()
    * @method string obtener_direc2()
    * @method string obtener_ciudad()
    * @method string obtener_telefono()
    * @method string obtener_fax()
    * @method string obtener_email()
    * @method string obtener_ruc()
    * @method int obtener_dias_plazo()
    * @method string obtener_dueno()
    * @method string obtener_teldueno()
    * @method string obtener_gtegral()
    * @method string obtener_telgg()
    * @method string obtener_gteventas()
    * @method string obtener_telgv()
    * @method string obtener_gtemkg()
    * @method string obtener_telgm()
    * @method string obtener_stecnico()
    * @method string obtener_stdirec1()
    * @method string obtener_stdirec2()
    * @method string obtener_sttel()
    * @method string obtener_sthablar1()
    * @method string obtener_vendedor1()
    * @method string obtener_larti1()
    * @method string obtener_tvend1()
    * @method string obtener_vendedor2()
    * @method string obtener_larti2()
    * @method string obtener_tvend2()
    * @method string obtener_vendedor3()
    * @method string obtener_larti3()
    * @method string obtener_tvend3()
    * @method string obtener_vendedor4()
    * @method string obtener_larti4()
    * @method string obtener_tvend4()
    * @method string obtener_vendedor5()
    * @method string obtener_larti5()
    * @method string obtener_tvend5()
    * @method float obtener_saldo_actu()
    * @method float obtener_saldo_usd()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param object toDto DTO con los datos para inicializar el modelo.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    */
    FUNCTION Init
        LPARAMETERS toDto

        * inicio { validaciones del parámetro }
        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        * Propiedades mínimas requeridas en el DTO.
        IF VARTYPE(toDto.codigo) != 'N' ;
                OR VARTYPE(toDto.nombre) != 'C' ;
                OR VARTYPE(toDto.ruc) != 'C' ;
                OR VARTYPE(toDto.vigente) != 'C' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL m.codigo, m.nombre, m.direc1, m.direc2, m.ciudad, m.telefono, ;
              m.fax, m.e_mail, m.ruc, m.dias_plazo, m.dueno, m.teldueno, ;
              m.gtegral, m.telgg, m.gteventas, m.telgv, m.gtemkg, m.telgm, ;
              m.stecnico, m.stdirec1, m.stdirec2, m.sttel, m.sthablar1, ;
              m.vendedor1, m.larti1, m.tvend1, m.vendedor2, m.larti2,
              m.tvend2, m.vendedor3, m.larti3, m.tvend3, m.vendedor4, ;
              m.larti4, m.tvend4, m.vendedor5, m.larti5, m.tvend5, ;
              m.saldo_actu, m.saldo_usd, m.vigente

        STORE 0 TO m.codigo, m.dias_plazo, m.saldo_actu, m.saldo_usd
        STORE '' TO m.nombre, m.direc1, m.direc2, m.ciudad, m.telefono, ;
                    m.fax, m.e_mail, m.ruc, m.dueno, m.teldueno, m.gtegral, ;
                    m.telgg, m.gteventas, m.telgv, m.gtemkg, m.telgm, ;
                    m.stecnico, m.stdirec1, m.stdirec2, m.sttel, m.sthablar1, ;
                    m.vendedor1, m.larti1, m.tvend1, m.vendedor2, m.larti2, ;
                    m.tvend2, m.vendedor3, m.larti3, m.tvend3, m.vendedor4, ;
                    m.larti4, m.tvend4, m.vendedor5, m.larti5, m.tvend5, ;
                    m.vigente

        * Inicialización de propiedades requeridas con datos del DTO.
        m.codigo = toDto.codigo
        m.nombre = ALLTRIM(toDto.nombre)
        m.ruc = ALLTRIM(toDto.ruc)
        m.vigente = IIF(UPPER(ALLTRIM(toDto.vigente)) == 'S', .T., .F.)

        * Inicialización de propiedades opcionales con datos del DTO.
        IF VARTYPE(toDto.direc1) == 'C' THEN
            m.direc1 = ALLTRIM(toDto.direc1)
        ENDIF

        IF VARTYPE(toDto.direc2) == 'C' THEN
            m.direc2 = ALLTRIM(toDto.direc2)
        ENDIF

        IF VARTYPE(toDto.ciudad) == 'C' THEN
            m.ciudad = ALLTRIM(toDto.ciudad)
        ENDIF

        IF VARTYPE(toDto.telefono) == 'C' THEN
            m.telefono = ALLTRIM(toDto.telefono)
        ENDIF

        IF VARTYPE(toDto.fax) == 'C' THEN
            m.fax = ALLTRIM(toDto.fax)
        ENDIF

        IF VARTYPE(toDto.e_mail) == 'C' THEN
            m.e_mail = ALLTRIM(toDto.e_mail)
        ENDIF

        IF VARTYPE(toDto.dias_plazo) == 'N' THEN
            m.dias_plazo = toDto.dias_plazo
        ENDIF

        IF VARTYPE(toDto.dueno) == 'C' THEN
            m.dueno = ALLTRIM(toDto.dueno)
        ENDIF

        IF VARTYPE(toDto.teldueno) == 'C' THEN
            m.teldueno = ALLTRIM(toDto.teldueno)
        ENDIF

        IF VARTYPE(toDto.gtegral) == 'C' THEN
            m.gtegral = ALLTRIM(toDto.gtegral)
        ENDIF

        IF VARTYPE(toDto.telgg) == 'C' THEN
            m.telgg = ALLTRIM(toDto.telgg)
        ENDIF

        IF VARTYPE(toDto.gteventas) == 'C' THEN
            m.gteventas = ALLTRIM(toDto.gteventas)
        ENDIF

        IF VARTYPE(toDto.telgv) == 'C' THEN
            m.telgv = ALLTRIM(toDto.telgv)
        ENDIF

        IF VARTYPE(toDto.gtemkg) == 'C' THEN
            m.gtemkg = ALLTRIM(toDto.gtemkg)
        ENDIF

        IF VARTYPE(toDto.telgm) == 'C' THEN
            m.telgm = ALLTRIM(toDto.telgm)
        ENDIF

        IF VARTYPE(toDto.stecnico) == 'C' THEN
            m.stecnico = ALLTRIM(toDto.stecnico)
        ENDIF

        IF VARTYPE(toDto.stdirec1) == 'C' THEN
            m.stdirec1 = ALLTRIM(toDto.stdirec1)
        ENDIF

        IF VARTYPE(toDto.stdirec2) == 'C' THEN
            m.stdirec2 = ALLTRIM(toDto.stdirec2)
        ENDIF

        IF VARTYPE(toDto.sttel) == 'C' THEN
            m.sttel = ALLTRIM(toDto.sttel)
        ENDIF

        IF VARTYPE(toDto.sthablar1) == 'C' THEN
            m.sthablar1 = ALLTRIM(toDto.sthablar1)
        ENDIF

        IF VARTYPE(toDto.vendedor1) == 'C' THEN
            m.vendedor1 = ALLTRIM(toDto.vendedor1)
        ENDIF

        IF VARTYPE(toDto.larti1) == 'C' THEN
            m.larti1 = ALLTRIM(toDto.larti1)
        ENDIF

        IF VARTYPE(toDto.tvend1) == 'C' THEN
            m.tvend1 = ALLTRIM(toDto.tvend1)
        ENDIF

        IF VARTYPE(toDto.vendedor2) == 'C' THEN
            m.vendedor2 = ALLTRIM(toDto.vendedor2)
        ENDIF

        IF VARTYPE(toDto.larti2) == 'C' THEN
            m.larti2 = ALLTRIM(toDto.larti2)
        ENDIF

        IF VARTYPE(toDto.tvend2) == 'C' THEN
            m.tvend2 = ALLTRIM(toDto.tvend2)
        ENDIF

        IF VARTYPE(toDto.vendedor3) == 'C' THEN
            m.vendedor3 = ALLTRIM(toDto.vendedor3)
        ENDIF

        IF VARTYPE(toDto.larti3) == 'C' THEN
            m.larti3 = ALLTRIM(toDto.larti3)
        ENDIF

        IF VARTYPE(toDto.tvend3) == 'C' THEN
            m.tvend3 = ALLTRIM(toDto.tvend3)
        ENDIF

        IF VARTYPE(toDto.vendedor4) == 'C' THEN
            m.vendedor4 = ALLTRIM(toDto.vendedor4)
        ENDIF

        IF VARTYPE(toDto.larti4) == 'C' THEN
            m.larti4 = ALLTRIM(toDto.larti4)
        ENDIF

        IF VARTYPE(toDto.tvend4) == 'C' THEN
            m.tvend4 = ALLTRIM(toDto.tvend4)
        ENDIF

        IF VARTYPE(toDto.vendedor5) == 'C' THEN
            m.vendedor5 = ALLTRIM(toDto.vendedor5)
        ENDIF

        IF VARTYPE(toDto.larti5) == 'C' THEN
            m.larti5 = ALLTRIM(toDto.larti5)
        ENDIF

        IF VARTYPE(toDto.tvend5) == 'C' THEN
            m.tvend5 = ALLTRIM(toDto.tvend5)
        ENDIF

        IF VARTYPE(toDto.saldo_actu) == 'N' THEN
            m.saldo_actu = toDto.saldo_actu
        ENDIF

        IF VARTYPE(toDto.saldo_usd) == 'N' THEN
            m.saldo_usd = toDto.saldo_usd
        ENDIF

        * Asignación de valores a las propiedades del objeto.
        WITH THIS
            .nCodigo = m.codigo
            .cNombre = m.nombre
            .cDirec1 = m.direc1
            .cDirec2 = m.direc2
            .cCiudad = m.ciudad
            .cTelefono = m.telefono
            .cFax = m.fax
            .cEmail = m.e_mail
            .cRuc = m.ruc
            .nDiasPlazo = m.dias_plazo
            .cDueno = m.dueno
            .cTelDueno = m.teldueno
            .cGteGral = m.gtegral
            .cTelGG = m.telgg
            .cGteVentas = m.gteventas
            .cTelGV = m.telgv
            .cGteMkg = m.gtemkg
            .cTelGM = m.telgm
            .cSTecnico = m.stecnico
            .cSTDirec1 = m.stdirec1
            .cSTDirec2 = m.stdirec2
            .cSTTel = m.sttel
            .cSTHablar1 = m.sthablar1
            .cVendedor1 = m.vendedor1
            .cLArti1 = m.larti1
            .cTVend1 = m.tvend1
            .cVendedor2 = m.vendedor2
            .cLArti2 = m.larti2
            .cTVend2 = m.tvend2
            .cVendedor3 = m.vendedor3
            .cLArti3 = m.larti3
            .cTVend3 = m.tvend3
            .cVendedor4 = m.vendedor4
            .cLArti4 = m.larti4
            .cTVend4 = m.tvend4
            .cVendedor5 = m.vendedor5
            .cLArti5 = m.larti5
            .cTVend5 = m.tvend5
            .nSaldoActu = m.saldo_actu
            .nSaldoUSD = m.saldo_usd
            .lVigente = m.vigente
        ENDWITH
    ENDFUNC

    **/
    * Devuelve la línea 1 de la dirección del proveedor.
    *
    * @return string Línea 1 de la dirección del proveedor.
    */
    FUNCTION obtener_direc1
        RETURN THIS.cDirec1
    ENDFUNC

    **/
    * Devuelve la línea 2 de la dirección del proveedor.
    *
    * @return string Línea 2 de la dirección del proveedor.
    */
    FUNCTION obtener_direc2
        RETURN THIS.cDirec2
    ENDFUNC

    **/
    * Devuelve el nombre de la ciudad del proveedor.
    *
    * @return string Ciudad del proveedor.
    */
    FUNCTION obtener_ciudad
        RETURN THIS.cCiudad
    ENDFUNC

    **/
    * Devuelve el número de teléfono del proveedor.
    *
    * @return string Número de teléfono del proveedor.
    */
    FUNCTION obtener_telefono
        RETURN THIS.cTelefono
    ENDFUNC

    **/
    * Devuelve el número de fax del proveedor.
    *
    * @return string Número de fax del proveedor.
    */
    FUNCTION obtener_fax
        RETURN THIS.cFax
    ENDFUNC

    **/
    * Devuelve el correo electrónico del proveedor.
    *
    * @return string Correo electrónico del proveedor.
    */
    FUNCTION obtener_email
        RETURN THIS.cEmail
    ENDFUNC

    **/
    * Devuelve el número de identificación tributaria (RUC) del proveedor.
    *
    * @return string Número de identificación tributaria (RUC) del proveedor.
    */
    FUNCTION obtener_ruc
        RETURN THIS.cRuc
    ENDFUNC

    **/
    * Devuelve el número de días de plazo de pago acordado con el proveedor.
    *
    * @return int Número de días de plazo de pago acordado con el proveedor.
    */
    FUNCTION obtener_dias_plazo
        RETURN THIS.nDiasPlazo
    ENDFUNC

    **/
    * Devuelve el nombre del dueño de la empresa proveedora.
    *
    * @return string Nombre del dueño de la empresa proveedora.
    */
    FUNCTION obtener_dueno
        RETURN THIS.cDueno
    ENDFUNC

    **/
    * Devuelve el número de teléfono del dueño de la empresa proveedora.
    *
    * @return string Número de teléfono del dueño de la empresa proveedora.
    */
    FUNCTION obtener_teldueno
        RETURN THIS.cTelDueno
    ENDFUNC

    **/
    * Devuelve el nombre del gerente general de la empresa proveedora.
    *
    * @return string Nombre del gerente general de la empresa proveedora.
    */
    FUNCTION obtener_gtegral
        RETURN THIS.cGteGral
    ENDFUNC

    **/
    * Devuelve el número de teléfono del gerente general de la empresa
    * proveedora.
    *
    * @return string Número de teléfono del gerente general de la empresa
    *                proveedora.
    */
    FUNCTION obtener_telgg
        RETURN THIS.cTelGG
    ENDFUNC

    **/
    * Devuelve el nombre del gerente de ventas de la empresa proveedora.
    *
    * @return string Nombre del gerente de ventas de la empresa proveedora.
    */
    FUNCTION obtener_gteventas
        RETURN THIS.cGteVentas
    ENDFUNC

    **/
    * Devuelve el número de teléfono del gerente de ventas de la empresa
    * proveedora.
    *
    * @return string Número de teléfono del gerente de ventas de la empresa
    *                proveedora.
    */
    FUNCTION obtener_telgv
        RETURN THIS.cTelGV
    ENDFUNC

    **/
    * Devuelve el nombre del gerente de marketing de la empresa proveedora.
    *
    * @return string Nombre del gerente de marketing de la empresa proveedora.
    */
    FUNCTION obtener_gtemkg
        RETURN THIS.cGteMkg
    ENDFUNC

    **/
    * Devuelve el número de teléfono del gerente de marketing de la empresa
    * proveedora.
    *
    * @return string Número de teléfono del gerente de marketing de la empresa
    *                proveedora.
    */
    FUNCTION obtener_telgm
        RETURN THIS.cTelGM
    ENDFUNC

    **/
    * Devuelve el nombre del servicio técnico de la empresa proveedora.
    *
    * @return string Nombre del servicio técnico de la empresa proveedora.
    */
    FUNCTION obtener_stecnico
        RETURN THIS.cSTecnico
    ENDFUNC

    **/
    * Devuelve la línea 1 de la dirección del servicio técnico de la empresa
    * proveedora.
    *
    * @return string Línea 1 de la dirección del servicio técnico de la empresa
    *                proveedora.
    */
    FUNCTION obtener_stdirec1
        RETURN THIS.cSTDirec1
    ENDFUNC

    **/
    * Devuelve la línea 2 de la dirección del servicio técnico de la empresa
    * proveedora.
    *
    * @return string Línea 2 de la dirección del servicio técnico de la empresa
    *                proveedora.
    */
    FUNCTION obtener_stdirec2
        RETURN THIS.cSTDirec2
    ENDFUNC

    **/
    * Devuelve el número de teléfono del contacto del servicio técnico de la
    * empresa proveedora.
    *
    * @return string Número de teléfono del contacto del servicio técnico de la
    *                empresa proveedora.
    */
    FUNCTION obtener_sttel
        RETURN THIS.cSTTel
    ENDFUNC

    **/
    * Devuelve el nombre del contacto del servicio técnico de la empresa
    * proveedora.
    *
    * @return string Nombre del contacto del servicio técnico de la empresa
    *                proveedora.
    */
    FUNCTION obtener_sthablar1
        RETURN THIS.cSTHablar1
    ENDFUNC

    **/
    * Devuelve el nombre del vendedor de la línea de artículos 1 de la empresa
    * proveedora.
    *
    * @return string Nombre del vendedor de la línea de artículos 1 de la
    *                empresa proveedora.
    */
    FUNCTION obtener_vendedor1
        RETURN THIS.cVendedor1
    ENDFUNC

    **/
    * Devuelve el nombre de la línea de artículos 1 de la empresa proveedora.
    *
    * @return string Nombre de la línea de artículos 1 de la empresa proveedora.
    */
    FUNCTION obtener_larti1
        RETURN THIS.cLArti1
    ENDFUNC

    **/
    * Devuelve el número de teléfono del vendedor de la línea de artículos 1
    * de la empresa proveedora.
    *
    * @return string Número de teléfono del vendedor de la línea de artículos 1
    *                de la empresa proveedora.
    */
    FUNCTION obtener_tvend1
        RETURN THIS.cTVend1
    ENDFUNC

    **/
    * Devuelve el nombre del vendedor de la línea de artículos 2 de la empresa
    * proveedora.
    *
    * @return string Nombre del vendedor de la línea de artículos 2 de la
    *                empresa proveedora.
    */
    FUNCTION obtener_vendedor2
        RETURN THIS.cVendedor2
    ENDFUNC

    **/
    * Devuelve el nombre de la línea de artículos 2 de la empresa proveedora.
    *
    * @return string Nombre de la línea de artículos 2 de la empresa proveedora.
    */
    FUNCTION obtener_larti2
        RETURN THIS.cLArti2
    ENDFUNC

    **/
    * Devuelve el número de teléfono del vendedor de la línea de artículos 2
    * de la empresa proveedora.
    *
    * @return string Número de teléfono del vendedor de la línea de artículos 2
    *                de la empresa proveedora.
    */
    FUNCTION obtener_tvend2
        RETURN THIS.cTVend2
    ENDFUNC

    **/
    * Devuelve el nombre del vendedor de la línea de artículos 3 de la empresa
    * proveedora.
    *
    * @return string Nombre del vendedor de la línea de artículos 3 de la
    *                empresa proveedora.
    */
    FUNCTION obtener_vendedor3
        RETURN THIS.cVendedor3
    ENDFUNC

    **/
    * Devuelve el nombre de la línea de artículos 3 de la empresa proveedora.
    *
    * @return string Nombre de la línea de artículos 3 de la empresa proveedora.
    */
    FUNCTION obtener_larti3
        RETURN THIS.cLArti3
    ENDFUNC

    **/
    * Devuelve el número de teléfono del vendedor de la línea de artículos 3
    * de la empresa proveedora.
    *
    * @return string Número de teléfono del vendedor de la línea de artículos 3
    *                de la empresa proveedora.
    */
    FUNCTION obtener_tvend3
        RETURN THIS.cTVend3
    ENDFUNC

    **/
    * Devuelve el nombre del vendedor de la línea de artículos 4 de la empresa
    * proveedora.
    *
    * @return string Nombre del vendedor de la línea de artículos 4 de la
    *                empresa proveedora.
    */
    FUNCTION obtener_vendedor4
        RETURN THIS.cVendedor4
    ENDFUNC

    **/
    * Devuelve el nombre de la línea de artículos 4 de la empresa proveedora.
    *
    * @return string Nombre de la línea de artículos 4 de la empresa proveedora.
    */
    FUNCTION obtener_larti4
        RETURN THIS.cLArti4
    ENDFUNC

    **/
    * Devuelve el número de teléfono del vendedor de la línea de artículos 4
    * de la empresa proveedora.
    *
    * @return string Número de teléfono del vendedor de la línea de artículos 4
    *                de la empresa proveedora.
    */
    FUNCTION obtener_tvend4
        RETURN THIS.cTVend4
    ENDFUNC

    **/
    * Devuelve el nombre del vendedor de la línea de artículos 5 de la empresa
    * proveedora.
    *
    * @return string Nombre del vendedor de la línea de artículos 5 de la
    *               empresa proveedora.
    */
    FUNCTION obtener_vendedor5
        RETURN THIS.cVendedor5
    ENDFUNC

    **/
    * Devuelve el nombre de la línea de artículos 5 de la empresa proveedora.
    *
    * @return string Nombre de la línea de artículos 5 de la empresa proveedora.
    */
    FUNCTION obtener_larti5
        RETURN THIS.cLArti5
    ENDFUNC

    **/
    * Devuelve el número de teléfono del vendedor de la línea de artículos 5
    * de la empresa proveedora.
    *
    * @return string Número de teléfono del vendedor de la línea de artículos 5
    *                de la empresa proveedora.
    */
    FUNCTION obtener_tvend5
        RETURN THIS.cTVend5
    ENDFUNC

    **/
    * Devuelve el saldo actual adeudado al proveedor en moneda local.
    *
    * @return float Saldo actual adeudado al proveedor en moneda local.
    */
    FUNCTION obtener_saldo_actu
        RETURN THIS.nSaldoActu
    ENDFUNC

    **/
    * Devuelve el saldo actual adeudado al proveedor en dólares estadounidenses.
    *
    * @return float Saldo actual adeudado al proveedor en dólares
    *               estadounidenses.
    */
    FUNCTION obtener_saldo_usd
        RETURN THIS.nSaldoUSD
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara casi todas las propiedades del objeto actual con las del otro
    * objeto modelo; las propiedades 'nSaldoActu' y 'nSaldoUSD' se excluyen
    * de la comparación.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.Name) THEN
            RETURN .F.
        ENDIF

        LOCAL lnFilas, lcMetodo, lcPropiedad, lnContador
        lnFilas = 39

        DIMENSION laMetodos[lnFilas], laPropiedades[lnFilas]

        laMetodos[1]  = 'obtener_codigo'        && nCodigo
        laMetodos[2]  = 'obtener_nombre'        && cNombre
        laMetodos[3]  = 'obtener_direc1'        && cDirec1
        laMetodos[4]  = 'obtener_direc2'        && cDirec2
        laMetodos[5]  = 'obtener_ciudad'        && cCiudad
        laMetodos[6]  = 'obtener_telefono'      && cTelefono
        laMetodos[7]  = 'obtener_fax'           && cFax
        laMetodos[8]  = 'obtener_email'         && cEmail
        laMetodos[9]  = 'obtener_ruc'           && cRuc
        laMetodos[10] = 'obtener_dias_plazo'    && nDiasPlazo
        laMetodos[11] = 'obtener_dueno'         && cDueno
        laMetodos[12] = 'obtener_teldueno'      && cTelDueno
        laMetodos[13] = 'obtener_gtegral'       && cGteGral
        laMetodos[14] = 'obtener_telgg'         && cTelGG
        laMetodos[15] = 'obtener_gteventas'     && cGteVentas
        laMetodos[16] = 'obtener_telgv'         && cTelGV
        laMetodos[17] = 'obtener_gtemkg'        && cGteMkg
        laMetodos[18] = 'obtener_telgm'         && cTelGM
        laMetodos[19] = 'obtener_stecnico'      && cSTecnico
        laMetodos[20] = 'obtener_stdirec1'      && cSTDirec1
        laMetodos[21] = 'obtener_stdirec2'      && cSTDirec2
        laMetodos[22] = 'obtener_sttel'         && cSTTel
        laMetodos[23] = 'obtener_sthablar1'     && cSTHablar1
        laMetodos[24] = 'obtener_vendedor1'     && cVendedor1
        laMetodos[25] = 'obtener_larti1'        && cLArti1
        laMetodos[26] = 'obtener_tvend1'        && cTVend1
        laMetodos[27] = 'obtener_vendedor2'     && cVendedor2
        laMetodos[28] = 'obtener_larti2'        && cLArti2
        laMetodos[29] = 'obtener_tvend2'        && cTVend2
        laMetodos[30] = 'obtener_vendedor3'     && cVendedor3
        laMetodos[31] = 'obtener_larti3'        && cLArti3
        laMetodos[32] = 'obtener_tvend3'        && cTVend3
        laMetodos[33] = 'obtener_vendedor4'     && cVendedor4
        laMetodos[34] = 'obtener_larti4'        && cLArti4
        laMetodos[35] = 'obtener_tvend4'        && cTVend4
        laMetodos[36] = 'obtener_vendedor5'     && cVendedor5
        laMetodos[37] = 'obtener_larti5'        && cLArti5
        laMetodos[38] = 'obtener_tvend5'        && cTVend5
        laMetodos[39] = 'esta_vigente'          && lVigente

        laPropiedades[1]  = 'nCodigo'
        laPropiedades[2]  = 'cNombre'
        laPropiedades[3]  = 'cDirec1'
        laPropiedades[4]  = 'cDirec2'
        laPropiedades[5]  = 'cCiudad'
        laPropiedades[6]  = 'cTelefono'
        laPropiedades[7]  = 'cFax'
        laPropiedades[8]  = 'cEmail'
        laPropiedades[9]  = 'cRuc'
        laPropiedades[10] = 'nDiasPlazo'
        laPropiedades[11] = 'cDueno'
        laPropiedades[12] = 'cTelDueno'
        laPropiedades[13] = 'cGteGral'
        laPropiedades[14] = 'cTelGG'
        laPropiedades[15] = 'cGteVentas'
        laPropiedades[16] = 'cTelGV'
        laPropiedades[17] = 'cGteMkg'
        laPropiedades[18] = 'cTelGM'
        laPropiedades[19] = 'cSTecnico'
        laPropiedades[20] = 'cSTDirec1'
        laPropiedades[21] = 'cSTDirec2'
        laPropiedades[22] = 'cSTTel'
        laPropiedades[23] = 'cSTHablar1'
        laPropiedades[24] = 'cVendedor1'
        laPropiedades[25] = 'cLArti1'
        laPropiedades[26] = 'cTVend1'
        laPropiedades[27] = 'cVendedor2'
        laPropiedades[28] = 'cLArti2'
        laPropiedades[29] = 'cTVend2'
        laPropiedades[30] = 'cVendedor3'
        laPropiedades[31] = 'cLArti3'
        laPropiedades[32] = 'cTVend3'
        laPropiedades[33] = 'cVendedor4'
        laPropiedades[34] = 'cLArti4'
        laPropiedades[35] = 'cTVend4'
        laPropiedades[36] = 'cVendedor5'
        laPropiedades[37] = 'cLArti5'
        laPropiedades[38] = 'cTVend5'
        laPropiedades[39] = 'lVigente'

        FOR lnContador = 1 TO lnFilas
            IF PEMSTATUS(toModelo, laMetodos[lnContador], 5) THEN
                lcMetodo = 'toModelo.' + laMetodos[lnContador] + '()'
                lcPropiedad = 'THIS.' + laPropiedades[lnContador]

                IF EVALUATE(lcMetodo) != EVALUATE(lcPropiedad) THEN
                    RETURN .F.
                ENDIF
            ELSE
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC
ENDDEFINE
