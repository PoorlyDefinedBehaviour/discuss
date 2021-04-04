defmodule Discuss.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string, null: false
      add :user_id, references(:users), null: false
      add :topic_id, references(:topics), null: false

      timestamps()
    end
  end
end
