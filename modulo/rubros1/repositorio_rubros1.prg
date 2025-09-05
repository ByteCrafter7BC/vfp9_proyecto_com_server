**/
* repositorio_rubros1.prg
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

#INCLUDE 'constantes.h'

DEFINE CLASS repositorio_rubros1 AS repositorio_base OF repositorio_base.prg
    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'rubro == ' + ALLTRIM(STR(tnCodigo))

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            lcCondicionFiltro = STRTRAN(lcCondicionFiltro, '==', '=')
        ENDIF

        IF !llRelacionado THEN
            llRelacionado = ;
                repositorio_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC
ENDDEFINE
