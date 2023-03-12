defmodule CustomAssemblerTest do
  use ExUnit.Case
  doctest CustomAssembler

  test "calculates ADD properly" do
    program_add = """
    MOV A 10
    MOV B 15
    ADD
    """

    assert ["10", "15", "25"] === CustomAssembler.run_program(program_add)

    program_another_add = """
    MOV A 9007199254740992
    MOV B 1
    ADD
    """

    assert ["9007199254740992", "1", "9007199254740993"] ===
             CustomAssembler.run_program(program_another_add)

    program_harder_add = """
    MOV A 10
    MOV B 15
    MOV A B
    ADD
    """

    assert ["15", "15", "30"] === CustomAssembler.run_program(program_harder_add)
  end

  test "calculate MUL properly" do
    program_mul = """
    MOV A 10
    MOV B 15
    MUL
    """

    assert ["10", "15", "150"] === CustomAssembler.run_program(program_mul)
  end

  test "handles JMP properly" do
    program_jmp_fist = """
    MOV A 10
    MOV B 15
    MOV C 0
    JMP 5
    MUL
    JMP 7
    ADD
    """

    assert ["10", "15", "0"] === CustomAssembler.run_program(program_jmp_fist)

    program_jmp_two = """
    MOV A 1
    MOV B 2
    JMP 5
    ADD
    JMP 6
    JMP 3
    MOV B 10
    """

    assert ["1", "10", "3"] === CustomAssembler.run_program(program_jmp_two)
  end

  test "handles JNZ properly" do
    program_jnz_one = """
    MOV A 10
    MOV B 15
    MOV C 1
    JNZ 5
    MUL
    ADD
    """

    assert ["10", "15", "25"] === CustomAssembler.run_program(program_jnz_one)

    program_jnz_two = """
    MOV A 10
    MOV B 15
    MOV C 0
    JNZ 5
    MUL
    JNZ 7
    ADD
    """

    assert ["10", "15", "150"] === CustomAssembler.run_program(program_jnz_two)
  end
end
