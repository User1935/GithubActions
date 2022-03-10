const fs = require('fs');

/*
fs.writeFile("/tmp/test", process.env.FILE_OUTPUT , function(err) {
    if(err) {
        return console.log(err);
    }
    console.log("The file was saved!");
}); 
*/

// Or
//let buff = new Buffer.from(process.env.FILE_INPUT, 'base64');
//let text = buff.toString('utf8');
// changed FIlE_OUPUT TO INPUT
fs.writeFileSync(process.env.FILE_OUTPUT, process.env.FILE_INPUT);