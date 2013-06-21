function init() {
	console.log('Init')
  socket = io.connect("http://localhost", {port: 8000, transports: ["websocket"]});
  setEventHandlers();
};


var setEventHandlers = function() {
  socket.on("connect", onSocketConnected);
  socket.on("wasup", onWasup);
};

var onSocketConnected = function() {
  socket.emit("new client");
};

var onWasup = function(data) {
	console.log('wasup')
	$("#info ul").append('<li>' + data.wasup + '</li>');
}

function setFlipHandlers() {
  $("div.board-game-container").on('click','div.card-container', function(e) { 
    e.preventDefault();
    var card = $(this)
    if (card.attr('data') == 'flipped') {
      card.revertFlip().attr('data','');
    } else {
      card.flip({
        direction:'bt',
        color:'black',
        content: 'none',
        speed: 'fast'
      }).attr('data','flipped');
    }
  });
}




$('document').ready(function() {
	console.log('Ready')
  // init();
  setFlipHandlers();
});


$("#flipbox").flip({
  direction:'tb',
  content:'this is my new content'
})
