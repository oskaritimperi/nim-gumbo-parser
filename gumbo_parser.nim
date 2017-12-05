include gumbo_parser / gumbo

type
    CArray {.unchecked.} [T] = array[0..0, T]

template len*(vector: var GumboVector): int =
    vector.length.int

iterator values*[T](vector: var GumboVector): T =
    let arr = cast[ptr CArray[T]](vector.data)
    for idx in 0..len(vector)-1:
        yield arr[idx]

iterator children*(document: var GumboDocument): ptr GumboNode =
    for child in values[ptr GumboNode](document.children):
        yield child

iterator children*(element: var GumboElement): ptr GumboNode =
    for child in values[ptr GumboNode](element.children):
        yield child

iterator children*(node: ptr GumboNode): ptr GumboNode =
    case node.`type`
    of GumboNodeDocument:
        for child in children(node.v.document):
            yield child
    of GumboNodeElement:
        for child in children(node.v.element):
            yield child
    else:
        discard

iterator attributes*(element: var GumboElement): ptr GumboAttribute =
    for attribute in values[ptr GumboAttribute](element.attributes):
        yield attribute
