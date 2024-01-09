module UnicodeSubstitution

using ReplMaker
import REPL
import REPL.LineEdit.complete_line
import REPL.LineEdit.CompletionProvider

struct UnicodeCompletionProvider <: CompletionProvider
    repl_completion_provider::CompletionProvider
end

function substitution(istr::AbstractString)
    substr = split(istr, "\\u(")
    if length(substr) == 1
        return istr
    else
        ostr = substr[1]
        for str in substr[2:end]
            m = match(r"^[0-9a-fA-F]+[)]", str)
            ostr *=
                    if m == nothing
                        "\\u(" * str
                    else
                        codepoint = m.match[1:end-1]
                        Meta.parse("\"\\u$codepoint\"") * str[length(m.match)+1:end]
                    end
        end
        return ostr
    end
end

function input_handler(inputstr)
    Main.eval(Meta.parse(substitution(inputstr)))
end

function complete_line(x::UnicodeCompletionProvider, s)
    firstpart = String(s.input_buffer.data[1:s.input_buffer.ptr-1])
    firstpartsub = substitution(firstpart)
    if firstpart != firstpartsub
        return ([firstpartsub], firstpart, true)
    else
        return complete_line(x.repl_completion_provider, s)
    end
end

function __init__()
    if !isinteractive()
        @info "Session is not interactive"
        return
    end
    initrepl(input_handler;
             prompt_text="unicode substitution> ",
             prompt_color=26,
             start_key='^',
             mode_name=:unicode_completion,
             completion_provider=UnicodeCompletionProvider(REPL.REPLCompletionProvider()))
end

end # module
