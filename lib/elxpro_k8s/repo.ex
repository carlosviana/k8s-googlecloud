defmodule ElxproK8s.Repo do
  use Ecto.Repo,
    otp_app: :elxpro_k8s,
    adapter: Ecto.Adapters.Postgres
end
