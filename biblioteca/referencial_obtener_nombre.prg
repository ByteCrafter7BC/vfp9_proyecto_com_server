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
* @file referencial_obtener_nombre.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Devuelve el nombre de un registro referencial a partir de su c�digo.
*
* @param string tcModelo Nombre del modelo o tabla de la que se desea
*                        obtener el nombre.
* @param int tnCodigo C�digo del registro a buscar.
* @return string Nombre del registro, mensaje de error si el par�metro es
*                inv�lido, o un mensaje de 'No existe' si el c�digo no
*                existe.
* @uses constantes.h
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses bool es_numero(string tnNumero, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses string dao_obtener_nombre(string tcModelo, int tnCodigo)
*       Para obtener el nombre de un registro espec�fico a partir de su c�digo.
*/
#INCLUDE 'constantes.h'

FUNCTION referencial_obtener_nombre
    LPARAMETERS tcModelo, tnCodigo

    IF !es_cadena(tcModelo) THEN
        RETURN STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcModelo')
    ENDIF

    IF !es_numero(tnCodigo, 0) THEN
        RETURN STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
    ENDIF

    IF tnCodigo == 0 THEN
        RETURN SPACE(0)
    ENDIF

    LOCAL lcNombre
    lcNombre = dao_obtener_nombre(tcModelo, tnCodigo)

    IF EMPTY(lcNombre) THEN
        RETURN MSG_NO_EXISTE
    ENDIF

    RETURN lcNombre
ENDFUNC
