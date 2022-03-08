defmodule MyLists_Test do
  use ExUnit.Case
  doctest BecariosBunsan2022B1

  test "Test_Map" do
    assert MyLists.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end

  test "Test_Each" do
    assert MyLists.each(["some", "example"], fn x -> IO.puts(x) end  ) == :ok
  end

  test "Test_zip" do
    assert MyLists.zip([1, 2, 3], [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
  end

  test "Test_Reduce" do
    assert MyLists.reduce([1, 2, 3], 0, fn x, acc -> x + acc end) == 6
  end

  end
end