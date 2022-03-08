#FizzBuzz_Tarea

defmodule FizzBuzz do
  def fib()do
    Enum.each(1..100,fn x->IO.puts fib(x) end)
  end
  def fib(x) do
    if rem(x, 3) == 0 and rem(x, 5) == 0 do
      "FizzBuzz"
    else
      if rem(x, 3) == 0 do
        "Fizz"
      else
        if rem(x, 5) == 0 do
          "Buzz"
        else
          x
        end
      end
    end
  end
end

FizBuzz.fib()