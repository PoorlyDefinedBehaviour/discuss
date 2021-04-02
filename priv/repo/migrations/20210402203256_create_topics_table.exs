defmodule Discuss.Repo.Migrations.CreateTopicsTable do
  use Ecto.Migration

  def change do
    create table :topics do
      add :title, :string, null: false
    end
  end
end
