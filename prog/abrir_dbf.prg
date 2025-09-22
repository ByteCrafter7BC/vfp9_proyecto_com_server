**/
* abrir_dbf.prg
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
* Abre un archivo DBF ubicado en la carpeta definida por CARPETA_DATOS.
*
* Esta funci�n valida los par�metros recibidos, construye la ruta completa
* del archivo y lo abre en modo compartido. Si el archivo ya est� abierto,
* no realiza ninguna acci�n.
* Si el archivo no existe, se registra un error mediante la funci�n
* registrar_error().
*
* @param string tcTabla Nombre de la tabla (sin extensi�n .dbf) que se desea
*                       abrir.
*
* @param bool [tlModoEscritura] Indica si se abre en modo escritura (.T.) o solo
*                               lectura (.F.).
*                               Si no se especifica correctamente, se asume .F.
*
* @return bool .T. si el archivo fue abierto correctamente o ya estaba abierto.
*              .F. si hubo error en los par�metros o el archivo no existe.
*
* @throws error Se invoca registrar_error() si el archivo no existe en la ruta
*               especificada.
*
* @example
*     abrir_dbf('clientes', .T.) && Abre clientes.dbf en modo escritura.
*     abrir_dbf('productos') && Abre productos.dbf en modo solo lectura.
*/
#DEFINE CARPETA_DATOS    'C:\turtle\aya\integrad.000\'

FUNCTION abrir_dbf
    LPARAMETERS tcTabla, tlModoEscritura

    * inicio { validaciones de par�metros }
    IF VARTYPE(tcTabla) != 'C' OR EMPTY(tcTabla) THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tlModoEscritura) != 'L' THEN
        tlModoEscritura = .F.
    ENDIF
    * fin { validaciones de par�metros }

    LOCAL lcDbf
    lcDbf = ADDBS(CARPETA_DATOS) + tcTabla + '.dbf'

    IF !USED(tcTabla) THEN
        IF !FILE(lcDbf) THEN
            registrar_error('abrir_dbf', 'abrir_dbf', ;
                "Archivo '" + lcDbf + "' no existe.")
            RETURN .F.
        ENDIF

        IF !tlModoEscritura THEN
            USE (lcDbf) IN 0 SHARED NOUPDATE
        ELSE
            USE (lcDbf) IN 0 SHARED
        ENDIF
    ENDIF
ENDFUNC
