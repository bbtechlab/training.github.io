var student = require("../models/student");

module.exports = function(app) {
    app.get("/", function(req, res) {
        res.render("minigame_layout.ejs");
    });

    app.post("/register", function(req,res){
        if(!req.body.Email || !req.body.Name || !req.body.Phone) {
            res.json({Result:0, ErrorCode:"You didn't fills correct information"});
        } else {
            var newStudent = new student ({
                Email:req.body.Email,
                Name:req.body.Name,
                Phone:req.body.Phone,
                Paid:false,
                WalletAddr:null,
                RegisterDate:Date.now()
            });
            newStudent.save(function(err) {
                if (err) {
                    res.json({Result:0, ErrorCode:"Can not save newStudent to MongoDB"});
                } else {
                    res.json({Result:1, newStudent:newStudent});
                }
            });
        }
    });    
}