const express = require('express');
const helmet = require('helmet');
const multer = require('multer');
const bodyParser = require('body-parser');
const jsonfile = require('jsonfile');
let port = 7222;
const file = './data.json';

let app = express();
// app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.post('/', (req, rep)=> {
    console.log(req);
    rep.send("hihi");
});

app.post('/posts/get',(req, rep)=>{
    console.log(req);
    jsonfile.readFile(file, (err, obj)=> {

        console.log(obj);
        rep.send(obj);
    });

});

app.post('/posts/save',(req, rep)=>{
    console.log("receiving data : ", req.body);
    
    var ptr = jsonfile.readFileSync(file);
    
    console.log("each old data :");
    for (let i in ptr) 
    {
        console.log(ptr[i]);
    }
    ptr.push({ "name" : req.body["name"], "age" : req.body["age"] });
    console.log("save data is ",ptr);

    jsonfile.writeFile(file, ptr, function (err) {
        if (err) {
            console.error(err);
        }
    });
    
    rep.send("save data...");
});

app.listen(port, ()=>{
    console.log("Server listen on port", port);
});