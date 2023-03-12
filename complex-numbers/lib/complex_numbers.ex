defmodule ComplexNumbers do
  import Kernel, except: [div: 2, abs: 1]
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real(a) do
    elem(a, 0)
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary(a) do
    elem(a, 1)
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul(a, b) do
    cond do
      is_number(a) -> {a * real(b), a * imaginary(b)}
      is_number(b) -> {real(a) * b, imaginary(a) * b}
      true -> {real(a) * real(b) - imaginary(a) * imaginary(b), imaginary(a) * real(b) + real(a) * imaginary(b)}
    end
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add(a, b) do
    cond do
      is_number(a) -> {a + real(b), imaginary(b)}
      is_number(b) -> {real(a) + b, imaginary(a)}
      true -> {real(a) + real(b), imaginary(a) + imaginary(b)}
    end
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub(a, b) do
    cond do
      is_number(a) -> {a - real(b), -imaginary(b)}
      is_number(b) -> {real(a) - b, imaginary(a)}
      true -> {real(a) - real(b), imaginary(a) - imaginary(b)}
    end
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div(a, b) do
    cond do
      is_number(a) -> ri_2 = :math.pow(real(b), 2) + :math.pow(imaginary(b), 2)
        {a * real(b) / ri_2, -a * imaginary(b) / ri_2}
      is_number(b) -> {real(a) / b, imaginary(a) / b}
      true -> r_1 = real(a) * real(b) + imaginary(a) * imaginary(b)
        ri_2 = :math.pow(real(b), 2) + :math.pow(imaginary(b), 2)
        i_1 = imaginary(a) * real(b) - real(a) * imaginary(b)
        {r_1/ri_2, i_1/ri_2}
    end
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs(a) do
    r_2 = :math.pow(real(a), 2)
    i_2 = :math.pow(imaginary(a), 2)
    :math.sqrt(r_2 + i_2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(a) do
    {real(a), -imaginary(a)}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    mul(:math.exp(real(a)), {:math.cos(imaginary(a)), :math.sin(imaginary(a))})
  end
end
