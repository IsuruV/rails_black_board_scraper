//= require cable
//= require_self
//= require_tree .



// 'turbolinks:load'

$(document).on('ready', function() {
  submitNewMessage();
  establishConnection();
  updateClasses();
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
    let current_user_id = parseInt($('#current_user_id').val());
    if(currentRoomId == data.message_room_id){
        if(current_user_id === data.message.user_id){
          return `<p id="current_user_message"><strong>${data.user.username}</strong> ${data.message.content}</p>`
        }else{
          return `<p id="message"><strong>${data.user.username}</strong> ${data.message.content}</p>`
        }
  // return "<p> <b>" + data.user.name + ": </b>" + data.message.content + "</p>";
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


const updateClasses = ()=>{
  $(document).on('click','#update_classes',(ev)=>{
    $('div.classes').replaceWith(`<div class="ui segment">
  <div class="ui active inverted dimmer">
    <div class="ui large indeterminate text loader">Fetching Classes from Blackboard</div>
  </div>
  <img class="ui wireframe image" src="https://semantic-ui.com/images/wireframe/short-paragraph.png">
  <img class="ui wireframe image" src="https://semantic-ui.com/images/wireframe/short-paragraph.png">
  <img class="ui wireframe image" src="https://semantic-ui.com/images/wireframe/short-paragraph.png">
  <img class="ui wireframe image" src="https://semantic-ui.com/images/wireframe/short-paragraph.png">
  <p></p>
</div>`);

  })
}
