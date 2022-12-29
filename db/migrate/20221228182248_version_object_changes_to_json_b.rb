class VersionObjectChangesToJsonB < ActiveRecord::Migration[6.1]
  def change
    add_column :versions, :new_object_changes, :jsonb

    PaperTrail::Version.where.not(object_changes: nil).find_each do |version|

      if version.object_changes
        new_object_changes = {}
        old_object_changes = YAML.load(version.object_changes)

        old_object_changes.each do |attribute, change|
          object_change = []

          [0,1].each do |i|
            begin
              object_change[i] = JSON.parse(change[i])
            rescue
              object_change[i] = change[i]
            end
          end
          new_object_changes[attribute] = object_change
        end

        version.update_column(
          :new_object_changes,
          new_object_changes
        )
      end
    end

    rename_column :versions, :object_changes, :old_object_changes
    rename_column :versions, :new_object_changes, :object_changes
  end
end
