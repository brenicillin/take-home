class ChangeStatusDataTypeInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :status, :string
  end
end
