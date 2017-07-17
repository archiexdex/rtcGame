const express = require('express');
const helmet = require('helmet');
const multer = require('multer');
const bodyParser = require('body-parser');
const jsonfile = require('jsonfile');
let fs = require('fs');
let port = 7222;
const file = './data.json';

let app = express();
// app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

// app.post('/', (req, res)=> {
//     console.log(res);
//     res.send("hihi");
// });

var createFolder = function(folder){
    try{
        fs.accessSync(folder); 
    }catch(e){
        fs.mkdirSync(folder);
    }  
};

var uploadFolder = 'uploads/';

createFolder(uploadFolder);

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, uploadFolder);    // 保存的路径，备注：需要自己创建
    },
    filename: function (req, file, cb) {
        // 将保存文件名设置为 字段名 + 时间戳，比如 logo-1478521468943
        cb(null, file.originalname );  
    }
});

var upload = multer({ storage: storage}).single('file');

// 单文件上传
app.post('/uploadImg', upload, (req,res,next) => {
    //  请求路径
    var url = global.baseURL+req.url;
    console.log(req)
    var obj = req.file;
    console.log('obj====',obj);
    var tmp_path = obj.path;
    var new_path = "public/images";
    console.log("原路径：" + tmp_path);

    /*修改上传文件地址*/
    upload(req,res,(err) => {
        if (err) {
            console.log('上传失败');
        }else{
            console.log('上传成功');
        }
    });

    // 反馈上传信息
    res.send({
        'states':'success'
    });
});


app.get('/form', function(req, res, next){
    var form = fs.readFileSync('./form.html', {encoding: 'utf8'});
    res.send(form);
});

app.use('/image',express.static('uploads'));


app.post('/posts/get',(req, res)=>{
    // console.log(req);
    jsonfile.readFile(file, (err, obj)=> {

        //console.log(obj);
        console.log(">>>>>>>>>>>>>>\,");
        res.send(obj);
    });

});

app.post('/posts/save',(req, res)=>{
    console.log("receiving data : ", req.body);
    
    var ptr = jsonfile.readFileSync(file);
    
    console.log("each old data :");
    for (let i in ptr) {
        console.log(i, ptr[i]);
    }
    ptr.push({ "userID" : req.body["userID"], 
                "time" : req.body["time"], 
                "content" : req.body["content"],
                "imagePath": req.body["imagePath"] });
    console.log("save data is ",ptr);

    jsonfile.writeFile(file, ptr,  (err) => {
        if (err) {
            //console.error(err);
            console.log("save data error!!");
        }
        else {
            res.send("save data success");
        }
    });
    
    //rep.send("save data success");
});

app.listen(port, ()=>{
    console.log("Server listen on port", port);
});
