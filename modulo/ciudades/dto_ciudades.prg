**/
* dto_ciudades.prg
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

DEFINE CLASS dto_ciudades AS dto_base OF dto_base.prg
    PROTECTED nDepartamen
    PROTECTED nSifen

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF PARAMETERS() != 5 THEN
            tnCodigo = 0
            tcNombre = ''
            tnDepartamen = 0
            tnSifen = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_departamen(tnDepartamen) ;
                OR !THIS.establecer_sifen(tnSifen) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              GETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_sifen
        RETURN THIS.nSifen
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              SETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION establecer_departamen
        LPARAMETERS tnDepartamen

        IF VARTYPE(tnDepartamen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_sifen
        LPARAMETERS tnSifen

        IF VARTYPE(tnSifen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nSifen = tnSifen
    ENDFUNC
ENDDEFINE
