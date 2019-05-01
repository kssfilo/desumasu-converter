class DesumasuConverter
	constructor:->
		@dict=[
			['しましょう','しよう']
			['きましょう','こう']
			['りましょう','ろう']
			['出来ました','出来た']
			['できました','できた']
			['出来ます','出来る']
			['できます','できる']
			['あります','ある']
			['なります','なる']
			['きました','くる']
			['ませんが','ないが']
			['でしょう','だろう']
			['りません','らない']
			['みました','みた']
			['ましょう','よう']
			['でした','だった']
			['ですが','だが']
			['います','いる']
			['かります','かる']
			['えました','えた']
			['いいです','いい']
			['ないです','ない']
			['無いです','無い']
			['れます','れる']
			['きます','くる']
			['します','する']
			['します','する']
			['ません','ない']
			['ていた','いた']
			['ました','た',true]
			['ります','る',true]
			['ます','る']
			['です','だ']
		]

		@seperator='。、（）\(\)'

	convert2joutai:(input,options={})->
		options.toJotai=true
		@convert(input,options)

	convert2keitai:(input,options={})->
		options.toJotai=false
		@convert(input,options)

	convert:(input,options={})->
		{toJotai=true,checkNe=true,removeNe=false}=options
		l=0
		r=1
		if !toJotai
			r=0
			l=1
		t=input

		tempDict=Array.from @dict
		tempDict.sort (a,b)->
			if toJotai then  b[0].length-a[0].length
			else  b[1].length-a[1].length

		for i in tempDict
			if !toJotai and i[2] then continue
			left="(#{i[l]})([#{@seperator}])"
			right="#{i[r]}$2"
			t=t.replace(new RegExp(left,'gm'),right)
			if checkNe
				neLeft="(#{i[l]}ね)([#{@seperator}])"
				rightRep=if removeNe then "" else "ね"
				neRight="#{i[r]}#{rightRep}$2"
				t=t.replace(new RegExp(neLeft,'gm'),neRight)

		output=t
		return output

module.exports=DesumasuConverter
