package edu.unq.interfaces.rankit_dominio

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Calificacion {
	private int puntos
	private Date fecha
	private boolean contenidoOfensivo
	private String detalle
	private Puntuable evaluado 
	private Usuario usuario
	
	new(Usuario usuario){
		this.contenidoOfensivo=false
		this.detalle=""
		this.fecha=new Date() 
		this.puntos=0
		this.evaluado=null
		this.usuario = usuario
	}
	
	new() {
		this.contenidoOfensivo=false
		this.detalle=""
		this.fecha=new Date() 
		this.puntos=0
		this.evaluado=null  
		  }
	
	def boolean esCalificacionOfensiva() {
		contenidoOfensivo.equals(true)
	}
	def void marcarComoContenidoOfensivo(){
	    contenidoOfensivo=true  
	}
	def boolean sinDescripcion() {
		detalle.equals("prueba")
	}
	def void darPuntosALaCalificacion(int puntos){
		this.puntos=puntos
	}
	def void indicarElDetalleDeLaCalificacion(String detalle){
		this.detalle=detalle
	}	
	def  void indicarEvaluado(Puntuable evaluado){
		this.evaluado=evaluado 
	}
	
	def isPuntuableBuscado(Puntuable puntuable) {
	    this.evaluado.nombre.equals(puntuable.nombre)
	}
	
}