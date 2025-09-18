**/
* repositorio_existe_referencia.prg
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
