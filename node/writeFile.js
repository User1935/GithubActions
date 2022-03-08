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
fs.writeFileSync('./node/tempfile.md', process.env.FILE_OUTPUT);