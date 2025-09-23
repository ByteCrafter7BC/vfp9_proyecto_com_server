LOCAL loTestSuite
loTestSuite = NEWOBJECT('test_com_marcas2', 'test_com_marcas2.prg')

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
? 'Total de Pruebas: ' + ALLTRIM(STR(loTestSuite.nTestsRun))
? 'Pruebas Exitosas: ' + ALLTRIM(STR(loTestSuite.nTestsPassed))
? 'Pruebas Fallidas: ' + ALLTRIM(STR(loTestSuite.nTestsFailed))

IF loTestSuite.nTestsFailed > 0 THEN
    WAIT WINDOW NOWAIT 'La suite de pruebas contiene fallos.'
ELSE
    WAIT WINDOW NOWAIT '¡Todas las pruebas pasaron!'
ENDIF

RELEASE loTestSuite