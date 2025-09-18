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

**/
* Registra un error en la tabla de errores del sistema.
*
* Valida que los parámetros sean cadenas no vacías. Si la tabla regerror.dbf
* no existe, intenta crearla mediante crear_tabla(). Luego abre la conexión,
* inserta el registro con la fecha actual y los datos del error, y finalmente
* cierra la conexión.
*
* @param Character tcClase    Nombre de la clase donde ocurrió el error.
* @param Character tcMetodo   Nombre del método donde ocurrió el error.
* @param Character tcMensaje  Descripción del mensaje de error.
*
* @return Logical  .T. si el error fue registrado correctamente.
*                  .F. si los parámetros son inválidos o no se pudo abrir la
*                  conexión.
*
* @example
*     registrar_error('cliente', 'guardar', ;
*         'No se pudo conectar a la base de datos.')
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
* Cierra la tabla regerror.dbf si está abierta.
*
* Verifica si la tabla está en uso y la cierra del entorno de trabajo.
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
* Si el archivo ya existe, no realiza ninguna acción. Si no existe, lo crea
* con los campos fecha, clase, metodo y mensaje.
*
* @return Logical  .T. si la tabla fue creada correctamente.
*                  .F. si el archivo ya existe o hubo un error en la creación.
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
