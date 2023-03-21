using WordLists
using Test

@testset "Does not explode" begin
    @test words("english") isa Vector{String}
end

@testset "Case insensitive" begin
    @test words("english") == words("eNGliSh")
end

@testset "Non-english languages" begin
    @test words("spanish") isa Vector{String}
    @test words("portuguese") isa Vector{String}
    @test words("french") isa Vector{String}
end

@testset "Aliases" begin
    @test words("english") == words("en") == words("eng")
    @test words("spanish") == words("es") == words("spa") == words("español")
    @test words("portuguese") == words("pt") == words("por") == words("português")
    @test words("french") == words("fr") == words("fre") == words("fra") == words("français")
end

@testset "Duplicate removal" begin
    @test words("english") == words("english", "en", "eng")
end

@testset "All" begin
    @test words("english") ⊆ words("english"; all=true)
    @test length(words("english")) < length(words("english"; all=true))
    @test words("spanish") == words("spanish"; all=true) # handle missing extra.txt
    @test words("portuguese") == words("portuguese"; all=true)
    @test words("french") == words("french"; all=true)
end

@testset "Multilingual" begin
    @test words("en") ⊊ words("english", "spanish", "portuguese","french")
end

@testset "Error messages" begin
    @test_throws ArgumentError("No languages specified. Try `words(\"español\")`.") words()
    @test_throws ArgumentError("Unknown language code: foo") words("foo")
end

@testset "Content" begin
    @testset "Formatting" begin
		for langs in [("english",), ("spanish",), ("portuguese",), ("french",), ("english", "spanish", "portuguese","french")], all in [false, true]
            list = words(langs...; all)
            @test issorted(list)
            @test !any(word -> any(isspace, word), list) # No word contains whitespace
            @test allunique(list)
        end
    end

    @testset "English Content" begin
        en = words("en")
        aen = words("en"; all=true)

        @test "hello" ∈ en
        @test "cookie" ∈ en
        @test "cookiemonster" ∉ en
        @test "supercalifragilisticexpialidocious" ∉ en
        @test "ljkaflkj" ∉ en

        @testset "All" begin
            @test "hello" ∈ aen
            @test "cookie" ∈ aen
            @test "cookiemonster" ∈ aen
            @test "supercalifragilisticexpialidocious" ∈ aen
            @test "ljkaflkj" ∉ aen
        end

        @testset "length" begin
            @test 100_000 < length(en) < length(aen) < 1_000_000
        end
    end

    @testset "Spanish Content" begin
        es = words("es")
        for word in ["a", "ser", "estar", "hola", "bienvenidos", "levántate", "pelota",
            "cabezas", "idioma", "español"]
            @test word ∈ es
        end
        for word in ["levantate", "hi", "orange", "pear", "lkfjakljf", "the", "of",
            "and", "to", "it", "with", "for", "on", "his", "that", "this", "have", "from",
            "by", "was", "were", "são", "estão"]
            @test word ∉ es
        end
    end

    @testset "Portuguese Content" begin
        pt = words("pt")

        @test "a" ∈ pt
        @test "ser" ∈ pt
        @test "estar" ∈ pt
        @test "bola" ∈ pt
        @test "bem" ∈ pt
        @test "levantar" ∈ pt
        @test "levantate" ∉ pt
        @test "hi" ∉ pt
        @test "orange" ∉ pt
        @test "pear" ∉ pt
        @test "lkfjakljf" ∉ pt
    end

	@testset "French Content" begin
        fr = words("fr")
        for word in ["merci","français","fille","garçon","beau","belle","jour",
					 "demain","amour","pas","je","ne","plus","petit","grand",
					 "désolé","comme","son","il","était","sur","sont","avec"]
            @test word ∈ fr
        end
        for word in ["levantate", "hi", "pear", "lkfjakljf", "the", "of",
            "and", "to", "it", "with", "his", "that", "this", "from",
            "by", "was", "were", "são", "estão"]
            @test word ∉ fr
        end
    end
end
