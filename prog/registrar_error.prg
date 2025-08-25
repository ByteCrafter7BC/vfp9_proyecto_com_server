**/
* registrar_error.prg
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

FUNCTION registrar_error
    LPARAMETERS tcClase, tcMetodo, tcMensaje

    * inicio { validaciones de parámetros }
    IF VARTYPE(tcClase) != 'C' OR VARTYPE(tcMetodo) != 'C' ;
            OR VARTYPE(tcMensaje) != 'C' THEN
        RETURN .F.
    ENDIF

    IF EMPTY(tcClase) OR EMPTY(tcMetodo) OR EMPTY(tcMensaje) THEN
        RETURN .F.
    ENDIF
    * fin { validaciones de parámetros }

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
