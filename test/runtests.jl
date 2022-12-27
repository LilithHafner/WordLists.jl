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
end

@testset "Aliases" begin
    @test words("english") == words("en") == words("eng")
    @test words("spanish") == words("es") == words("spa") == words("español")
    @test words("portuguese") == words("pt") == words("por") == words("português")
end

@testset "Duplicate removal" begin
    @test words("english") == words("english", "en", "eng")
end

@testset "All" begin
    @test words("english") ⊆ words("english"; all=true)
    @test length(words("english")) < length(words("english"; all=true))
    @test words("spanish") == words("spanish"; all=true) # handle missing extra.txt
    @test words("portuguese") == words("portuguese"; all=true)
end

@testset "issorted & !isspace" begin
    for lang in ["english", "spanish", "portuguese"], all in [false, true]
        list = words(lang; all)
        @test issorted(list)
        @test !any(word -> any(isspace, word), list) # No word contains whitespace
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

    @test "a" ∈ es
    @test "ser" ∈ es
    @test "estar" ∈ es
    @test "hola" ∈ es
    @test "bienvenidos" ∈ es
    @test "levántate" ∈ es
    @test "levantate" ∉ es
    @test "hi" ∉ es
    @test "orange" ∉ es
    @test "pear" ∉ es
    @test "lkfjakljf" ∉ es
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
