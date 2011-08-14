class CreateManageableContentPageContents < ActiveRecord::Migration
  def change
    create_table :manageable_content_page_contents do |t|
      t.references :page
      t.string :key
      t.text :content

      t.timestamps
    end

    add_index :manageable_content_page_contents, [:page_id, :key], :unique => true
  end
end
