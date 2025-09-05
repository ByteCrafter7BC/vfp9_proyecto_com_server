**/
* com_familias.prg
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

DEFINE CLASS com_familias AS com_base OF com_base.prg OLEPUBLIC
    cModelo = 'familias'

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnP1 = .obtener_p1()
            lnP2 = .obtener_p2()
            lnP3 = .obtener_p3()
            lnP4 = .obtener_p4()
            lnP5 = .obtener_p5()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente)
    ENDFUNC
ENDDEFINE
