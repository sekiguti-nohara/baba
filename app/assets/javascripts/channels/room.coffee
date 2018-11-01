document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id'), user_id: $('#messages').data('user_id') },
    connected: ->
    disconnected: ->

    received: (data) ->
      if data['user_id'] == 1
      	$('#messages').prepend '<a data-method="delete" href="/message/' + data['message_id'] + '">' + '削除' + '</a>'
      	$('#messages').prepend '<p>' + data['message'] + '</p>'
      else
        $('#messages').prepend '<p>' + data['message'] + '</p>'

    speak: (message) ->
      if message != ''
        @perform 'speak', message: message

   	$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    	if event.keyCode is 13 # return = send
      	App.room.speak event.target.value
      	event.target.value = ''
      	event.preventDefault()