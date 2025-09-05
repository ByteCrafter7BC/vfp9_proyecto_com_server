**/
* modelos.prg
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

DEFINE CLASS modelos AS modelo_base OF modelo_base.prg
    PROTECTED nMaquina
    PROTECTED nMarca

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMaquina) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMarca) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nMaquina = tnMaquina
            .nMarca = tnMarca
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_marca
        RETURN THIS.nMarca
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_maquina() != THIS.nMaquina ;
                OR toModelo.obtener_marca() != THIS.nMarca THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
