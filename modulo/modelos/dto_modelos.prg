**/
* dto_modelos.prg
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

DEFINE CLASS dto_modelos AS dto_base OF dto_base.prg
    PROTECTED nMaquina
    PROTECTED nMarca

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF PARAMETERS() != 5 THEN
            tnCodigo = 0
            tcNombre = ''
            tnMaquina = 0
            tnMarca = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_maquina(tnMaquina) ;
                OR !THIS.establecer_marca(tnMarca) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              GETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_marca
        RETURN THIS.nMarca
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              SETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION establecer_maquina
        LPARAMETERS tnMaquina

        IF VARTYPE(tnMaquina) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nMaquina = tnMaquina
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_marca
        LPARAMETERS tnMarca

        IF VARTYPE(tnMarca) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nMarca = tnMarca
    ENDFUNC
ENDDEFINE
