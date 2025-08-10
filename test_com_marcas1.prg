LOCAL loRepositorio, loModelo
loRepositorio = NEWOBJECT('com_marcas1', 'com_marcas1.prg')

IF VARTYPE(loRepositorio) != 'O' THEN
    ? 'ERROR: El objeto "loRepositorio" no existe.'
    RETURN .F.
ENDIF

loModelo = loRepositorio.obtener_por_codigo(3);

IF VARTYPE(loModelo) != 'O' THEN
    ? 'ERROR: El objeto "loModelo" no existe.'
    RETURN .F.
ENDIF

? loModelo.obtener_codigo()
? loModelo.obtener_nombre()
? loModelo.esta_vigente()