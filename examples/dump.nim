import gumbo_parser
import strutils

let data = """
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title of the document</title>
</head>

<body>
Content of the document......
<p>a nice paragraph <b class="my-bold">with some bold text</b></p>
</body>

</html>
"""

let output = gumboParse(data)

proc dump(node: ptr GumboNode, depth: int) =
    let indent = repeat(' ', depth)
    let indent1 = repeat(' ', depth + 1)
    let indent2 = repeat(' ', depth + 2)

    echo(indent, node.`type`)

    case node.`type`
    of GumboNodeDocument:
        echo(indent1, "name: ", node.v.document.name)
        echo(indent1, "public: ", node.v.document.publicIdentifier)
        echo(indent1, "system: ", node.v.document.systemIdentifier)
        echo(indent1, "quirks: ", node.v.document.docTypeQuirksMode)
        for child in children(node.v.document):
            dump(child, depth+1)
    of GumboNodeElement:
        echo(indent1, "tag: ", gumboNormalizedTagName(node.v.element.tag))
        echo(indent1, "attributes:")
        for attribute in attributes(node.v.element):
            echo(indent2, attribute.name, ": ", attribute.value)
        for child in children(node.v.element):
            dump(child, depth+1)
    of GumboNodeText, GumboNodeCData, GumboNodeComment:
        echo(indent1, node.v.text.text)
    else: discard

dump(output.document, 0)
