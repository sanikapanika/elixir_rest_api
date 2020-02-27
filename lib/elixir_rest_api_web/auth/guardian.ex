defmodule ElixirRestApiWeb.Auth.Guardian do
  use Guardian,
      otp_app: :elixir_rest_api,
      permissions: %{
        default: [:admin, :user],
        user_actions: [:read, :write]
      }

  alias ElixirRestApi.Accounts
  use Guardian.Permissions, encoding: Guardian.Permissions.BitwiseEncoding

  @impl true
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  @impl true
  def resource_from_claims(claims) do
    id = claims["sub"]
    perms = claims["pem"]
    resource = Accounts.get_user!(id)
    {:ok, resource}
  end

  def authenticate(email, password) do
    with {:ok, user} <- Accounts.get_by_email(email) do
      case validate_password(password, user.encrypted_password) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  @impl true
  def build_claims(claims, _resource, opts) do
    claims =
      claims
      |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))
    {:ok, claims}
  end

  defp validate_password(password, encrypted_password) do
    Comeonin.Bcrypt.checkpw(password, encrypted_password)
  end

  defp create_token(user) do
    structured_perms = map_claims(user.claims)
    {:ok, token, claims} = encode_and_sign(
      user,
      %{
        pem: %{
          default: structured_perms,
          user_actions: [:write]
        }
      }
    )
    {:ok, user, token, claims}
  end

  defp map_claims([]), do: []

  defp map_claims([head | tail]) do
    [String.to_atom(head) | map_claims(tail)]
  end

  defp map_claims_comprehension(list: claims) do
    claims
    |> Enum.chunk_every(2)
    |> Enum.into(%{}, fn [a, b] -> {a, b} end)
  end
end