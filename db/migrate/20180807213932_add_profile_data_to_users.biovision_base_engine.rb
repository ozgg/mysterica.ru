# This migration comes from biovision_base_engine (originally 20180321000000)
class AddProfileDataToUsers < ActiveRecord::Migration[5.1]
  def up
    unless column_exists? :users, :birthday
      add_column :users, :birthday, :date
    end
    unless column_exists? :users, :profile_data
      add_column :users, :profile_data, :json, null: false, default: {}
    end

    copy_data if UserProfile.table_exists?
  end

  def down
    # no rollback
  end

  private

  def copy_data
    ignore = %w(id created_at updated_at user_id birthday)
    UserProfile.order('user_id asc').each do |profile|
      data = {
        profile_data: profile.attributes.reject { |a| ignore.include?(a) }
      }
      if profile.attributes.key?('birthday')
        data[:birthday] = profile.birthday
      end
      profile.user.update!(data)
    end
  end
end
