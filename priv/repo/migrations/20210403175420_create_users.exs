defmodule Discuss.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :provider, :string, null: false
      add :token, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email, :token])
  end
end
