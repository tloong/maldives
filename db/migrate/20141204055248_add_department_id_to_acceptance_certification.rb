class AddDepartmentIdToAcceptanceCertification < ActiveRecord::Migration
  def change
  	add_column :acceptance_certifications, :department_id, :integer
  end
end
