defmodule Rumbl.TokenService do
  import Joken

  def generate_token(user) do
    %{user_id: user.id}
      |> Joken.token()
      |> Joken.with_signer(hs256("my_secret"))
      |> Joken.sign()
      |> Joken.get_compact()
  end
end
