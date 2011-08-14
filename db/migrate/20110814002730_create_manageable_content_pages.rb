class CreateManageableContentPages < ActiveRecord::Migration
  def change
    create_table :manageable_content_pages do |t|
      t.string :key
      t.string :locale

      t.timestamps
    end

    add_index :manageable_content_pages, [:key, :locale], :unique => true
  end
end
