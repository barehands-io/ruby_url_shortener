class CreateUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.string :custom_alias
      t.datetime :expiration_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
