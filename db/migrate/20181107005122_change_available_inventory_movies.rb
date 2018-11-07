class ChangeAvailableInventoryMovies < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up{ Movie.update_all('available_inventory = inventory')}
    end
  end
end
