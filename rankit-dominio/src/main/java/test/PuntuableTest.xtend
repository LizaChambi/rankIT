package test

import edu.unq.interfaces.rankit_dominio.Puntuable
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*;
import org.uqbar.commons.model.UserException
import edu.unq.interfaces.rankit_dominio.PuntuableNull

class PuntuableTest {
	    var Puntuable lugar1
	    var Puntuable lugar2
	    var Puntuable lugar3
	    var Puntuable servicio1
	    var Puntuable servicio2
	    var Puntuable servicio3
	    
	 @Before 
	 def void setUp(){
	 	 lugar1=new Puntuable
	 	 lugar2=new Puntuable
	 	 lugar3=new Puntuable
	 	 servicio2=new Puntuable
	 	 servicio3=new Puntuable
	 }
	 /** En este test pruebo que cuando creo un nuevo servicio 
	  * este no tiene nombre 
	  * 
	  * */
	 
	 @Test(expected=UserException)
	 def void testUnServicioCreadoNoTieneNombre(){
	 	servicio1=new Puntuable
	    servicio1.verificarSiTieneNombre
	 	
	 }
	 
	 /**
	  * En este test pruebo que cuando a un lugar creado le cambio el 
	  * nombre, este tiene un nombre asignado
	  */
	  
	  @Test
	  def lugarConNombreAsignado(){
	  	 lugar2.nombre="Yona"
	  	 lugar2.verificarSiTieneNombre
	  }
	 
	 
	 @Test
	 /**
	  * En este test pruebo si un lugar 
	  * tiene un nombre que paso como parametro  
	  *
	  */
	  def testUnLugarTieneElNombreFreddo(){
	  	 lugar1.nombre="Freddo"
	  	 assertTrue(lugar1.tieneElNombre("Freddo"))
	
	  }
	    
	 @Test
	 /**
	  * En este test pruebo que un servicio no tiene el 
	  * nombre que le paso como parametro
	  */
	  def testUnServicioNoTieneElNombreMetrogas(){
	  	servicio3.nombre="Edesur"
	  	assertFalse(servicio3.tieneElNombre("Edenor"))
	  }
	  
	  @Test
	  def lugarHabilitado(){
	  	  lugar1.habilitado = true
	  	  assertTrue(lugar1.habilitado)
	  }
	  
	  @Test 
	  def testPrueboSiUnPuntuablesEsIgualAOtro(){
	  	  lugar1.nombre="Yona"
	  	  lugar2.nombre="Yona"
	  	  assertTrue(lugar1.esIgual(lugar2))
	  }
	  
	  @Test
	  def testPrueboQueUnPuntuableNoEsIgualAOtro(){
	  	servicio2.nombre="Metrogas"
	  	assertFalse(servicio2.esIgual(new PuntuableNull))
	  }
}