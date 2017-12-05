# Package

version       = "0.1.0"
author        = "Oskari Timperi"
description   = "Wrapper for the gumbo html5 parser library"
license       = "Apache"

requires "nim >= 0.17.2"

skipDirs = @["3rdparty", "examples"]

task buildlib, "build the gumbo-parser c library":
    withDir "3rdparty":
        exec "nim c compile_gumbo_parser.nim"
        exec "nim c -r link_gumbo_parser.nim"
    mvFile "3rdparty/libgumbo_parser.a", "gumbo_parser/libgumbo_parser.a"

task generatebinding, "generate the binding with c2nim":
    withDir "3rdparty":
        exec "nim c -r create_gumbo_wrapper.nim"
    mvFile "3rdparty/gumbo.nim", "gumbo_parser/gumbo.nim"

task buildexamples, "build examples":
    exec "nim c examples/dump.nim"
