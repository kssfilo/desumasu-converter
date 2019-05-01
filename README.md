DesumasuConverter
==========

Command line filter to convert between Japanese ですます調(敬体) and である調(常体) each other.Able to use as module.

「です・ます調(敬体)」と「だ・である調（常態)」を変換するコマンドラインツールです。
標準入力から受け取った文章を標準出力に出力します。
npmモジュールとしても動作します。

## Install

```
sudo npm install -g desumasuconveter
```

## Usage

```
@PARTPIPE@|dist/cli.js -h

!!SEE NPM README!!

@PARTPIPE@
```

## Use as module

```
var DesumasuConverter=require('desumasuconveter');

desumasuConverter=new DesumasuConverter();

var text="きょうはいい天気ですね。";
var result=desumasuConverter.convert2joutai(text);
console.log(result);

//output:今日はいい天気だ。

var text2="きょうはいい天気だ。";
var result2=desumasuConverter.convert2keitai(text2);
console.log(result2);

//output:今日はいい天気です。

var result3=desumasuConverter.convert2joutai(text,{removeNe:false});
console.log(result3);
//output:今日はいい天気だね。

//See cli.coffee to know more options :)
```

## Change Log

- 0.1.x:first release

