import json
import os
import osproc
import strutils
import sequtils

# TODO: Does not support spaces in paths yet!

let
    jsonFilename = joinPath(getAppDir(), "nimcache", "compile_gumbo_parser.json")
    jsonNode = parseJson(readFile(jsonFilename))
    linkCmdOrig = getStr(jsonNode["linkcmd"])
    linkCmdPartsOrig = splitWhitespace(linkCmdOrig)
    linkCmdParts = filter(linkCmdPartsOrig) do (x: string) -> bool:
        let (_, base, ext) = splitFile(x)
        not(ext == ".o" and (startsWith(base, "stdlib_") or
                             endsWith(base, "compile_gumbo_parser")))
    command = linkCmdParts[0]
    args = linkCmdParts[1..^1]

removeFile("libcompile_gumbo_parser.a")

discard execProcess(command, args, nil, {poEchoCmd, poUsePath})

moveFile("libcompile_gumbo_parser.a", "libgumbo_parser.a")
