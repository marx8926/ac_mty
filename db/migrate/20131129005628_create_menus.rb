class CreateMenus < ActiveRecord::Migration
  def change
    create_table( :menus, :id=>false) do |t|

      t.primary_key :int_menu_id
      t.string :var_menu_nombre, limit: 50
      t.string :var_menu_path, limit: 150
      t.integer :int_menu_nivel
      t.integer :int_new_dep

      t.timestamps
    end
  end
end
