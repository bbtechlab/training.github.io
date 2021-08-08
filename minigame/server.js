var express = require("express");
var app = express();
app.use(express.static("public"));
app.set("view engine", "ejs");

var server = require("http").Server(app);
var io = require("socket.io")(server);
server.listen(3000);

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({extended:false}));

// How to connnect to MongoDB, https://mongoosejs.com/
const mongoose = require('mongoose');
mongoose.connect('mongodb+srv://bbtechlab_user1:Fq4ZIWq8oX3OXiRH@cluster0.bvabi.mongodb.net/bbtechlab_database?retryWrites=true&w=majority', {useNewUrlParser: true, useUnifiedTopology: true}, function (err) {
    if(err) {
        console.log("Error to conect MongoDB " + err);
    } else {
        console.log("Succeed to connect MongoDB ");
    }
});

require("./controllers/game")(app);