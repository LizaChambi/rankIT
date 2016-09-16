package edu.unq.interfaces.rankit_dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.Dependencies
import java.util.List

@Observable
@Accessors
class CalificacionAppModel {

	AdmCalificaciones administradorCalificacion;
	Calificacion calificacionSeleccionada;
	Usuario usuarioLogeado;
	//AdmPuntuables admPuntuables;
	
	AdmPuntuables admPuntuables=new AdmPuntuables;
	
	String nombreUsuarioBusqueda;
	String nombreEvaluadoBusqueda;
	Boolean habilitadoEvaluadoBusqueda=true;
	Boolean habilitadoUsuarioBusqueda=true;
	

	new(AdmCalificaciones calificaciones, AdmPuntuables lugares,AdmPuntuables servicios, Usuario usuario) {
		administradorCalificacion = calificaciones
		admPuntuables.puntuables.addAll( lugares.puntuables)
		admPuntuables.puntuables.addAll( servicios.puntuables)
		usuarioLogeado = usuario
	}
	new(AdmCalificaciones calificaciones,  Usuario usuario) {
		administradorCalificacion = calificaciones
		usuarioLogeado = usuario
	}
	def List<Puntuable>getPuntuables(){
		admPuntuables.puntuables
	}

	@Dependencies("calificacionSeleccionada")
	def Integer getPuntos() {
		if (hayCalificacionSeleccionada) {
			return calificacionSeleccionada.puntos
		}
		null
	}

	def void setPuntos(Integer numero) {
		var Integer valor = 0;
		if (numero != null) {
			valor = numero
		}
		calificacionSeleccionada.puntos = valor
	}

	def setNombreUsuarioBusqueda(String nombre) {
		nombreUsuarioBusqueda = nombre
		ObservableUtils.firePropertyChanged(this, "listaCalificacionesFiltradas", listaCalificacionesFiltradas)
	}

	def setNombreEvaluadoBusqueda(String nombre) {
		nombreEvaluadoBusqueda = nombre
		ObservableUtils.firePropertyChanged(this, "listaCalificacionesFiltradas", listaCalificacionesFiltradas)
	}

	def listaCalificacionesFiltradas() {
		administradorCalificacion.filtrarCalificaciones(nombreEvaluadoBusqueda, nombreUsuarioBusqueda)
	}

	def void setCalificacionSeleccionada(Calificacion calificacionSel) {
		calificacionSeleccionada = calificacionSel
		if (calificacionSel != null) {
			ObservableUtils.firePropertyChanged(this, "contenidoOfensivo", contenidoOfensivo)
		}
	}

	def Boolean getContenidoOfensivo() {
		calificacionSeleccionada.contenidoOfensivo
	}

	def void setContenidoOfensivo(Boolean bool) {
		administradorCalificacion.contenidoOfensivo(calificacionSeleccionada, bool)
		actualizarEstadoSituacion
	}

	@Dependencies("calificacionSeleccionada")
	def Boolean getHayCalificacionSeleccionada() {
		calificacionSeleccionada != null
	}

	def int getCalificacionesRegistradas() {
		administradorCalificacion.getCalificacionesRegistradas()
	}

	def int getCalificacionesOfensivas() {
		administradorCalificacion.getCalificacionesOfensivas()
	}

	def eliminarCalificacionSeleccionada() {
		administradorCalificacion.eliminarCalificacion(calificacionSeleccionada)
		actualizarEstadoSituacion
	}

	def agregarCalificacion(Calificacion nuevaCalificacion) {
		administradorCalificacion.agregarCalificacion(nuevaCalificacion)
		actualizarEstadoSituacion
	}

	def actualizarEstadoSituacion() {
		ObservableUtils.firePropertyChanged(this, "puntos", puntos)
		ObservableUtils.firePropertyChanged(this, "listaCalificacionesFiltradas", listaCalificacionesFiltradas)
		ObservableUtils.firePropertyChanged(this, "calificacionesRegistradas", calificacionesRegistradas)
		ObservableUtils.firePropertyChanged(this, "calificacionesOfensivas", calificacionesOfensivas)
	}
	
	def crearCalificacion() {
		agregarCalificacion(new Calificacion(this.usuarioLogeado))
	}
	
	def  filtradoObligatorioPorPuntuable(Puntuable puntuable) {
		admPuntuables.agregar(puntuable)
		nombreEvaluadoBusqueda = puntuable.nombre
		habilitadoEvaluadoBusqueda=false
		this
	}
	def  filtradoObligatorioPorUsuario(Usuario usuario) {
		nombreEvaluadoBusqueda = usuario.nombre
		habilitadoUsuarioBusqueda=false
		this
	}

	
}
