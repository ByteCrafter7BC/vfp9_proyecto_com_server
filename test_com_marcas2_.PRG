/**
 * Suite de pruebas para la clase de negocio 'com_marcas2'.
 */
DEFINE CLASS test_com_marcas2 AS test_suite OF test_suite.prg
    PROTECTED oCom
    
    FUNCTION Init
        DODEFAULT()  && Llama al Init de la clase padre
        THIS.oCom = NEWOBJECT('com_marcas2', 'com_marcas2.prg')
    ENDFUNC
    
    FUNCTION TearDown
        RELEASE THIS.oCom
    ENDFUNC

    FUNCTION TestExistencia()
        LOCAL lcMsg
        lcMsg = 'Método: existe_codigo | Valor: 3'
        THIS.RunTest(lcMsg, THIS.AssertTrue(THIS.oCom.existe_codigo(3), 'Debe existir el código 3'))
        
        lcMsg = 'Método: existe_codigo | Valor: 888'
        THIS.RunTest(lcMsg, THIS.AssertFalse(THIS.oCom.existe_codigo(888), 'No debe existir el código 888'))
        
        lcMsg = "Método: existe_nombre | Valor: 'husqvarna'"
        THIS.RunTest(lcMsg, THIS.AssertTrue(THIS.oCom.existe_nombre('husqvarna'), "Debe existir el nombre 'husqvarna'"))
        
        lcMsg = "Método: existe_nombre | Valor: 'monark'"
        THIS.RunTest(lcMsg, THIS.AssertFalse(THIS.oCom.existe_nombre('monark'), "No debe existir el nombre 'monark'"))
    ENDFUNC
    
    FUNCTION TestVigencia()
        LOCAL lcMsg
        lcMsg = 'Método: esta_vigente | Valor: 3'
        THIS.RunTest(lcMsg, THIS.AssertTrue(THIS.oCom.esta_vigente(3), 'El código 3 debe estar vigente'))
        
        lcMsg = 'Método: esta_vigente | Valor: 888'
        THIS.RunTest(lcMsg, THIS.AssertFalse(THIS.oCom.esta_vigente(888), 'El código 888 no debe estar vigente'))
    ENDFUNC
    
    FUNCTION TestRelacion()
        LOCAL lcMsg
        lcMsg = 'Método: esta_relacionado | Valor: 3'
        THIS.RunTest(lcMsg, THIS.AssertTrue(THIS.oCom.esta_relacionado(3), 'El código 3 debe estar relacionado'))
        
        lcMsg = 'Método: esta_relacionado | Valor: 888'
        THIS.RunTest(lcMsg, THIS.AssertFalse(THIS.oCom.esta_relacionado(888), 'El código 888 no debe estar relacionado'))
    ENDFUNC
ENDFUNC
