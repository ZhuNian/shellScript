var stdin = process.stdin;
var stdout=process.stdout;

stdin.on('readable', function() {
  var chunk = stdin.read();
  if(chunk) {
    stdout.write('read":' + chunk.toString());
  }
});

stdin.on('end', function() {
  stdout.write('end');
});
