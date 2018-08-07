# This migration comes from biovision_post_engine (originally 20180606120001)
class AddTimeRequiredToPosts < ActiveRecord::Migration[5.2]
  def up
    unless column_exists?(:posts, :time_required)
      add_column :posts, :time_required, :integer, limit: 2
    end
  end

  def down
    # no need to rollback
  end
end
