# This migration comes from biovision_base_engine (originally 20170302000101)
class CreatePrivileges < ActiveRecord::Migration[5.1]
  def up
    unless Privilege.table_exists?
      create_table :privileges do |t|
        t.timestamps
        t.integer :parent_id
        t.boolean :locked, default: false, null: false
        t.boolean :deleted, default: false, null: false
        t.boolean :regional, default: false, null: false
        t.boolean :administrative, default: true, null: false
        t.integer :priority, limit: 2, default: 1, null: false
        t.integer :users_count, default: 0, null: false
        t.string :parents_cache, default: '', null: false
        t.integer :children_cache, array: true, default: [], null: false
        t.string :name, null: false
        t.string :slug, null: false
        t.string :description, default: '', null: false
      end

      add_foreign_key :privileges, :privileges, column: :parent_id, on_update: :cascade, on_delete: :cascade

      add_index :privileges, :slug, unique: true

      create_privileges
    end
  end

  def down
    if Privilege.table_exists?
      drop_table :privileges
    end
  end

  def create_privileges
    Privilege.create!(slug: 'administrator', name: 'Администратор')
    Privilege.create!(slug: 'metrics_manager', name: 'Аналитик метрик')
    Privilege.create!(slug: 'moderator', name: 'Модератор')
    Privilege.create!(slug: 'chief_editor', name: 'Главный редактор')
    Privilege.create!(slug: 'content_manager', name: 'Контент-менеджер')
  end
end
