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

**/
* Registra un error en la tabla de errores del sistema.
*
* Valida que los par�metros sean cadenas no vac�as. Si la tabla regerror.dbf
* no existe, intenta crearla mediante crear_tabla(). Luego abre la conexi�n,
* inserta el registro con la fecha actual y los datos del error, y finalmente
* cierra la conexi�n.
*
* @param Character tcClase    Nombre de la clase donde ocurri� el error.
* @param Character tcMetodo   Nombre del m�todo donde ocurri� el error.
* @param Character tcMensaje  Descripci�n del mensaje de error.
*
* @return Logical  .T. si el error fue registrado correctamente.
*                  .F. si los par�metros son inv�lidos o no se pudo abrir la
*                  conexi�n.
*
* @example
*     registrar_error('cliente', 'guardar', ;
*         'No se pudo conectar a la base de datos.')
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

**/
* Abre la tabla regerror.dbf en modo compartido.
*
* Si el archivo no existe, intenta crearlo mediante crear_tabla().
* Luego abre la tabla en el entorno de trabajo.
*
* @return Logical  .T. si la tabla fue abierta correctamente.
*                  .F. si no se pudo crear o abrir la tabla.
*
* @example
*     abrir_conexion() && Prepara la tabla regerror.dbf para escritura.
*/
FUNCTION abrir_conexion
    IF !FILE('regerror.dbf') THEN
        IF !crear_tabla() THEN
            RETURN .F.
        ENDIF
    ENDIF

    USE regerror IN 0 SHARED
ENDFUNC

**/
* Cierra la tabla regerror.dbf si est� abierta.
*
* Verifica si la tabla est� en uso y la cierra del entorno de trabajo.
*
* @return Logical  .T. siempre que se ejecute correctamente.
*
* @example
*     cerrar_conexion() && Libera la tabla regerror.dbf del entorno.
*/
FUNCTION cerrar_conexion
    IF USED('regerror') THEN
        USE IN regerror
    ENDIF
ENDFUNC

**/
* Crea la tabla regerror.dbf con los campos necesarios para registrar errores.
*
* Si el archivo ya existe, no realiza ninguna acci�n. Si no existe, lo crea
* con los campos fecha, clase, metodo y mensaje.
*
* @return Logical  .T. si la tabla fue creada correctamente.
*                  .F. si el archivo ya existe o hubo un error en la creaci�n.
*
* @example
*     crear_tabla() && Crea la tabla regerror.dbf si no existe.
*/
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
