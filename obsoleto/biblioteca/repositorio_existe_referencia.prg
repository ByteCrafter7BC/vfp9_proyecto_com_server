**/
* repositorio_existe_referencia.prg
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

FUNCTION repositorio_existe_referencia
    LPARAMETERS tcModelo, tcCondicionFiltro

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN .T.
    ENDIF

    IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) THEN
        RETURN .T.
    ENDIF

    LOCAL loRepositorio
    loRepositorio = crear_repositorio(LOWER(ALLTRIM(tcModelo)))

    IF VARTYPE(loRepositorio) != 'O' THEN
        RETURN .T.
    ENDIF

    RETURN loRepositorio.contar(tcCondicionFiltro) != 0
ENDFUNC
