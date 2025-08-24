**/
* ciudades.prg
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

DEFINE CLASS ciudades AS modelo_base OF modelo_base.prg
    PROTECTED nDepartamen
    PROTECTED nSifen

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnDepartamen) != 'N' ;
                OR VARTYPE(tnSifen) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nDepartamen = tnDepartamen
            .nSifen = tnSifen
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_sifen
        RETURN THIS.nSifen
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_departamen() != THIS.nDepartamen ;
                OR toModelo.obtener_sifen() != THIS.nSifen THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
