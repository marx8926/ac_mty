class CreateUsuarioMenus < ActiveRecord::Migration
  def change
    create_table( :usuario_menus, :id => false ) do |t|
      t.primary_key :int_usuariomenu_id
      t.references :user, index: true
      t.references :menu, index: true
      t.timestamps
    end
  end
end
