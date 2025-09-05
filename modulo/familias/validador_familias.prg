**/
* validador_familias.prg
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

DEFINE CLASS validador_familias AS validador_base OF validador_base.prg
    PROTECTED cErrorP1
    PROTECTED cErrorP2
    PROTECTED cErrorP3
    PROTECTED cErrorP4
    PROTECTED cErrorP5

    **--------------------------------------------------------------------------
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorP1) ;
                    OR !EMPTY(THIS.cErrorP2) ;
                    OR !EMPTY(THIS.cErrorP3) ;
                    OR !EMPTY(THIS.cErrorP4) ;
                    OR !EMPTY(THIS.cErrorP5) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oRepositorio.esta_relacionado( ;
                THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_p1
        RETURN IIF(VARTYPE(THIS.cErrorP1) == 'C', THIS.cErrorP1, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_p2
        RETURN IIF(VARTYPE(THIS.cErrorP2) == 'C', THIS.cErrorP2, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_p3
        RETURN IIF(VARTYPE(THIS.cErrorP3) == 'C', THIS.cErrorP3, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_p4
        RETURN IIF(VARTYPE(THIS.cErrorP4) == 'C', THIS.cErrorP4, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_p5
        RETURN IIF(VARTYPE(THIS.cErrorP5) == 'C', THIS.cErrorP5, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar
        validador_base::validar()

        WITH THIS
            .cErrorP1 = THIS.validar_p(1)
            .cErrorP2 = THIS.validar_p(2)
            .cErrorP3 = THIS.validar_p(3)
            .cErrorP4 = THIS.validar_p(4)
            .cErrorP5 = THIS.validar_p(5)
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_p
        LPARAMETERS tnLista

        IF VARTYPE(tnLista) != 'N' OR !BETWEEN(tnLista, 1, 5) THEN
            RETURN STRTRAN(PARAM_INVALIDO, '{}', 'tnLista')
        ENDIF

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        LOCAL lcEtiqueta, lnP
        lcEtiqueta = '% ' + STR(tnLista, 1) + ': '

        lnP = EVALUATE('THIS.oModelo.obtener_p' + STR(tnLista, 1) + '()')

        IF VARTYPE(lnP) != 'N' THEN
            RETURN lcEtiqueta + TIPO_NUMERICO
        ENDIF

        IF lnP < 0 THEN
            RETURN lcEtiqueta + MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnP > 999.99 THEN
            RETURN lcEtiqueta + STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(999 + 1)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
