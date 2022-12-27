var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = WordLists","category":"page"},{"location":"#WordLists","page":"Home","title":"WordLists","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for WordLists.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [WordLists]","category":"page"},{"location":"#WordLists.WordLists","page":"Home","title":"WordLists.WordLists","text":"A module containing the function words.\n\njulia> words(\"english\")\n257874-element Vector{String}:\n \"Aani\"\n \"Aaron\"\n \"Aaronic\"\n ⋮\n \"zymurgy\"\n \"zythem\"\n \"zythum\"\n\n\n\n\n\n","category":"module"},{"location":"#WordLists.words-Tuple{Vararg{AbstractString}}","page":"Home","title":"WordLists.words","text":"words(languages...; all)\n\nList the words in a language as a sorted Vector{String}.\n\nThe lists are incomplete and their exact contents are subject to change. Setting all=true will make an effort to include all words, but at the cost of including some non-words.\n\nLanguages can be queried by iso code, name, or english name and are not case sensitive.\n\nThe following languages are currently supported:\n\nEnglish: \"english\", \"eng\", \"en\"\nSpanish: \"spanish\", \"español\", \"spa\", \"es\"\n\nMultilingual lists are supported. For example, words(\"english\", \"spanish\") will return a sorted list containing words from both English and Spanish.\n\nExamples\n\njulia> words(\"english\")\n257874-element Vector{String}:\n \"Aani\"\n \"Aaron\"\n \"Aaronic\"\n ⋮\n \"zymurgy\"\n \"zythem\"\n \"zythum\"\n\njulia> words(\"es\", \"en\")\n257874-element Vector{String}:\n \"Aani\"\n \"Aaron\"\n \"Aaronic\"\n ⋮\n \"útero\"\n \"útil\"\n \"útiles\"\n\njulia> rand(words(\"EnGLiSH\", \"EspañoL\"; all=true), 6)\n6-element Vector{String}:\n \"Upham\"\n \"asentir\"\n \"butcher\"\n \"fireworm\"\n \"cirrolite\"\n \"revocable\"\n\n\n\n\n\n","category":"method"}]
}