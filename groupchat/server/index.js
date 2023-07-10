const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
var net = require('net');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

var clients = 0;

var activeRooms = new Map();


io.on('connection', (socket) => {

  console.log('New client connected');
  clients+=1;

  
  socket.on('total_client', (RequestData) => {
    console.log(`Total Clients: ${clients}`);
    const responseData = {
      'TotalClients': clients.toString() 
    };

    socket.emit('totalClientsCount', responseData);

  });

  socket.on('queryEvent', (data, callback) => {
    console.log('Received query:', data);
    socket.write("total clients" + clients);
    socket.emit('Total Clients: ', clients);
  });
  
  // socket.on('validRoom', (data) => {
  //   if(activeRooms.has(data['Key']))
  //   {
  //     console.log('Valid Room Id');
  //     socket.emit('validRoomKey', {'validKey': true});
  //   }
  //   else
  //   {
  //     console.log('Invalid Room Id');
  //     socket.emit('validRoomKey', {'validKey': false});
  //   }
  // });

  socket.on('create_room', (roomName) => {
    console.log(`Creating room: ${roomName}`);
    socket.join(roomName);
   // activeRooms.set(roomName,1);
    
  });

  socket.on('join_room', (roomKey) => {
    console.log(`Joining room: ${roomKey}`);
    socket.join(roomKey);
   // activeRooms[roomKey]+=1;
   
  });

  

  socket.on('send_mssg', (mssg) => {
        console.log(mssg);
        io.to(mssg["roomId"]).emit("serverMssg",{...mssg,sender:"other"});
    
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected');
    clients-=1;
  });
});

server.listen(3000, () => console.log('Listening on port 3000'));
