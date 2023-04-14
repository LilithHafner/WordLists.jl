"""
A module containing the function `words`.

```julia-repl
julia> words("english")
257874-element Vector{String}:
 "Aani"
 "Aaron"
 "Aaronic"
 ⋮
 "zymurgy"
 "zythem"
 "zythum"
```
"""
module WordLists

export words

"""
    words(languages...; all)

List the words in a language as a sorted `Vector{String}`.

The lists are incomplete and their exact contents are subject to change. Setting `all=true`
will make an effort to include all words, but at the cost of including some non-words.

Languages can be queried by iso code, name, or english name and are not case sensitive.

The following languages are currently supported:

- English: "english", "eng", "en"
- Spanish: "spanish", "español", "spa", "es"
- Portuguese: "portuguese", "português", "por", "pt"
- French: "french", "français", "fre", "fr"
- Italian: "italian", "italiano", "ita", "it"

Multilingual lists are supported. For example, `words("english", "spanish")` will return a
sorted list containing words from both English and Spanish.

# Examples

```julia-repl
julia> words("english")
257874-element Vector{String}:
 "Aani"
 "Aaron"
 "Aaronic"
 ⋮
 "zymurgy"
 "zythem"
 "zythum"

julia> words("es", "en")
257874-element Vector{String}:
 "Aani"
 "Aaron"
 "Aaronic"
 ⋮
 "útero"
 "útil"
 "útiles"

julia> rand(words("EnGLiSH", "EspañoL"; all=true), 6)
6-element Vector{String}:
 "Upham"
 "asentir"
 "butcher"
 "fireworm"
 "cirrolite"
 "revocable"
```
"""
function words(languages::AbstractString...; all=false)
    isempty(languages) && throw(ArgumentError("No languages specified. Try `words(\"español\")`."))
    lists = Vector{String}[]
    content = joinpath(dirname(@__DIR__), "lists")
    for language in languages
        lower_language = lowercase(language)
        lower_language ∈ keys(LOOKUP_TABLE) || throw(ArgumentError("Unknown language code: $language"))
        lang = LOOKUP_TABLE[lower_language]
        push!(lists, readlines(joinpath(content, lang, "words.txt")))
        extra_file = joinpath(content, lang, "extra.txt")
        all && isfile(extra_file) && push!(lists, readlines(extra_file))
    end
    combine_sorted!(lists)
end

const LOOKUP_TABLE = Dict(
    "english" => "en",
    "eng" => "en",
    "en" => "en",
    "spanish" => "es",
    "español" => "es",
    "spa" => "es",
    "es" => "es",
    "portuguese" => "pt",
    "português" => "pt",
    "por" => "pt",
    "pt" => "pt",
    "french" => "fr",
    "français" => "fr",
    "fre" => "fr",
    "fra" => "fr",
    "fr" => "fr",
    "italian" => "it",
    "italiano" => "it",
    "ita" => "it",
    "it" => "it"
)

function combine_sorted!(lists::AbstractVector{<:AbstractVector})
    while length(lists) > 1
        sort!(lists; by=length, rev=true)
        b = pop!(lists)
        merge!(last(lists), b)
    end
    unique!(only(lists))
end

function merge!(a::AbstractVector, b::AbstractVector)
    i, j = lastindex(a), lastindex(b)
    resize!(a, length(a) + length(b))
    k = lastindex(a)
    while i >= firstindex(a) && j >= firstindex(b)
        if a[i] > b[j]
            a[k] = a[i]
            i -= 1
        else
            a[k] = b[j]
            j -= 1
        end
        k -= 1
    end

    while i < k
        a[k] = b[j]
        k -= 1
        j -= 1
    end

    a
end

end
