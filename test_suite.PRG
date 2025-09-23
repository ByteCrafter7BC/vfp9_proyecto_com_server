/**
 * Clase base para la suite de pruebas unitarias.
 * Proporciona métodos de afirmación y un reporte de resultados.
 */
DEFINE CLASS test_suite AS Custom
    PROTECTED nTestsRun
    PROTECTED nTestsPassed
    PROTECTED nTestsFailed

    FUNCTION Init
        THIS.nTestsRun = 0
        THIS.nTestsPassed = 0
        THIS.nTestsFailed = 0
    ENDFUNC

    FUNCTION RunTest(tcTestName, tlResult)
        THIS.nTestsRun = THIS.nTestsRun + 1
        ? 'Prueba: ' + ALLTRIM(STR(THIS.nTestsRun)) + ' | ' + tcTestName
        IF tlResult THEN
            THIS.nTestsPassed = THIS.nTestsPassed + 1
            ? 'Resultado: PASÓ ?'
        ELSE
            THIS.nTestsFailed = THIS.nTestsFailed + 1
            ? 'Resultado: FALLÓ ?'
        ENDIF
    ENDFUNC

    FUNCTION AssertEqual(txExpected, txActual, tcMessage)
        LOCAL tlResult
        tlResult = (txExpected == txActual)
        IF !tlResult THEN
            ? '   > Fallo: ' + tcMessage
            ? '   > Esperado: ' + TRANSFORM(txExpected)
            ? '   > Obtenido: ' + TRANSFORM(txActual)
        ENDIF
        RETURN tlResult
    ENDFUNC

    FUNCTION AssertTrue(tlValue, tcMessage)
        RETURN THIS.AssertEqual(.T., tlValue, tcMessage)
    ENDFUNC

    FUNCTION AssertFalse(tlValue, tcMessage)
        RETURN THIS.AssertEqual(.F., tlValue, tcMessage)
    ENDFUNC
ENDFUNC
