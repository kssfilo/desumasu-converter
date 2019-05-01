#!/usr/bin/env bats

@test "Jotai" {
	[ "$(cat test/t1-s.txt|dist/cli.js -j|tr \"\\n\" 'X' )" = "$(cat test/t2-s.txt|tr \"\\n\" 'X' )" ]
}

@test "Keitai" {
	[ "$(cat test/t2-s.txt|dist/cli.js -k|tr \"\\n\" 'X' )" = "$(cat test/t2-r.txt|tr \"\\n\" 'X' )" ]
}

@test "Jotai-n" {
	[ "$(cat test/t1-s.txt|dist/cli.js -n|tr \"\\n\" 'X' )" = "$(cat test/t3-r.txt|tr \"\\n\" 'X' )" ]
}

@test "Jotai-N" {
	[ "$(cat test/t1-s.txt|dist/cli.js -N|tr \"\\n\" 'X' )" = "$(cat test/t4-r.txt|tr \"\\n\" 'X' )" ]
}

