**/
* dao_dbf_marcas1.prg
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

DEFINE CLASS dao_dbf_marcas1 AS dao_dbf OF dao_dbf.prg
    **/
    * @method esta_relacionado
    *
    * @purpose Verificar si un c�digo est� siendo referenciado/utilizado en
    *          otras tablas del sistema antes de permitir su eliminaci�n
    *          o modificaci�n.
    *
    * @access public
    *
    * @param tnCodigo {Numeric} C�digo a verificar por dependencias/referencias.
    *
    * @return {Logical} .T. si el c�digo est� relacionado/referenciado
    *                       (no se puede eliminar).
    *                   .F. si el c�digo no tiene referencias
    *                       (se puede eliminar).
    *                   .T. tambi�n en caso de error de par�metro.
    *
    * @description Esta funci�n previene la eliminaci�n de registros que est�n
    *              siendo utilizados en otras partes del sistema (integridad
    *              referencial).
    *              Verifica referencias espec�ficamente en la tabla 'maesprod'.
    *
    * @use T�picamente se usa antes de operaciones DELETE para prevenir
    *      violaciones de integridad referencial.
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'marca == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN
            llRelacionado = ;
                dao_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC
ENDDEFINE
