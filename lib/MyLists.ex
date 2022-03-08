#Recursion

defmodule MyLists do
  def map([], _function) do
    :done
  end

  def map([head|tail], fun) do
    fun.(head)
  map(tail, fun)

  end

  def each([], _function) do
    :done
  end

  def each([head|tail], fun) do
    fun.(head)
    each(tail,fun)
  end

  def zip([], []) do
    []
  end

  def zip([head|tail],[head2|tail2]) do
    [{head,head2}|zip(tail,tail2)]
  end

  def reduce([],acc,_function) do
    acc
  end

  def reduce([head|tail],acc,fun) do
    new_acc=fun.(head,acc)
    reduce(tail,new_acc,fun)
  end
end