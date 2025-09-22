**/
* dao_dbf_marcas1.prg
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

#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_marcas1 AS dao_dbf OF dao_dbf.prg
    **/
    * @method esta_relacionado
    *
    * @purpose Verificar si un código está siendo referenciado/utilizado en
    *          otras tablas del sistema antes de permitir su eliminación
    *          o modificación.
    *
    * @access public
    *
    * @param tnCodigo {Numeric} Código a verificar por dependencias/referencias.
    *
    * @return {Logical} .T. si el código está relacionado/referenciado
    *                       (no se puede eliminar).
    *                   .F. si el código no tiene referencias
    *                       (se puede eliminar).
    *                   .T. también en caso de error de parámetro.
    *
    * @description Esta función previene la eliminación de registros que están
    *              siendo utilizados en otras partes del sistema (integridad
    *              referencial).
    *              Verifica referencias específicamente en la tabla 'maesprod'.
    *
    * @use Típicamente se usa antes de operaciones DELETE para prevenir
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
