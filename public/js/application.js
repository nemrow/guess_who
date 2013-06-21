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

$('document').ready(function() {
	console.log('Ready')
  init();
});