LOCAL loTestSuite
loTestSuite = NEWOBJECT('test_com_marcas2_', 'test_com_marcas2_.prg')

IF VARTYPE(loTestSuite) != 'O' THEN
    ? "ERROR: No se pudo crear la suite de pruebas."
    RETURN
ENDIF

? 'Iniciando pruebas de com_marcas2...'
? REPLICATE('=', 40)

loTestSuite.TestExistencia()
loTestSuite.TestVigencia()
loTestSuite.TestRelacion()

? REPLICATE('=', 40)
? 'Total de Pruebas: ' + ALLTRIM(STR(loTestSuite.obtener_total_pruebas()))
? 'Pruebas Exitosas: ' + ALLTRIM(STR(loTestSuite.obtener_pruebas_exitosas()))
? 'Pruebas Fallidas: ' + ALLTRIM(STR(loTestSuite.obtener_pruebas_fallidas()))

IF loTestSuite.obtener_pruebas_fallidas() > 0 THEN
    WAIT WINDOW NOWAIT 'La suite de pruebas contiene fallos.'
ELSE
    WAIT WINDOW NOWAIT '¡Todas las pruebas pasaron!'
ENDIF

RELEASE loTestSuite