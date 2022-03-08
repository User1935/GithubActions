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
let buff = new Buffer.from(process.env.FILE_OUTPUT, 'base64');
let text = buff.toString('utf8');
fs.writeFileSync('./node/tempfile.md', text);