package edu.unq.interfaces.rankit_dominio

import org.uqbar.commons.model.UserException

class UsuarioInvalidoException extends UserException {
	
	new(String message) {
		super(message)
	}
	
}