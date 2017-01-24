Spree::PermittedAttributes.class_eval do
  self.line_item_attributes.concat [
    :patient_id,
    :age,
    :weight,
    :shoe_size,
    :gender,
    :diabetic,
    :notes,
    :orthotic_profile,
    :shell_material,
    :shell_modifications_fill_arch_left, :shell_modifications_fill_arch_right,
    :shell_modifications_first_met_cutout_left, :shell_modifications_first_met_cutout_right,
    :shell_modifications_first_ray_cutout_left, :shell_modifications_first_ray_cutout_right,
    :shell_modifications_flange_lat_med_left, :shell_modifications_flange_lat_med_right,
    :shell_modifications_gate_plate_in_out_left, :shell_modifications_gate_plate_in_out_right,
    :shell_modifications_heel_spur_hole_left, :shell_modifications_heel_spur_hole_right,
    :post_heel,
    :post_heel_right_medial, :post_heel_left_medial,
    :post_heel_right_lateral, :post_heel_left_lateral,
    :post_forefoot,
    :post_forefoot_right_medial, :post_forefoot_left_medial,
    :post_forefoot_right_lateral, :post_forefoot_left_lateral,
    :shell_width,
    :heel_cup,
    :heel_lift_left, :heel_lift_right,
    :pronation_skive_heel_post_left_corner_skive_only, :pronation_skive_heel_post_right_corner_skive_only,
    :pronation_skive_heel_post_left_skive_1_3_medial_post_surface, :pronation_skive_heel_post_right_skive_1_3_medial_post_surface,
    :kirby_skive_left, :kirby_skive_right,
    :cover_length,
    :top_cover,
    :cushion,
    :forefoot_cushion_left, :forefoot_cushion_right,
    :metatarsal_pads_left_thickness, :metatarsal_pads_right_thickness,
    :metatarsal_pads_left_density, :metatarsal_pads_right_density,
    :met_pad_width,
    :heel_padding_left_style, :heel_padding_right_style,
    :heel_padding_left_extended, :heel_padding_right_extended,
    :digit_cutout_left, :digit_cutout_right,
    :cutout_w_u_left, :cutout_w_u_right,
    :navicular_relief_left, :navicular_relief_right,
    :specialties_mortons_extension_left, :specialties_mortons_extension_right,
    :specialties_reverse_mortons_left, :specialties_reverse_mortons_right,
    :specialties_tendon_relief_track_left, :specialties_tendon_relief_track_right,
    :stl_file_l, :stl_file_r, :csv_file
 ]

  self.user_attributes.concat [:bill_address_id, :ship_address_id]
end