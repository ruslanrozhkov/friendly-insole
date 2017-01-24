class ChangeDataTypesForCsvFiles < ActiveRecord::Migration
  def change
    change_table :csv_files do |t|
      t.change :weight, :string
      t.change :shoe_size, :string

      t.change :shoe_size_l, :string
      t.change :shoe_size_r, :string

      t.change :foot_length_l, :string
      t.change :foot_length_r, :string

      t.change :foot_width_l, :string
      t.change :foot_width_r, :string

      t.change :heel_width_l, :string
      t.change :heel_width_r, :string

      t.change :arch_length_l, :string
      t.change :arch_length_r, :string

      t.change :_1_5_met_width_l, :string
      t.change :_1_5_met_width_r, :string

      t.change :point_height_l, :string
      t.change :point_height_r, :string

      t.change :area_height_l, :string
      t.change :area_height_r, :string

      t.change :arch_index_l, :string
      t.change :arch_index_r, :string

      t.change :arch_index_type_l, :string
      t.change :arch_index_type_r, :string

      t.change :heel_angle_l, :string
      t.change :heel_angle_r, :string

      t.change :heel_angle_type_l, :string
      t.change :heel_angle_type_r, :string

      t.change :leg_angle_l, :string
      t.change :leg_angle_r, :string

      t.change :leg_angle_type_l, :string
      t.change :leg_angle_type_r, :string
    end
  end
end
