using Test
using UnicodeSubstitution

@testset "substitution" begin
    @test UnicodeSubstitution.substitution("\\u(2560)\\u(2563)ello World!") == "╠╣ello World!"
end

