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
* @file dto_proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_proveedo
* @extends modulo\proveedo\proveedo
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'proveedo'.
*
* Esta clase se utiliza para transportar datos de proveedores entre
* diferentes capas de la aplicación. Hereda de 'proveedo'.
*/
DEFINE CLASS dto_proveedo AS proveedo OF proveedo.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
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
    * @method bool esta_vigente()
    * @method bool es_igual(object toModelo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_direc1(string tcDirec1)
    * @method bool establecer_direc2(string tcDirec2)
    * @method bool establecer_ciudad(string tcCiudad)
    * @method bool establecer_telefono(string tcTelefono)
    * @method bool establecer_fax(string tcFax)
    * @method bool establecer_email(string tcEmail)
    * @method bool establecer_ruc(string tcRuc)
    * @method bool establecer_dias_plazo(int tnDiasPlazo)
    * @method bool establecer_dueno(string tcDueno)
    * @method bool establecer_teldueno(string tcTelDueno)
    * @method bool establecer_gtegral(string tcGteGral)
    * @method bool establecer_telgg(string tcTelGG)
    * @method bool establecer_gteventas(string tcGteVentas)
    * @method bool establecer_telgv(string tcTelGV)
    * @method bool establecer_gtemkg(string tcGteMkg)
    * @method bool establecer_telgm(string tcTelGM)
    * @method bool establecer_stecnico(string tcSTecnico)
    * @method bool establecer_stdirec1(string tcSTDirec1)
    * @method bool establecer_stdirec2(string tcSTDirec2)
    * @method bool establecer_sttel(string tcSTTel)
    * @method bool establecer_sthablar1(string tcSTHablar1)
    * @method bool establecer_vendedor1(string tcVendedor1)
    * @method bool establecer_larti1(string tcLArti1)
    * @method bool establecer_tvend1(string tcTVend1)
    * @method bool establecer_vendedor2(string tcVendedor2)
    * @method bool establecer_larti2(string tcLArti2)
    * @method bool establecer_tvend2(string tcTVend2)
    * @method bool establecer_vendedor3(string tcVendedor3)
    * @method bool establecer_larti3(string tcLArti3)
    * @method bool establecer_tvend3(string tcTVend3)
    * @method bool establecer_vendedor4(string tcVendedor4)
    * @method bool establecer_larti4(string tcLArti4)
    * @method bool establecer_tvend4(string tcTVend4)
    * @method bool establecer_vendedor5(string tcVendedor5)
    * @method bool establecer_larti5(string tcLArti5)
    * @method bool establecer_tvend5(string tcTVend5)
    * @method bool establecer_saldo_actu(float tnSaldoActu)
    * @method bool establecer_saldo_usd(float tnSaldoUSD)
    * @method bool establecer_vigente(bool tlVigente)
    */

    **/
    * @section SETTERS
    */

    **/
    * Establece el código numérico único del proveedor.
    *
    * @param int tnCodigo Código numérico a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_codigo
        LPARAMETERS tnCodigo
        RETURN THIS.asignar_numerico('nCodigo', tnCodigo, .T.)
    ENDFUNC

    **/
    * Establece el nombre del proveedor.
    *
    * @param string tcNombre Nombre a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_nombre
        LPARAMETERS tcNombre
        RETURN THIS.asignar_cadena('cNombre', tcNombre)
    ENDFUNC

    **/
    * Establece la línea 1 de la dirección del proveedor.
    *
    * @param string tcDirec1 Línea 1 de la dirección a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_direc1
        LPARAMETERS tcDirec1
        RETURN THIS.asignar_cadena('cDirec1', tcDirec1)
    ENDFUNC

    **/
    * Establece la línea 2 de la dirección del proveedor.
    *
    * @param string tcDirec2 Línea 2 de la dirección a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_direc2
        LPARAMETERS tcDirec2
        RETURN THIS.asignar_cadena('cDirec2', tcDirec2)
    ENDFUNC

    **/
    * Establece el nombre de la ciudad del proveedor.
    *
    * @param string tcCiudad Nombre de la ciudad a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_ciudad
        LPARAMETERS tcCiudad
        RETURN THIS.asignar_cadena('cCiudad', tcCiudad)
    ENDFUNC

    **/
    * Establece el número de teléfono del proveedor.
    *
    * @param string tcTelefono Número de teléfono a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_telefono
        LPARAMETERS tcTelefono
        RETURN THIS.asignar_cadena('cTelefono', tcTelefono)
    ENDFUNC

    **/
    * Establece el número de fax del proveedor.
    *
    * @param string tcFax Número de fax a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_fax
        LPARAMETERS tcFax
        RETURN THIS.asignar_cadena('cFax', tcFax)
    ENDFUNC

    **/
    * Establece el correo electrónico del proveedor.
    *
    * @param string tcEmail Correo electrónico a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_email
        LPARAMETERS tcEmail
        RETURN THIS.asignar_cadena('cEmail', tcEmail)
    ENDFUNC

    **/
    * Establece el número de identificación tributaria (RUC) del proveedor.
    *
    * @param string tcRuc Número de identificación tributaria (RUC) a
    *                     establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_ruc
        LPARAMETERS tcRuc
        RETURN THIS.asignar_cadena('cRuc', tcRuc)
    ENDFUNC

    **/
    * Establece el número de días de plazo de pago acordado con el proveedor.
    *
    * @param int tnDiasPlazo Número de días de plazo a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_dias_plazo
        LPARAMETERS tnDiasPlazo
        RETURN THIS.asignar_numerico('nDiasPlazo', tnDiasPlazo, .T.)
    ENDFUNC

    **/
    * Establece el nombre del dueño de la empresa proveedora.
    *
    * @param string tcDueno Nombre del dueño a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_dueno
        LPARAMETERS tcDueno
        RETURN THIS.asignar_cadena('cDueno', tcDueno)
    ENDFUNC

    **/
    * Establece el número de teléfono del dueño de la empresa proveedora.
    *
    * @param string tcTelDueno Número de teléfono del dueño a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_teldueno
        LPARAMETERS tcTelDueno
        RETURN THIS.asignar_cadena('cTelDueno', tcTelDueno)
    ENDFUNC

    **/
    * Establece el nombre del gerente general de la empresa proveedora.
    *
    * @param string tcGteGral Nombre del gerente general a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_gtegral
        LPARAMETERS tcGteGral
        RETURN THIS.asignar_cadena('cGteGral', tcGteGral)
    ENDFUNC

    **/
    * Establece el número de teléfono del gerente general de la empresa
    * proveedora.
    *
    * @param string tcTelGG Número de teléfono del gerente general a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_telgg
        LPARAMETERS tcTelGG
        RETURN THIS.asignar_cadena('cTelGG', tcTelGG)
    ENDFUNC

    **/
    * Establece el nombre del gerente de ventas de la empresa proveedora.
    *
    * @param string tcGteVentas Nombre del gerente de ventas a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_gteventas
        LPARAMETERS tcGteVentas
        RETURN THIS.asignar_cadena('cGteVentas', tcGteVentas)
    ENDFUNC

    **/
    * Establece el número de teléfono del gerente de ventas de la empresa
    * proveedora.
    *
    * @param string tcTelGV Número de teléfono del gerente de ventas a
    *                      establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_telgv
        LPARAMETERS tcTelGV
        RETURN THIS.asignar_cadena('cTelGV', tcTelGV)
    ENDFUNC

    **/
    * Establece el nombre del gerente de marketing de la empresa proveedora.
    *
    * @param string tcGteMkg Nombre del gerente de marketing a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_gtemkg
        LPARAMETERS tcGteMkg
        RETURN THIS.asignar_cadena('cGteMkg', tcGteMkg)
    ENDFUNC

    **/
    * Establece el número de teléfono del gerente de marketing de la empresa
    * proveedora.
    *
    * @param string tcTelGM Número de teléfono del gerente de marketing a
    *                       establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_telgm
        LPARAMETERS tcTelGM
        RETURN THIS.asignar_cadena('cTelGM', tcTelGM)
    ENDFUNC

    **/
    * Establece el nombre del servicio técnico de la empresa proveedora.
    *
    * @param string tcSTecnico Nombre del servicio técnico a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_stecnico
        LPARAMETERS tcSTecnico
        RETURN THIS.asignar_cadena('cSTecnico', tcSTecnico)
    ENDFUNC

    **/
    * Establece la línea 1 de la dirección del servicio técnico de la empresa
    * proveedora.
    *
    * @param string tcSTDirec1 Línea 1 de la dirección a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_stdirec1
        LPARAMETERS tcSTDirec1
        RETURN THIS.asignar_cadena('cSTDirec1', tcSTDirec1)
    ENDFUNC

    **/
    * Establece la línea 2 de la dirección del servicio técnico de la empresa
    * proveedora.
    *
    * @param string tcSTDirec2 Línea 2 de la dirección a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_stdirec2
        LPARAMETERS tcSTDirec2
        RETURN THIS.asignar_cadena('cSTDirec2', tcSTDirec2)
    ENDFUNC

    **/
    * Establece el número de teléfono del contacto del servicio técnico de la
    * empresa proveedora.
    *
    * @param string tcSTTel Número de teléfono del contacto a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_sttel
        LPARAMETERS tcSTTel
        RETURN THIS.asignar_cadena('cSTTel', tcSTTel)
    ENDFUNC

    **/
    * Establece el nombre del contacto del servicio técnico de la empresa
    * proveedora.
    *
    * @param string tcSTHablar1 Nombre del contacto a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_sthablar1
        LPARAMETERS tcSTHablar1
        RETURN THIS.asignar_cadena('cSTHablar1', tcSTHablar1)
    ENDFUNC

    **/
    * Establece el nombre del vendedor de la línea de artículos 1 de la empresa
    * proveedora.
    *
    * @param string tcVendedor1 Nombre del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vendedor1
        LPARAMETERS tcVendedor1
        RETURN THIS.asignar_cadena('cVendedor1', tcVendedor1)
    ENDFUNC

    **/
    * Establece el nombre de la línea de artículos 1 de la empresa proveedora.
    *
    * @param string tcLArti1 Nombre de la línea de artículos a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_larti1
        LPARAMETERS tcLArti1
        RETURN THIS.asignar_cadena('cLArti1', tcLArti1)
    ENDFUNC

    **/
    * Establece el número de teléfono del vendedor de la línea de artículos 1
    * de la empresa proveedora.
    *
    * @param string tcTVend1 Número de teléfono del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_tvend1
        LPARAMETERS tcTVend1
        RETURN THIS.asignar_cadena('cTVend1', tcTVend1)
    ENDFUNC

    **/
    * Establece el nombre del vendedor de la línea de artículos 2 de la empresa
    * proveedora.
    *
    * @param string tcVendedor2 Nombre del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vendedor2
        LPARAMETERS tcVendedor2
        RETURN THIS.asignar_cadena('cVendedor2', tcVendedor2)
    ENDFUNC

    **/
    * Establece el nombre de la línea de artículos 2 de la empresa proveedora.
    *
    * @param string tcLArti2 Nombre de la línea de artículos a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_larti2
        LPARAMETERS tcLArti2
        RETURN THIS.asignar_cadena('cLArti2', tcLArti2)
    ENDFUNC

    **/
    * Establece el número de teléfono del vendedor de la línea de artículos 2
    * de la empresa proveedora.
    *
    * @param string tcTVend2 Número de teléfono del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_tvend2
        LPARAMETERS tcTVend2
        RETURN THIS.asignar_cadena('cTVend2', tcTVend2)
    ENDFUNC

    **/
    * Establece el nombre del vendedor de la línea de artículos 3 de la empresa
    * proveedora.
    *
    * @param string tcVendedor3 Nombre del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vendedor3
        LPARAMETERS tcVendedor3
        RETURN THIS.asignar_cadena('cVendedor3', tcVendedor3)
    ENDFUNC

    **/
    * Establece el nombre de la línea de artículos 3 de la empresa proveedora.
    *
    * @param string tcLArti3 Nombre de la línea de artículos a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_larti3
        LPARAMETERS tcLArti3
        RETURN THIS.asignar_cadena('cLArti3', tcLArti3)
    ENDFUNC

    **/
    * Establece el número de teléfono del vendedor de la línea de artículos 3
    * de la empresa proveedora.
    *
    * @param string tcTVend3 Número de teléfono del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_tvend3
        LPARAMETERS tcTVend3
        RETURN THIS.asignar_cadena('cTVend3', tcTVend3)
    ENDFUNC

    **/
    * Establece el nombre del vendedor de la línea de artículos 4 de la empresa
    * proveedora.
    *
    * @param string tcVendedor4 Nombre del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vendedor4
        LPARAMETERS tcVendedor4
        RETURN THIS.asignar_cadena('cVendedor4', tcVendedor4)
    ENDFUNC

    **/
    * Establece el nombre de la línea de artículos 4 de la empresa proveedora.
    *
    * @param string tcLArti4 Nombre de la línea de artículos a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_larti4
        LPARAMETERS tcLArti4
        RETURN THIS.asignar_cadena('cLArti4', tcLArti4)
    ENDFUNC

    **/
    * Establece el número de teléfono del vendedor de la línea de artículos 4
    * de la empresa proveedora.
    *
    * @param string tcTVend4 Número de teléfono del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_tvend4
        LPARAMETERS tcTVend4
        RETURN THIS.asignar_cadena('cTVend4', tcTVend4)
    ENDFUNC

    **/
    * Establece el nombre del vendedor de la línea de artículos 5 de la empresa
    * proveedora.
    *
    * @param string tcVendedor5 Nombre del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vendedor5
        LPARAMETERS tcVendedor5
        RETURN THIS.asignar_cadena('cVendedor5', tcVendedor5)
    ENDFUNC

    **/
    * Establece el nombre de la línea de artículos 5 de la empresa proveedora.
    *
    * @param string tcLArti5 Nombre de la línea de artículos a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_larti5
        LPARAMETERS tcLArti5
        RETURN THIS.asignar_cadena('cLArti5', tcLArti5)
    ENDFUNC

    **/
    * Establece el número de teléfono del vendedor de la línea de artículos 5
    * de la empresa proveedora.
    *
    * @param string tcTVend5 Número de teléfono del vendedor a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_tvend5
        LPARAMETERS tcTVend5
        RETURN THIS.asignar_cadena('cTVend5', tcTVend5)
    ENDFUNC

    **/
    * Establece el saldo actual adeudado al proveedor en moneda local.
    *
    * @param string tnSaldoActu Importe en moneda local a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_saldo_actu
        LPARAMETERS tnSaldoActu
        RETURN THIS.asignar_numerico('nSaldoActu', tnSaldoActu)
    ENDFUNC

    **/
    * Establece el saldo actual adeudado al proveedor en dólares
    * estadounidenses.
    *
    * @param string tnSaldoUSD Importe en dólares estadounidenses a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_saldo_usd
        LPARAMETERS tnSaldoUSD
        RETURN THIS.asignar_numerico('nSaldoUSD', tnSaldoUSD)
    ENDFUNC

    **/
    * Establece el estado de vigencia del proveedor.
    *
    * @param bool tlVigente Valor lógico a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_vigente
        LPARAMETERS tlVigente
        RETURN THIS.asignar_logico('lVigente', tlVigente)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores predeterminados.
    *
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION Init
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
ENDDEFINE
