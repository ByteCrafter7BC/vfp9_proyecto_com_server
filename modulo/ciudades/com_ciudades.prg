**/
* com_ciudades.prg
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

DEFINE CLASS com_ciudades AS com_base OF com_base.prg OLEPUBLIC
    cModelo = 'ciudades'

    **--------------------------------------------------------------------------
    FUNCTION nombre_existe(tcNombre AS String, tnDepartamen AS Integer) ;
            AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el nombre existe u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.nombre_existe(tcNombre, tnDepartamen)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION sifen_existe(tnSifen AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el c�digo del SIFEN existe u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.sifen_existe(tnSifen)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre(tcNombre AS String, tnDepartamen AS Integer) ;
            AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si el nombre existe; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_nombre(tcNombre, tnDepartamen)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_sifen(tnSifen AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si el c�digo del SIFEN existe; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_sifen(tnSifen)
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

        LOCAL lnCodigo, lcNombre, lnDepartamen, lnSifen, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnDepartamen = .obtener_departamen()
            lnSifen = .obtener_sifen()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnDepartamen, lnSifen, llVigente)
    ENDFUNC
ENDDEFINE
