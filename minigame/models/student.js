const mongoose = require("mongoose");
const student = new mongoose.Schema({
    Email:String,
    Name:String,
    Phone:String,
    Paid:Boolean,
    WalletAddr:String,
    RegisterDate:Date
});
module.exports = mongoose.model("Student", student);