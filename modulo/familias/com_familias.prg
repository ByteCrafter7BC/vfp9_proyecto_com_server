DEFINE CLASS com_familias AS com_base OF com_base.prg OLEPUBLIC
    cModelo = 'familias'

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnP1 = .obtener_p1()
            lnP2 = .obtener_p2()
            lnP3 = .obtener_p3()
            lnP4 = .obtener_p4()
            lnP5 = .obtener_p5()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente)
    ENDFUNC
ENDDEFINE
