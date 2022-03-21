
function getInput(name, options) {
  const val = process.env[`INPUT_${name.replace(/ /g, '_').toUpperCase()}`] || '';
  if (options && options.required && !val) {
      throw new Error(`Input required and not supplied: ${name}`);
  }
  if (options && options.trimWhitespace === false) {
      return val;
  }
  return val.trim();
}

const changed_paths = getInput('changed_paths')
const command = getInput('command')

let listPaths = changed_paths.split(" ")

listPaths.forEach(list => {
  let path = list.split("/")
  if(path[path.length - 1] == "terragrunt.hcl") {
    
  }

});