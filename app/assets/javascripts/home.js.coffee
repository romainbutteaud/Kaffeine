# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(document).on('click', '#register', ( ->
		$('.info').fadeOut()
		$('#loader').removeClass('hide')
		regex = /^[a-zA-Z0-9\-]+$/
		name = $('#register-input').val().toLowerCase().trim();
		if (regex.test(name))
			$('#register-input').removeClass('regex-error')
			ga('send', 'event', 'Registration', 'Name', name)
			$.ajax '/register',
			type: 'POST'
			data:
				name: name
			error: (jqXHR) ->
				ga('send', 'event', 'Registration', 'Error')
				$('#loader').addClass('hide')
				$('#failure').delay( 100).fadeIn()
			success: (data, textStatus, jqXHR) ->
				$('#loader').addClass('hide')
				if jqXHR.status == 201
					ga('send', 'event', 'Registration', 'Already')
					$('#already').fadeIn()
				else
					ga('send', 'event', 'Registration', 'Success')
					$('#success').fadeIn()
		else
			ga('send', 'event', 'Error', 'Name', name)
			$('#loader').addClass('hide')
			$('#failure-name').fadeIn()
			$('#register-input').addClass('regex-error')
	))
