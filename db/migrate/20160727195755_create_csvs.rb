class CreateCsvs < ActiveRecord::Migration
  def change
    create_table :csvs do |t|
      t.decimal :weight
      t.decimal :shoe_size

      t.decimal :shoe_size_l
      t.decimal :shoe_size_r
      t.string  :shoe_size_units

      t.decimal :foot_length_l
      t.decimal :foot_length_r
      t.string  :foot_length_units

      t.decimal :foot_width_l
      t.decimal :foot_width_r
      t.string  :foot_width_units

      t.decimal :heel_width_l
      t.decimal :heel_width_r
      t.string  :heel_width_units

      t.decimal :arch_length_l
      t.decimal :arch_length_r
      t.string  :arch_length_units

      t.decimal :_1_5_met_width_l
      t.decimal :_1_5_met_width_r
      t.string  :_1_5_met_width_units

      t.decimal :point_height_l
      t.decimal :point_height_r
      t.string  :point_height_units

      t.decimal :area_height_l
      t.decimal :area_height_r
      t.string  :area_height_units

      t.decimal :arch_index_l
      t.decimal :arch_index_r

      t.decimal :arch_index_type_l
      t.decimal :arch_index_type_r

      t.decimal :heel_angle_l
      t.decimal :heel_angle_r
      t.string  :heel_angle_units

      t.decimal :heel_angle_type_l
      t.decimal :heel_angle_type_r

      t.decimal :leg_angle_l
      t.decimal :leg_angle_r
      t.string  :leg_angle_units

      t.decimal :leg_angle_type_l
      t.decimal :leg_angle_type_r

      t.timestamps null: false
    end
  end
end
