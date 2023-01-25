defmodule Cityfood.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities, primary_key: false) do
      add(:id, :bigserial, primary_key: true)
      add :name, :string
      add :country, :string
      add :lan, :float
      add :lon, :float

      timestamps()
    end
  end
end
