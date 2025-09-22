**/
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
* @file constantes.h
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @see https://github.com/harbour/core/blob/master/include/inkey.ch
*/

**/
* Archivo de cabecera que contiene constantes para la aplicación.
*/

*/ Misc. keys.
#DEFINE K_ENTER     13          && Enter, Ctrl-M
#DEFINE K_INTRO     CHR(13)
#DEFINE K_RETURN    K_INTRO     && Return, Ctrl-M
#DEFINE K_SPACE     CHR(32)     && Space bar
#DEFINE K_ESC       27          && Esc, Ctrl-[

*/ Editing keys.
#DEFINE K_INS       CHR(22)     && Ins, Ctrl-V
#DEFINE K_DEL       CHR(7)      && Del, Ctrl-G
#DEFINE K_BS        CHR(127)    && Backspace, Ctrl-H
#DEFINE K_TAB       9           && Tab, Ctrl-I
#DEFINE K_SH_TAB    CHR(15)     && Shift-Tab

*/ Function keys.
#DEFINE K_F1        28          && F1, Ctrl-Backslash
#DEFINE K_F2        -1          && F2
#DEFINE K_F3        -2          && F3
#DEFINE K_F4        -3          && F4
#DEFINE K_F5        -4          && F5
#DEFINE K_F6        -5          && F6
#DEFINE K_F7        -6          && F7
#DEFINE K_F8        -7          && F8
#DEFINE K_F9        -8          && F9
#DEFINE K_F10       -9          && F10
#DEFINE K_F11       -40         && F11
#DEFINE K_F12       -41         && F12

*/ File I/O.
#DEFINE CRLF        CHR(13) + CHR(10)
#DEFINE CR          CHR(13)
#DEFINE LF          CHR(10)
#DEFINE TAB         CHR(9)
#DEFINE INDENT      SPACE(4)

*/ Limits of integer types.
#DEFINE UCHAR_MAX    255
#DEFINE SHRT_MAX     32767
#DEFINE USHRT_MAX    65535
#DEFINE INT_MAX      2147483647
#DEFINE UINT_MAX     4294967295
#DEFINE LONG_MAX     9223372036854775807
#DEFINE ULONG_MAX    18446744073709551615

*/ constantes_config.h
#DEFINE CARPETA_EXPORTAR 'c:\exportar\'

#DEFINE BD_DBF         1
#DEFINE BD_FIREBIRD    2
#DEFINE BD_MYSQL       3
#DEFINE BD_POSTGRES    4
#DEFINE BD_ACTUAL      BD_DBF

#DEFINE SQL_EXITO    1
#DEFINE SQL_ERROR    -1

*/ constantes_mensajes.h
#DEFINE MSG_ARCHIVO_VACIO                    'El archivo está vacío.'
#DEFINE MSG_CODIGO_MAYOR_QUE_CERO            'El código debe ser mayor que cero.'
#DEFINE MSG_ERROR_CONEXION                   'No hay conexión con la base de datos.'
#DEFINE MSG_ERROR_INSTANCIA_CLASE            "No se pudo instanciar la clase '{}'. "
#DEFINE MSG_LONGITUD_MAXIMA                  'Longitud máxima {} caracteres.'
#DEFINE MSG_LONGITUD_MINIMA                  'Longitud mínima {} caracteres.'
#DEFINE MSG_MAYOR_O_IGUAL_A_CERO             'Debe ser mayor o igual a cero.'
#DEFINE MSG_MAYOR_QUE_CERO                   'Debe ser mayor que cero.'
#DEFINE MSG_MENOR_QUE                        'Debe ser menor que {}.'
#DEFINE MSG_NO_BLANCO                        'No puede quedar en blanco.'
#DEFINE MSG_NO_BORRA_REGISTRO_RELACIONADO    'No se puede borrar el registro porque figura en otros archivos.'
#DEFINE MSG_NO_EXISTE                        'No existe.'
#DEFINE MSG_NO_VIGENTE                       "'{}' no está vigente."
#DEFINE MSG_PARAM_INVALIDO                   "El parámetro '{}' no es válido."
#DEFINE MSG_REFERENCIA_NO_EXISTE             "'{}' no existe."
#DEFINE MSG_TIPO_CARACTER                    'Debe ser de tipo caracter.'
#DEFINE MSG_TIPO_LOGICO                      'Debe ser de tipo lógico.'
#DEFINE MSG_TIPO_NUMERICO                    'Debe ser de tipo numérico.'
#DEFINE MSG_YA_EXISTE                        'Ya existe.'
