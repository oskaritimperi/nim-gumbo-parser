import json
import os
import osproc
import strutils
import sequtils
import pegs

let gumboHeader = getAppDir() / "gumbo-parser" / "src" / "gumbo.h"
let tmpFile = getAppDir() / "gumbo.nim.tmp"
let outputFile = getAppDir() / "gumbo.nim"

let dynlibPeg = peg"','\s*'dynlib: DYNLIB'"

let args = [
    "--skipinclude",
    "--skipcomments",
    "--dynlib:DYNLIB",
    "--out:" & tmpFile,
    "--debug",
    gumboHeader
]

echo(execProcess("c2nim", args, nil, {poEchoCmd, poUsePath}))

transformFile(tmpFile, outputFile, [(pattern: dynlibPeg, repl: "")])

removeFile(tmpFile)
