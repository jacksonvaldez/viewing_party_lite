class CreateViewingParties < ActiveRecord::Migration[5.2]
  def change
    create_table :viewing_parties do |t|
      t.references :host, foreign_key: true
      t.string :movie_title
      t.integer :duration
      t.datetime :start_date

      t.timestamps
    end
  end
end
