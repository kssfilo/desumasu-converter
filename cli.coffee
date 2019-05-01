#!/usr/bin/env coffee

DesumasuConverter=require('./desumasuconverter')

opt=require 'getopt'
debugConsole=null
command='keitai2joutai'
removeNe=true
checkNe=true

readline=require('readline').createInterface
	input:process.stdin

T=console.log
E=console.error

appName=require('path').basename process.argv[1]

opt.setopt 'hdjknN'
opt.getopt (o,p)->
	switch o
		when 'h','?'
			command='usage'
		when 'd'
			debugConsole=console.error
		when 'j'
			command='keitai2joutai'
		when 'k'
			command='joutai2keitai'
		when 'n'
			checkNe=true
			removeNe=false
		when 'N'
			checkNe=false

switch command
	when 'usage'
		pjson=require './package.json'
		version=pjson.version ? '-'

		console.log """
		#{appName} [<options>]
		version #{version}
		Copyright(c) 2019,kssfilo(https://kanasys.com/tech/)

		「です・ます調(敬体)」と「だ・である調（常態)」を変換します。 標準入力から受け取った文章を標準出力に出力します。

		オプション:
			-d:デバッグ出力(現在未使用)
			-j:「です・ます調(敬体)」を「だ・である調（常態)」に変換します(デフォルト)
			-k:「だ・である調（常態)」を「です・ます調(敬体)」に変換します
			-n: 語尾の「ね。」を削除しません。
			-N: 語尾に「ね。」がある場合は変換しません。(-nとは併用不可)

		注意点:
			句読点、。と括弧()を区切りとして認識します。行末は区切りとして認識しませんので注意してください。

		例:
			>cat example.txt
			今日は晴れてます。
			明日は曇りでしょうね。
			
			>cat example.txt | #{appName} -j
			今日は晴れている。
			明日は曇りだろう。

			>cat example.txt | #{appName} -jn
			今日は晴れている。
			明日は曇りだろうね。
			
			>cat example.txt | #{appName} -jN
			今日は晴れている。
			明日は曇りでしょうね。

			>cat example2.txt
			今日は休みだ。
			明日も休みだろう。

			>cat example.txt | #{appName} -k
			今日は晴れています。
			明日は曇りでしょう。
		"""
		process.exit 0
	else
		inputLines=[]

		readline.on 'line',(line)->inputLines.push line
		readline.on 'close',->
			kjc=new DesumasuConverter()
			if command=='keitai2joutai'
				r=kjc.convert2joutai(inputLines.join("\n"),{checkNe:checkNe,removeNe:removeNe})
			else
				r=kjc.convert2keitai(inputLines.join("\n"),{checkNe:checkNe,removeNe:removeNe})

			process.stdout.write r

