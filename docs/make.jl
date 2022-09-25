using WordLists
using Documenter

DocMeta.setdocmeta!(WordLists, :DocTestSetup, :(using WordLists); recursive=true)

makedocs(;
    modules=[WordLists],
    authors="Lilith Hafner <Lilith.Hafner@gmail.com> and contributors",
    repo="https://github.com/LilithHafner/WordLists.jl/blob/{commit}{path}#{line}",
    sitename="WordLists.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://LilithHafner.github.io/WordLists.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/LilithHafner/WordLists.jl",
    devbranch="main",
)
