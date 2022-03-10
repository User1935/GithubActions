const fs = require('fs');
const TurndownService = require("turndown");
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

fs.readFile(process.env.FILE_INPUT, "utf8", function(err, data) {
    var turndownService = new TurndownService({
        bulletListMarker: "*",
        codeBlockStyle: "fenced",
        linkStyle: "referenced"
    })
    turndownService.remove('style')
    var markdown = turndownService.turndown(data)
    fs.writeFileSync(process.env.FILE_OUTPUT, markdown);
});
