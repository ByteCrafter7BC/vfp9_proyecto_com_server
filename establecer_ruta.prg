establecer_entorno()
establecer_ruta()

**/
* Establece los comandos SET apropiados para el entorno de ejecución.
*/
FUNCTION establecer_entorno
    CLEAR
    CLEAR ALL
    CLOSE ALL
    CLOSE DATABASES
    CLOSE TABLES

    SET CENTURY ON
    SET DATE BRITISH
    SET DELETED ON
    SET EXACT ON
    SET HOURS TO 24
    SET POINT TO ','
    SET PROCEDURE TO
    SET SEPARATOR TO '.'
ENDFUNC

**/
* Establecer rutas de proyecto.
*/
FUNCTION establecer_ruta
    LOCAL lcSys16, lcPrograma, lcRuta, lcRutaPrevia

    lcSys16 = SYS(16)
    lcPrograma = SUBSTR(lcSys16, AT(':', lcSys16) - 1)
    lcRuta = JUSTPATH(lcPrograma)
    lcRutaPrevia = SUBSTR(lcRuta, 1, RAT('\', lcRuta))

    SET DEFAULT TO (lcRuta)
    SET PATH TO bd, ;
                biblioteca, ;
                binario, ;
                img\bmp, ;
                img\ico, ;
                menu, ;
                modulo\barrio, ;
                modulo\ciudad, ;
                modulo\depar, ;
                modulo\familia, ;
                modulo\maquinas, ;
                modulo\marcas1, ;
                modulo\marcas2, ;
                modulo\modelos, ;
                modulo\pais, ;
                modulo\rubro, ;
                modulo\subrubro, ;
                modulo\zona, ;
                prog
*                C:\turtle\aya\integrad.000
ENDFUNC
