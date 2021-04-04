defmodule Discuss.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
