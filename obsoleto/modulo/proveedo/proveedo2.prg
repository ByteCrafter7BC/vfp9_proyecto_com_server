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
    * @section MÉTODOS PÚBLICOS
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(object toDto)
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
    * @override
    */
    FUNCTION Init
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' OR !THIS.campo_cargar() THEN
            RETURN .F.
        ENDIF

        * Declaración de variables locales.
        LOCAL m.codigo, m.nombre, m.direc1, m.direc2, m.ciudad, m.telefono, ;
              m.fax, m.e_mail, m.ruc, m.dias_plazo, m.dueno, m.teldueno, ;
              m.gtegral, m.telgg, m.gteventas, m.telgv, m.gtemkg, m.telgm, ;
              m.stecnico, m.stdirec1, m.stdirec2, m.sttel, m.sthablar1, ;
              m.vendedor1, m.larti1, m.tvend1, m.vendedor2, m.larti2, ;
              m.tvend2, m.vendedor3, m.larti3, m.tvend3, m.vendedor4, ;
              m.larti4, m.tvend4, m.vendedor5, m.larti5, m.tvend5, ;
              m.saldo_actu, m.saldo_usd, m.vigente

        * Inicialización de variables locales con datos del DTO.
        m.codigo = toDto.obtener('codigo')
        m.nombre = toDto.obtener('nombre')
        m.direc1 = toDto.obtener('direc1')
        m.direc2 = toDto.obtener('direc2')
        m.ciudad = toDto.obtener('ciudad')
        m.telefono = toDto.obtener('telefono')
        m.fax = toDto.obtener('fax')
        m.e_mail = toDto.obtener('e_mail')
        m.ruc = toDto.obtener('ruc')
        m.dias_plazo = toDto.obtener('dias_plazo')
        m.dueno = toDto.obtener('dueno')
        m.teldueno = toDto.obtener('teldueno')
        m.gtegral = toDto.obtener('gtegral')
        m.telgg = toDto.obtener('telgg')
        m.gteventas = toDto.obtener('gteventas')
        m.telgv = toDto.obtener('telgv')
        m.gtemkg = toDto.obtener('gtemkg')
        m.telgm = toDto.obtener('telgm')
        m.stecnico = toDto.obtener('stecnico')
        m.stdirec1 = toDto.obtener('stdirec1')
        m.stdirec2 = toDto.obtener('stdirec2')
        m.sttel = toDto.obtener('sttel')
        m.sthablar1 = toDto.obtener('sthablar1')
        m.vendedor1 = toDto.obtener('vendedor1')
        m.larti1 = toDto.obtener('larti1')
        m.tvend1 = toDto.obtener('tvend1')
        m.vendedor2 = toDto.obtener('vendedor2')
        m.larti2 = toDto.obtener('larti2')
        m.tvend2 = toDto.obtener('tvend2')
        m.vendedor3 = toDto.obtener('vendedor3')
        m.larti3 = toDto.obtener('larti3')
        m.tvend3 = toDto.obtener('tvend3')
        m.vendedor4 = toDto.obtener('vendedor4')
        m.larti4 = toDto.obtener('larti4')
        m.tvend4 = toDto.obtener('tvend4')
        m.vendedor5 = toDto.obtener('vendedor5')
        m.larti5 = toDto.obtener('larti5')
        m.tvend5 = toDto.obtener('tvend5')
        m.saldo_actu = toDto.obtener('saldo_actu')
        m.saldo_usd = toDto.obtener('saldo_usd')
        m.vigente = toDto.obtener('vigente')

        * Normalización de campos de entrada.
        * Se utiliza UPPER(ALLTRIM()) para campos alfabéticos y
        * LOWER(ALLTRIM()) para correos.
        m.nombre = UPPER(ALLTRIM(m.nombre))
        m.direc1 = UPPER(ALLTRIM(m.direc1))
        m.direc2 = UPPER(ALLTRIM(m.direc2))
        m.ciudad = UPPER(ALLTRIM(m.ciudad))
        m.telefono = UPPER(ALLTRIM(m.telefono))
        m.fax = UPPER(ALLTRIM(m.fax))
        m.e_mail = LOWER(ALLTRIM(m.e_mail))
        m.ruc = UPPER(ALLTRIM(m.ruc))
        m.dueno = UPPER(ALLTRIM(m.dueno))
        m.teldueno = UPPER(ALLTRIM(m.teldueno))
        m.gtegral = UPPER(ALLTRIM(m.gtegral))
        m.telgg = UPPER(ALLTRIM(m.telgg))
        m.gteventas = UPPER(ALLTRIM(m.gteventas))
        m.telgv = UPPER(ALLTRIM(m.telgv))
        m.gtemkg = UPPER(ALLTRIM(m.gtemkg))
        m.telgm = UPPER(ALLTRIM(m.telgm))
        m.stecnico = UPPER(ALLTRIM(m.stecnico))
        m.stdirec1 = UPPER(ALLTRIM(m.stdirec1))
        m.stdirec2 = UPPER(ALLTRIM(m.stdirec2))
        m.sttel = UPPER(ALLTRIM(m.sttel))
        m.sthablar1 = UPPER(ALLTRIM(m.sthablar1))
        m.vendedor1 = UPPER(ALLTRIM(m.vendedor1))
        m.larti1 = UPPER(ALLTRIM(m.larti1))
        m.tvend1 = UPPER(ALLTRIM(m.tvend1))
        m.vendedor2 = UPPER(ALLTRIM(m.vendedor2))
        m.larti2 = UPPER(ALLTRIM(m.larti2))
        m.tvend2 = UPPER(ALLTRIM(m.tvend2))
        m.vendedor3 = UPPER(ALLTRIM(m.vendedor3))
        m.larti3 = UPPER(ALLTRIM(m.larti3))
        m.tvend3 = UPPER(ALLTRIM(m.tvend3))
        m.vendedor4 = UPPER(ALLTRIM(m.vendedor4))
        m.larti4 = UPPER(ALLTRIM(m.larti4))
        m.tvend4 = UPPER(ALLTRIM(m.tvend4))
        m.vendedor5 = UPPER(ALLTRIM(m.vendedor5))
        m.larti5 = UPPER(ALLTRIM(m.larti5))
        m.tvend5 = UPPER(ALLTRIM(m.tvend5))
        m.vigente = UPPER(ALLTRIM(m.vigente))

        * Asignación de valores a las propiedades del objeto.
        IF !THIS.campo_establecer_valor('codigo', m.codigo) ;
                OR !THIS.campo_establecer_valor('nombre', m.nombre) ;
                OR !THIS.campo_establecer_valor('direc1', m.direc1) ;
                OR !THIS.campo_establecer_valor('direc2', m.direc2) ;
                OR !THIS.campo_establecer_valor('ciudad', m.ciudad) ;
                OR !THIS.campo_establecer_valor('telefono', m.telefono) ;
                OR !THIS.campo_establecer_valor('fax', m.fax) ;
                OR !THIS.campo_establecer_valor('e_mail', m.e_mail) ;
                OR !THIS.campo_establecer_valor('ruc', m.ruc) ;
                OR !THIS.campo_establecer_valor('dias_plazo', m.dias_plazo) ;
                OR !THIS.campo_establecer_valor('dueno', m.dueno) ;
                OR !THIS.campo_establecer_valor('teldueno', m.teldueno) ;
                OR !THIS.campo_establecer_valor('gtegral', m.gtegral) ;
                OR !THIS.campo_establecer_valor('telgg', m.telgg) ;
                OR !THIS.campo_establecer_valor('gteventas', m.gteventas) ;
                OR !THIS.campo_establecer_valor('telgv', m.telgv) ;
                OR !THIS.campo_establecer_valor('gtemkg', m.gtemkg) ;
                OR !THIS.campo_establecer_valor('telgm', m.telgm) ;
                OR !THIS.campo_establecer_valor('stecnico', m.stecnico) ;
                OR !THIS.campo_establecer_valor('stdirec1', m.stdirec1) ;
                OR !THIS.campo_establecer_valor('stdirec2', m.stdirec2) ;
                OR !THIS.campo_establecer_valor('sttel', m.sttel) ;
                OR !THIS.campo_establecer_valor('sthablar1', m.sthablar1) ;
                OR !THIS.campo_establecer_valor('vendedor1', m.vendedor1) ;
                OR !THIS.campo_establecer_valor('larti1', m.larti1) ;
                OR !THIS.campo_establecer_valor('tvend1', m.tvend1) ;
                OR !THIS.campo_establecer_valor('vendedor2', m.vendedor2) ;
                OR !THIS.campo_establecer_valor('larti2', m.larti2) ;
                OR !THIS.campo_establecer_valor('tvend2', m.tvend2) ;
                OR !THIS.campo_establecer_valor('vendedor3', m.vendedor3) ;
                OR !THIS.campo_establecer_valor('larti3', m.larti3) ;
                OR !THIS.campo_establecer_valor('tvend3', m.tvend3) ;
                OR !THIS.campo_establecer_valor('vendedor4', m.vendedor4) ;
                OR !THIS.campo_establecer_valor('larti4', m.larti4) ;
                OR !THIS.campo_establecer_valor('tvend4', m.tvend4) ;
                OR !THIS.campo_establecer_valor('vendedor5', m.vendedor5) ;
                OR !THIS.campo_establecer_valor('larti5', m.larti5) ;
                OR !THIS.campo_establecer_valor('tvend5', m.tvend5) ;
                OR !THIS.campo_establecer_valor('saldo_actu', m.saldo_actu) ;
                OR !THIS.campo_establecer_valor('saldo_usd', m.saldo_usd) ;
                OR !THIS.campo_establecer_valor('vigente', m.vigente) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_cargar()
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    */
ENDDEFINE
