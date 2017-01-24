require 'csv'

class OrderForm < ActiveRecord::Base
  belongs_to :line_item, :class_name => 'Spree::LineItem'
  belongs_to :saved_line_item

  after_save :parse_csv

  has_attached_file :stl_file_l
  validates_attachment_file_name :stl_file_l, :matches => /\A*.stl\Z/

  has_attached_file :stl_file_r
  validates_attachment_file_name :stl_file_r, :matches => /\A*.stl\Z/

  has_attached_file :csv_file
  validates_attachment_file_name :csv_file, :matches => /\A*.csv\Z/

  validates :patient_id,  presence: true
  validates :age,         presence: true, numericality: { only_integer: true }
  validates :weight,      presence: true, numericality: true
  validates :shoe_size,   presence: true, numericality: true
  validates :stl_file_l,  presence: true
  validates :stl_file_r,  presence: true
  validates :csv_file,    presence: true

  def self.defaults
    self.new
  end

  # After we save the order form, we need to parse and then save the CSV file
  def parse_csv
    if self.csv_file.present?
      csv_text = Paperclip.io_adapters.for(self.csv_file).read
      csv = CSV.parse(csv_text, :headers => false)

      csv_columns = ['l', 'r', 'units']

      csv_to_save = {}

      csv.each_with_index do |row, i|
        if i == 0
          csv_to_save['weight'] = row[1].split(':')[1] # string is like Weight:201, only want the number
          csv_to_save['shoe_size'] = row[2].split(':')[1] # string is like Shoe Size:9
        elsif i >= 3
          row.each_with_index do |field, j|
            if j >= 1 and !field.blank?
              csv_to_save[generate_csv_row_key(csv_columns, row, i, j)] = field
            end
          end
        end
      end

      # Check to see if any of the fields are nil, then we must have not received the correct file
      is_clean = true
      csv_to_save.each do |key, val|
        if val.nil?
          is_clean = false
          break
        end
      end

      CsvFile.create!(csv_to_save) if is_clean
    end
  end

  def generate_csv_row_key(csv_columns, row, i, j)
    key = "#{row[0].sub('-', '_').tr(' ', '_')}_#{csv_columns[j-1]}".downcase

    if key.starts_with? '1'
      key.prepend('_')
    end

    case i
      when 12
        key = "arch_index_type_#{csv_columns[j-1]}"
      when 14
        key = "heel_angle_type_#{csv_columns[j-1]}"
      when 16
        key = "leg_angle_type_#{csv_columns[j-1]}"
    end

    key
  end
end