# gumbo_parser

A wrapper for the gumbo html5 parser library.

# Build

Before installing the library, you need to build the static library yourself.
This is due to current limitations in nimble. Building has been mostly automated
and can be achieved with the following command:

    $ nimble buildlib

This will compile and link gumbo as a static library and place it in
`gumbo_parser` directory.

If you need to regenerate the wrapper, you can issue the following command which
will use c2nim to do most of the work:

    $ nimble generatebinding

This will place the generated `gumbo.nim` file in the `gumbo_parser` directory.

# Install

Make sure you have read the *build* section above.

After building, you can install the library using nimble:

    $ nimble install
