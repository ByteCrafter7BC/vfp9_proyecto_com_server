**/
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
* @file cerrar_dbf.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Cierra una tabla DBF previamente abierta en el entorno de trabajo.
*
* Valida que el nombre de la tabla sea una cadena no vac�a. Si la tabla est�
* abierta, se cierra utilizando el comando USE IN. Si la tabla no est� abierta
* o el par�metro es inv�lido, no se realiza ninguna acci�n.
*
* @param string tcTabla Nombre de la tabla (sin extensi�n .dbf) o alias que se
*                       desea cerrar.
* @return bool .T. si el par�metro es v�lido (independientemente de si la
*              tabla estaba abierta).
*              .F. si el par�metro es inv�lido (tipo incorrecto o cadena
*              vac�a).
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar si un valor es una cadena de caracteres y su longitud
*       est� dentro de un rango espec�fico.
* @example
*     cerrar_dbf('clientes') && Cierra la tabla clientes.dbf si est� abierta.
*/
FUNCTION cerrar_dbf
    LPARAMETERS tcTabla

    IF PARAMETERS() != 1 OR !es_cadena(tcTabla) THEN
        RETURN .F.
    ENDIF

    IF USED(tcTabla) THEN
        USE IN (tcTabla)
    ENDIF
ENDFUNC
