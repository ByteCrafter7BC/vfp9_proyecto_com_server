**/
* repositorio_obtener_por_codigo.prg
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

#INCLUDE 'constantes.h'

FUNCTION repositorio_obtener_por_codigo
    LPARAMETERS tcModelo, tnCodigo

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN 'ERROR: ' + STRTRAN(PARAM_INVALIDO, '{}', 'tcModelo')
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 1, INT_MAX) THEN
        RETURN 'ERROR: ' + STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
    ENDIF

    LOCAL loRepositorio, lcRepositorio
    loRepositorio = crear_repositorio(tcModelo)

    IF VARTYPE(loRepositorio) != 'O' THEN
        lcRepositorio = 'repositorio_' + tcModelo

        IF VARTYPE(_SCREEN.oConexion) == 'O' THEN
            lcRepositorio = 'odbc_' + lcRepositorio
        ENDIF

        RETURN 'ERROR: ' + STRTRAN(ERROR_INSTANCIA_CLASE, '{}', lcRepositorio)
    ENDIF

    RETURN loRepositorio.obtener_por_codigo(tnCodigo)
ENDFUNC
