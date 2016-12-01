#!/bin/bash
set -e
#set -x

read -p "please input the path for your component(current dir with no input)>" path
path=${path:-./}

read -p "please input the component name >" name
name=${name:-testComponent}

read -p "please input the style name, eg, order-status >" styleName
styleName=${styleName:-${name}}

echo "creating component $name in $path with style $styleName...";

jsTemplate="var m = require('m-react');
var cn = require('utils/m/className');
require('css/./index.css');

module.exports = m.createComponent({

  render(props, state) {

    return m('.$styleName', [

    ]);
  }
});";

scssTemplate=".$styleName {

}";

specTemplate="var m = require('m-react');
var Header = require('components/header');
var $name = require('./index');

module.exports = m.createComponent({
  title: '组件测试页：$name',

  render(props, state) {
  
    return m('.test-page', [

      m(Header, {title: this.title}),

      m('.hl-separator'),
      
      $name({

      })
    ]);
  }
})"

$(cd $path && mkdir $name) && echo "create dir $name succeed" || (echo "create dir $name failed"; exit 1)

$(cd $path && cd $name && touch index.js && touch index.scss && touch spec.js && echo -e "$jsTemplate" > index.js && echo -e "$scssTemplate" > index.scss && echo -e "$specTemplate" > spec.js) && echo "congratuations! create a $name component with spec succeed" || $(echo "whoops! create $name component failed";rm -rf $name;exit 1)
