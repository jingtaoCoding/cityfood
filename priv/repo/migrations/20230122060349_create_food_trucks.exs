defmodule Cityfood.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks, primary_key: false) do
      add(:id, :bigserial, primary_key: true)
      add :dayorder, :string
      add :dayofweekstr, :string
      add :starttime, :string
      add :endtime, :string
      add :permit, :string
      add :location, :string
      add :locationdesc, :text
      add :optionaltext, :text
      add :locationid, :string
      add :start24, :string
      add :end24, :string
      add :cnn, :string
      add :block, :string
      add :lot, :string
      add :coldtruck, :string
      add :applicant, :string
      add :x, :string
      add :y, :string
      add :latitude, :string
      add :longitude, :string
      add :location_2, :map
      add :city_id, :bigint, null: false

      timestamps()
    end

    create(index(:food_trucks, [:city_id, :coldtruck]))
    create(unique_index(:food_trucks, [:locationid, :dayorder]))
  end
end
