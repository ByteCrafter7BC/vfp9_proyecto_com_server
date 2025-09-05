**/
* familias.prg
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

DEFINE CLASS familias AS modelo_base OF modelo_base.prg
    PROTECTED nP1
    PROTECTED nP2
    PROTECTED nP3
    PROTECTED nP4
    PROTECTED nP5

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnP1, tnP2, tnP3, tnP4, tnP5, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnP1) != 'N' ;
                OR VARTYPE(tnP2) != 'N' ;
                OR VARTYPE(tnP3) != 'N' ;
                OR VARTYPE(tnP4) != 'N' ;
                OR VARTYPE(tnP5) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nP1 = tnP1
            .nP2 = tnP2
            .nP3 = tnP3
            .nP4 = tnP4
            .nP5 = tnP5
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p1
        RETURN THIS.nP1
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p2
        RETURN THIS.nP2
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p3
        RETURN THIS.nP3
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p4
        RETURN THIS.nP4
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p5
        RETURN THIS.nP5
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_p1() != THIS.nP1 ;
                OR toModelo.obtener_p2() != THIS.nP2 ;
                OR toModelo.obtener_p3() != THIS.nP3 ;
                OR toModelo.obtener_p4() != THIS.nP4 ;
                OR toModelo.obtener_p5() != THIS.nP5 THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
