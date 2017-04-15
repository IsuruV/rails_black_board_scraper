//= require cable
//= require_self
//= require_tree .



// 'turbolinks:load'

$(document).on('ready', function() {
  submitNewMessage();
  establishConnection();
});


function establishConnection(){
  this.App = {};

  this.App.cable = ActionCable.createConsumer("/cable");
    if (App.cable.subscriptions['subscriptions'].length > 1) {
    App.cable.subscriptions.remove(App.cable.subscriptions['subscriptions'][1])
  };
  establishMessage(App);
}

function establishMessage(App){
  App.messages = App.cable.subscriptions.create('ClassChatChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden')
    return $('#messages').append(this.renderMessage(data));
  },
  renderMessage: function(data) { 
    let currentRoomId = parseInt($('#classroom_id').val())
    if(currentRoomId == data.message_room_id){
      return "<p> <b>" + data.user.username + ": </b>" + data.message + "</p>";
    }
  }
});

}


function submitNewMessage(){
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
        $('[data-send="message"]').click();
        $('[data-textarea="message"]').val(" ")
        return false;
     }
  });
}



