# UnicodeSubstitution

This is a small [Julia](https://julialang.org) package that enables the user
to obtain any Unicode character (that the system fonts can display) in the
Julia REPL if the [Unicode codepoint](https://codepoints.net) is known.

## Installation

In the Julia REPL type:
```julia
import Pkg
Pkg.add("https://github.com/GHTaarn/UnicodeSubstitution.jl")
```

## Use

In the Julia REPL type:
```julia
using UnicodeSubstitution
```

Hereafter, you will be able to enter "unicode substitution" mode by typing
the `^` character at the start of a line.
In "unicode substitution" mode, any pattern matching `\u(XXXX)` will be
converted to the Unicode character corresponding to `XXXX`, where `XXXX` is a
string of any length containing the hexadecimal
[Unicode codepoint](https://codepoints.net) of a valid Unicode character.

Pressing the `Backspace` key when the cursor is on the first character of a
"unicode substitution" mode line reverts back to "julia" mode while preserving
the contents of the input line.

### Examples
```julia-repl
julia> using UnicodeSubstitution
REPL mode unicode_completion initialized. Press ^ to enter and backspace to exit.

unicode substitution> println("\u(2560)\u(2563)ello World!")
╠╣ello World!

unicode substitution> println("╠\u(2563)ello World!")
╠╣ello World!

unicode substitution> println("╠╣ello World!")
╠╣ello World!

unicode substitution> println("20\u(0b0)C")
20°C

unicode substitution> println("20\u(B0)C")
20°C

unicode substitution> println("20°C")
20°C

unicode substitution> 
```

The first "unicode substitution" line shows what happens when merely pressing
`Enter` in this mode.

The second "unicode substitution" line shows what would happen if the `Tab` key
was pressed when the cursor was on the second `\` character of the first
"unicode substitution" line: The `Tab` key immediately substitutes to the left
of the cursor. Hereafter `Enter` was pressed.

The third "unicode substitution" line is what most people want: It was
initially identical to the first "unicode substitution" line, hereafter the
`Tab` key was pressed when the cursor was at the end of the line followed by
the `Enter` key.

The next two "unicode substitution" lines show that leading zeros and both
upper and lower case codepoints are allowed.

The final "unicode substitution" line shows the effect of pressing the `Tab`
key at the end of either of the previous two input lines.

Note that while any Unicode character can be entered in this way, characters
such as `°` that can be handled in "julia" mode should normally be entered in
"julia" mode as this minimises the risk of confusion with similar looking characters.

## Feedback

This is a very rough first version, so please don't report insignificant errors
like stack traces with invalid input, but if there are codepoints that do not
work or the package does not work at all, then please report it at
https://github.com/GHTaarn/UnicodeSubstitution.jl/issues or submit a pull request.

