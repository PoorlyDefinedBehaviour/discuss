defmodule Discuss.Topics do
  defdelegate create(title), to: Discuss.Topics.Create, as: :call
end
