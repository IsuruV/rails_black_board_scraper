loginClicked = ()=>{
    $(document).on('click','#login',(ev)=>{
        ev.target.innerHTML = `<div class="ui active inverted dimmer">
    <div class="ui indeterminate text loader">Authenticating with BlackBoard</div>
  </div>
  <p></p>`;
    })
}

$(document).ready(()=>{
    loginClicked();
})

// <div class="ui active centered inline loader"></div>