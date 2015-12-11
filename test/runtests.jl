using graphtheoryufrj
using Base.Test

include("ratton_first_assignment.jl")

# Test the memory representation of the structures of the Graph
@test test_one() == "TEST_ONE_SUCESS"

#
@test test_two() == "TEST_TWO_SUCESS"

#
@test test_three() == "TEST_THREE_SUCESS"

#
@test test_four() == "TEST_FOUR_SUCESS"

#
@test test_five() == "TEST_FIVE_SUCESS"

#
@test test_six() == "TEST_SIX_SUCESS"

#
@test test_seven() == "TEST_SEVEN_SUCESS"