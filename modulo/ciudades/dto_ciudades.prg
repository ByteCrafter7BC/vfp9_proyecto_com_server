**/
* dto_ciudades.prg
*
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
