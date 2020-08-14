defmodule Urldome.Entities.Url do
  defstruct hash: nil, url: nil
  @type t(hash, url) :: %__MODULE__{hash: hash, url: url}
  @type t :: %__MODULE__{hash: String.t(), url: String.t()}
end
