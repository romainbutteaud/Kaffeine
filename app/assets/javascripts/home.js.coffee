# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(document).on('click', '#unregister', ( ->
		$('.info').hide()
		regex = /^[a-zA-Z0-9\-]+$/
		name = $('#unregister-input').val().toLowerCase().trim();
		if name.length > 30
			ga('send', 'event', 'Error', 'Name', name)
			$('#failure-name').fadeIn()
			$('#unregister-input').addClass('regex-error')
		else if !regex.test(name)
			ga('send', 'event', 'Error', 'Name', name)
			$('#failure-regex').fadeIn()
			$('#unregister-input').addClass('regex-error')
		else if !time
			$('#loader_decaf').show()
			$('#unregister-input').removeClass('regex-error')
			ga('send', 'event', 'Unregister', 'Name', name)
			$.ajax '/decaf/',
			type: 'POST'
			data:
				name: name
				'_method': 'delete'
			error: (jqXHR) ->
				$('#loader_decaf').fadeOut()
				$('#failure').fadeIn()
				ga('send', 'event', 'Unregister', 'Error')
			success: (data, textStatus, jqXHR) ->
				$('#loader_decaf').fadeOut()
				if jqXHR.status == 201
					$('#already-removed').fadeIn()
				else
					$('#success-removed').fadeIn()
					new_count = $('#count').data('count') - 1
					$('#count').data('count', new_count)
					$('#count').fadeOut(500).fadeIn(500, ->
						$('#count').html(new_count)
						$('#count').addClass('count-change')
					)
				ga('send', 'event', 'Unregister', 'Success')
  else
   $('#loader_decaf').show()
			$('#unregister-input').removeClass('regex-error')
			ga('send', 'event', 'Unregister', 'Name', name)
			$.ajax '/decaf/',
			type: 'POST'
			data:
				name: name
				'_method': 'delete'
			error: (jqXHR) ->
				$('#loader_decaf').fadeOut()
				$('#failure').fadeIn()
				ga('send', 'event', 'Unregister', 'Error')
			success: (data, textStatus, jqXHR) ->
				$('#loader_decaf').fadeOut()
				if jqXHR.status == 201
					$('#already-removed').fadeIn()
				else
					$('#success-removed').fadeIn()
					new_count = $('#count').data('count') - 1
					$('#count').data('count', new_count)
					$('#count').fadeOut(500).fadeIn(500, ->
						$('#count').html(new_count)
						$('#count').addClass('count-change')
					)
				ga('send', 'event', 'Unregister', 'Success')
	))

	$(document).on('click', '#register', ( ->
		$('.info').hide()
		regex = /^[a-zA-Z0-9\-]+$/
    timeregex = /^[0-2][0-9]\:[0-5][0-9]/
		name = $('#register-input').val().toLowerCase().trim();
  bedtime = $('#register-time').val();
  sleep = $('#register-sleep').val();
  
  console.log "hi"
  console.log time
		if name.length > 30
			ga('send', 'event', 'Error', 'Name', name)
			$('#failure-name').fadeIn()
			$('#register-input').addClass('regex-error')
		else if !regex.test(name)
			ga('send', 'event', 'Error', 'Name', name)
			$('#failure-regex').fadeIn()
			$('#register-input').addClass('regex-error')
		else if !sleep
   console.log "sleep is false"  
			$('#loader').show()
			$('#register-input').removeClass('regex-error')
			ga('send', 'event', 'Registration', 'Name', name)
			$.ajax '/register',
			type: 'POST'
			data:
				name: name
    nap: false
    bedtime: "00:00"
			error: (jqXHR) ->
				$('#loader').fadeOut()
				$('#failure').fadeIn()
				ga('send', 'event', 'Registration', 'Error')
			success: (data, textStatus, jqXHR) ->
				$('#loader').fadeOut()
				if jqXHR.status == 201
					$('#already').fadeIn()
				else
					$('#success').fadeIn()
					new_count = $('#count').data('count') + 1
					$('#count').data('count', new_count)
					$('#count').fadeOut(500).fadeIn(500, ->
						$('#count').html(new_count)
						$('#count').addClass('count-change')
					)
				ga('send', 'event', 'Registration', 'Success')
  else if !timeregex.test(bedtime)
			ga('send', 'event', 'Error', 'Bedtime', bedtime)
			$('#failure-time-regex').fadeIn()
			$('#register-input').addClass('regex-error')
  else
   console.log "sleep is true"
			$('#loader').show()
			$('#register-input').removeClass('regex-error')
			ga('send', 'event', 'Registration', 'Name', name)
			$.ajax '/register',
			type: 'POST'
			data:
				name: name
    nap: true
    bedtime: bedtime
			error: (jqXHR) ->
				$('#loader').fadeOut()
				$('#failure').fadeIn()
				ga('send', 'event', 'Registration', 'Error')
			success: (data, textStatus, jqXHR) ->
				$('#loader').fadeOut()
				if jqXHR.status == 201
					$('#already').fadeIn()
				else
					$('#success').fadeIn()
					new_count = $('#count').data('count') + 1
					$('#count').data('count', new_count)
					$('#count').fadeOut(500).fadeIn(500, ->
						$('#count').html(new_count)
						$('#count').addClass('count-change')
					)
				ga('send', 'event', 'Registration', 'Success')
                 
	))
