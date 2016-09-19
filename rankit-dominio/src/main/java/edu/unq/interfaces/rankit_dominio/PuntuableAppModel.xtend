package edu.unq.interfaces.rankit_dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import java.util.Date

@Observable
@Accessors

abstract class PuntuableAppModel implements GenericaAppModel {
	val Puntuable miPuntuableNull = new PuntuableNull
	Usuario usuarioLogeado
	AdmPuntuables administradorDePuntuables
	AdmCalificaciones administradorCalificacion
	Puntuable itemSeleccionado = miPuntuableNull
	String nombreBuscado
	boolean habilitadoItemBusqueda=true
	
	new(AdmPuntuables adm1, AdmCalificaciones adm2, Usuario usuarioLogeado) {
		this.administradorDePuntuables = adm1
		this.administradorCalificacion = adm2
		this.usuarioLogeado = usuarioLogeado

	}
	@Dependencies("hayItemSeleccionado")
	def void  setItemSeleccionado(Puntuable seleccionado){
		itemSeleccionado = seleccionado
		verificarSiTieneNombreAsignado
		
	}
	@Dependencies("itemSeleccionado")
	def boolean getHayItemSeleccionado() {
		!itemSeleccionado.esIgual(miPuntuableNull)
	}
	
    @Dependencies("itemSeleccionado")  
	def boolean  getHayItemSeleccionadoConNombre(){
		!itemSeleccionado.isNoTieneNombre
	}
	
	override void nuevo() {
		var puntuable = new Puntuable
		administradorDePuntuables.agregar(puntuable)
		avisarCambios
	}
    @Dependencies("itemSeleccionado")
	def int getRatingPromedio() {
		administradorCalificacion.ratingPromedio(itemSeleccionado)
	}
    @Dependencies("itemSeleccionado")
	def int getCantidadDeCalificacionesDelPuntuable() {
		administradorCalificacion.cantidadDeCalificacionesDelPuntuable(itemSeleccionado)
	}
	
    @Dependencies("itemSeleccionado,hayItemSeleccionado")
	def void setHabilitado(boolean bool) {
		itemSeleccionado.habilitado = bool
		ObservableUtils.firePropertyChanged(this,"habilitado",habilitado)
		avisarCambios
	}


	def Date getFechaDeRegistro() {
		itemSeleccionado.fechaDeRegistro
	}
    @Dependencies("itemSeleccionado")
	def String getNombre() {
		itemSeleccionado.nombre
	}

    @Dependencies("itemSeleccionado")
	def boolean getHabilitado() {
		itemSeleccionado.habilitado
	}
    @Dependencies("itemSeleccionado")
   def void setNombre(String nombreNuevo){
   	    verificarSiHayDuplicados(nombreNuevo)
   	    itemSeleccionado.nombre=nombreNuevo
   	    verificarSiTieneNombreAsignado
   	    ObservableUtils.firePropertyChanged(this,"nombre",nombre)

   }

	def void verificarSiHayDuplicados(String nombre) {
		administradorDePuntuables.verificarSiHayDuplicados(nombre)
	}
	

	def int getInscriptos() {
		administradorDePuntuables.inscriptos
	}
	
	def int getHabilitados() {
		administradorDePuntuables.habilitados
	}


	def int getDeshabilitados() {
		administradorDePuntuables.deshabilitados
	}


	def void verificarSiTieneNombreAsignado() {
		itemSeleccionado.verificarSiTieneNombre
	}
	
	def List<Puntuable> getElementos() {
		administradorDePuntuables.buscar(nombreBuscado)
	}
    @Dependencies("itemSeleccionado")
	override void eliminar() {
		administradorDePuntuables.eliminar(itemSeleccionado)
		itemSeleccionado = miPuntuableNull
		avisarCambios()
	}
	
	def void avisarCambios() {
		ObservableUtils.firePropertyChanged(this, "inscriptos", inscriptos)
		ObservableUtils.firePropertyChanged(this, "habilitados", habilitados)
		ObservableUtils.firePropertyChanged(this, "deshabilitados", deshabilitados)
		ObservableUtils.firePropertyChanged(this, "elementos", elementos)
		ObservableUtils.firePropertyChanged(this, "labelValor1", labelValor1)
		ObservableUtils.firePropertyChanged(this, "labelValor2", labelValor2)
		ObservableUtils.firePropertyChanged(this, "labelValor3", labelValor3)
	}
	
	override String getLabelNombre1()

	override String getLabelValor1()

	override String getLabelNombre2()

	override String getLabelValor2()

	override String getLabelNombre3()

	override String getLabelValor3()

	override String getLabelNombre4()

	override String getLabelValor4()
	
	override String tituloContenedorBusqueda()
	
	override String textoPrimerParametroDeBusqueda()
	
	override String getPrimerParametroDeBusqueda()
	
	override String textoSegundoParametroDeBusqueda()
	
	override String getSegundoParametroDeBusqueda()
	
	override AdapterCalificacionAppModel getElementosNecesariosParaAdmCalificacionWindow()
	
	
	
}