class DropMailkickSubscriptions < ActiveRecord::Migration[7.0]
  def change
    drop_table :mailkick_subscriptions
  end
end
