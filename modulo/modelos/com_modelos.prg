**/
* com_modelos.prg
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

DEFINE CLASS com_modelos AS com_base OF com_base.prg OLEPUBLIC
    cModelo = 'modelos'

    **--------------------------------------------------------------------------
    FUNCTION existe_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.existe_nombre(tcNombre, tnMaquina, tnMarca)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_nombre(tcNombre, tnMaquina, ;
            tnMarca)
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnMaquina = .obtener_maquina()
            lnMarca = .obtener_marca()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente)
    ENDFUNC
ENDDEFINE
