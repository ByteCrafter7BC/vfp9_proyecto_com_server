FUNCTION generar_token
    LOCAL lcDateTime, lcSys2015
    lcDateTime = TTOC(DATETIME(), 1)
    lcSys2015 = LOWER(SYS(2015))

    RETURN lcDateTime + lcSys2015
ENDFUNC
