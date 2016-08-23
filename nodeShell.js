#!/usr/bin/env node
var path = require('path');
var fs = require('fs');

fs.readFile('/home/zhunian/Documents/learning/shellScript/testResult','utf8',  function (err, data) {
  if (err) throw err;
    console.log(data);
});
