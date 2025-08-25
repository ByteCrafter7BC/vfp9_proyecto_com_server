**/
* registrar_error.prg
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

FUNCTION registrar_error
    LPARAMETERS tcClase, tcMetodo, tcMensaje

    * inicio { validaciones de par�metros }
    IF VARTYPE(tcClase) != 'C' OR VARTYPE(tcMetodo) != 'C' ;
            OR VARTYPE(tcMensaje) != 'C' THEN
        RETURN .F.
    ENDIF

    IF EMPTY(tcClase) OR EMPTY(tcMetodo) OR EMPTY(tcMensaje) THEN
        RETURN .F.
    ENDIF
    * fin { validaciones de par�metros }

    IF !abrir_conexion() THEN
        RETURN .F.
    ENDIF

    INSERT INTO regerror VALUES (DATETIME(), tcClase, tcMetodo, tcMensaje)

    cerrar_conexion()
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION abrir_conexion
    IF !FILE('regerror.dbf') THEN
        IF !crear_tabla() THEN
            RETURN .F.
        ENDIF
    ENDIF

    USE regerror IN 0 SHARED
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION cerrar_conexion
    IF USED('regerror') THEN
        USE IN regerror
    ENDIF
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION crear_tabla
    IF FILE('regerror.dbf') THEN
        RETURN .F.
    ENDIF

    CREATE TABLE regerror ( ;
        fecha T(10), ;
        clase V(254), ;
        metodo V(254), ;
        mensaje V(254) ;
    )
    USE
ENDFUNC
