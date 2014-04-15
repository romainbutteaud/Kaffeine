# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(document).on('click', '#register-button', ( ->
		$('#register-button').attr('disabled', 'disabled')
		$('.info').fadeOut(1)
		$('#loader').removeClass('hide')
		name = $('#register-input').val()
		$.ajax '/register',
		type: 'POST'
		data:
			name: name
		error: (jqXHR) ->
			$('#register-button').removeAttr('disabled')
			$('#loader').addClass('hide')
			$('#failure').fadeIn()
		success: (data, textStatus, jqXHR) ->
			$('#register-button').removeAttr('disabled')
			$('#loader').addClass('hide')
			if jqXHR.status == 201
				$('#already').fadeIn()
			else
				$('#success').fadeIn()
	))