**/
* dao.prg
*
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
* Clase abstracta que implementa la interfaz.
*/

DEFINE CLASS dao AS interfaz_dao OF interfaz_dao.prg
    PROTECTED cModelo
    PROTECTED nAnchoCodigo
    PROTECTED nAnchoNombre

    PROTECTED cSqlOrder
    PROTECTED cSqlSelect

    PROTECTED cUltimoError

    **/
    * @method obtener_ultimo_error
    *
    * @purpose Obtener el último mensaje de error registrado en el objeto.
    *
    * @access public
    *
    * @return {Character} Mensaje de error o cadena vacía si no hay error.
    *
    * @description Esta función retorna de forma segura el contenido de la
    *              propiedad cUltimoError del objeto actual. Verifica que la
    *              propiedad exista y sea del tipo carácter antes de
    *              retornarla, previniendo errores de tipo de variable o
    *              propiedad no existente.
    */
    FUNCTION obtener_ultimo_error
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION obtener_nombre_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tcModelo')
        ENDIF

        IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 0, 9999) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
        ENDIF

        IF tnCodigo == 0 THEN
            RETURN SPACE(0)
        ENDIF

        LOCAL lcNombre
        lcNombre = dao_obtener_nombre(tcModelo, tnCodigo)

        IF EMPTY(lcNombre) THEN
            RETURN NO_EXISTE
        ENDIF

        RETURN lcNombre
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_codigo_referencial
        LPARAMETERS tcModelo, tnCodigo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        LOCAL lnMinimo, lnMaximo
        lnMinimo = 1
        lnMaximo = 9999

        DO CASE
        CASE INLIST(tcModelo, 'cobrador', 'depar', 'maquinas', 'mecanico', ;
                'vendedor')
            lnMaximo = 999
        CASE INLIST(tcModelo, 'barrios', 'ciudades', 'sifen')
            lnMaximo = 99999
        CASE INLIST(tcModelo, 'maquinas', 'marcas2')
            lnMinimo = 0
        ENDCASE

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, lnMinimo, lnMaximo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tnCodigo_Valid
        LPARAMETERS tnCodigo

        IF VARTYPE(tnCodigo) != 'N' ;
                OR !BETWEEN(tnCodigo, 1, THIS.nAnchoCodigo) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcNombre_Valid
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' OR EMPTY(tcNombre) ;
                OR LEN(tcNombre) > THIS.nAnchoNombre THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tlVigente_Valid
        LPARAMETERS tlVigente
        RETURN VARTYPE(tlVigente) == 'L'
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION toModelo_Valid
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.cModelo) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tnCodigo_Valid(toModelo.obtener_codigo()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tcNombre_Valid(toModelo.obtener_nombre()) THEN
            RETURN .F.
        ENDIF

        IF !THIS.tlVigente_Valid(toModelo.esta_vigente()) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcCondicionFiltro_Valid
        LPARAMETERS tcCondicionFiltro

        IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) ;
                OR LEN(tcCondicionFiltro) > 150 THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION tcOrden_Valid
        LPARAMETERS tcOrden

        IF VARTYPE(tcOrden) != 'C' OR EMPTY(tcOrden) ;
                OR !INLIST(tcOrden, 'codigo', 'nombre') THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
