class ModifyColumnNameOfRa < ActiveRecord::Migration
  def change
    rename_column :repair_acceptance_certificate_lines, :repair_acceptance_certification_id, :repair_acceptance_certificate_id
  end
end
