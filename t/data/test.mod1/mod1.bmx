SuperStrict

'Module test.mod2
Module test.mod1
ModuleInfo "Name: test.mod1"
ModuleInfo "Description: some description"
ModuleInfo "Version: 1.1.15"
ModuleInfo "License: MIT"
ModuleInfo "Author: Christiaan Kras"
ModuleInfo "History: 1.1.15"
ModuleInfo "History: foo bar"
ModuleInfo "History: 1.1.14"
ModuleInfo "History: baz"
ModuleInfo "History: foo bar baz"

Framework brl.basic
Import htbaapub.rest
Import brl.retro
'Import pub.zlib
Rem
	Import pub.lua
	Import pub.enet
	Import "test.bmx"
	Include "test2.bmx"
end rem

Include "inc/more_imports.bmx"
Import "inc/other_imports.bmx"
'This include will be ignored by Maximus::Class::Lexer
Include "src/*.h"
