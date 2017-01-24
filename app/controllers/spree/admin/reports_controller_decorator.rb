require 'csv'
require 'prawn'

Spree::Admin::ReportsController.class_eval do

  Spree::Admin::ReportsController.add_available_report!(:client_orders, "Shows all customer orders")
  Spree::Admin::ReportsController.add_available_report!(:csv_uploads, "Imported CSV data")
  Spree::Admin::ReportsController.add_available_report!(:manufacturing_times, "Time taken to build and ship order")
  Spree::Admin::ReportsController.add_available_report!(:client_rankings, "Customers who have spent the most")

  def client_orders
    params[:q] = {} unless params[:q]

    if params[:q][:completed_at_gt].blank?
      params[:q][:completed_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:completed_at_gt] = Time.zone.parse(params[:q][:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:completed_at_lt].blank?
      params[:q][:completed_at_lt] = Time.zone.parse(params[:q][:completed_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "completed_at desc"

    @search = Spree::Order.complete.ransack(params[:q])
    @orders = @search.result

    @totals = {}
    @orders.each do |order|
      @totals[order.currency] = { :item_total => ::Money.new(0, order.currency), :tax_total => ::Money.new(0, order.currency), :shipment_total => ::Money.new(0, order.currency), :promo_total => ::Money.new(0, order.currency), :sales_total => ::Money.new(0, order.currency) } unless @totals[order.currency]
      @totals[order.currency][:item_total] += order.display_item_total.money
      @totals[order.currency][:tax_total] += order.display_additional_tax_total.money
      @totals[order.currency][:shipment_total] += order.display_shipment_total.money
      @totals[order.currency][:promo_total] += order.display_promo_total.money
      @totals[order.currency][:sales_total] += order.display_total.money
    end

    respond_to do |format|
      format.html{

      }

      format.pdf {
        pdf = Prawn::Document.new

        table = []
        table << get_table_headers

        @orders.each do |order|
          table << get_table_row(order)
        end

        table << [{content: '', colspan: 7}]

        @totals.each do |key, row|
          table << [{content: "Totals (#{key})", align: :right, colspan: 2}, row[:item_total].format, row[:tax_total].format, row[:shipment_total].format, row[:promo_total].format, row[:sales_total].format]
        end

        pdf.image "#{Rails.root}/app/assets/images/logo.png", position: :center, width: 150, height: 150
        pdf.stroke do
          pdf.horizontal_line 100, 440
        end
        pdf.move_down 20
        pdf.formatted_text [{ text: 'Doctors Orders Report', size: 18, styes: [:bold] }], align: :center
        pdf.formatted_text [{ text: "#{l params[:q][:completed_at_gt].to_date, :format => '%b %d, %Y'} to #{l params[:q][:completed_at_lt] ? params[:q][:completed_at_lt].to_date : Date.today, :format => '%b %d, %Y'} " }], align: :center
        pdf.move_down 40

        pdf.table(table, header: true, width: 540) do
          cells.padding = 5
          #cells.borders = []
          row(0).borders = [:bottom]
          row(0).border_width = 2
          row(0).font_style = :bold
          columns(0..6).borders = [:bottom]
          columns(1..6).borders = [:bottom, :left]
        end

        render pdf: pdf, filename: "doctors-orders-#{Date.today}"
      }

      format.csv {
        csv = CSV.generate(headers:true) do |csv|
          csv << get_table_headers

          @orders.each do |order|
            csv << get_table_row(order)
          end
        end

        render csv: csv, filename: "doctors-orders-#{Date.today}"
      }
    end
  end

  def csv_uploads
    params[:q] = {} unless params[:q]

    if params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "created_at desc"

    @search = CsvFile.ransack(params[:q])
    @csvs = @search.result

    @csv_column_headers = CsvFile.columns.map { |column| column.name.humanize.titleize }

    respond_to do |format|
      format.html{

      }

      format.csv {
        csv = CSV.generate(headers:true) do |csv|
          csv << @csv_column_headers[1..-2] # Remove the id and the update_at columns (first and last columns)

          #csv << @csvs.to_a.map {|column| column.value}
          @csvs.each do |csv_entry|
            csv << csv_entry.attributes.to_a[1..-2].map { |key, value|
              if key == 'created_at'
                l value.to_date, :format => '%b %d, %Y'
              else
                value
              end
            }
          end
        end

        render csv: csv, filename: "csv-uploads-#{Date.today}"
      }
    end
  end

  def manufacturing_times
    params[:q] = {} unless params[:q]

    params[:q][:current_eq] = 'shipped'

    if params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "created_at desc"

    @search = Status.ransack(params[:q])
    @statuses = @search.result

    @average = 0
    @statuses.each { |status| @average += (status.updated_at - status.created_at) }
    @average = (@average/@statuses.length)/(60*60*24) if @statuses.present?

    respond_to do |format|
      format.html{

      }

      format.csv {
        csv = CSV.generate(headers:true) do |csv|
          csv << ['Order Number', 'Available for Manufacturing', 'Shipped', 'Total Days']

          @statuses.each do |status|
            csv << [status.order.number,
                    (l status.created_at.to_date, :format => '%b %d, %Y'),
                    (l status.updated_at.to_date, :format => '%b %d, %Y'),
                    ((status.updated_at - status.created_at)/(60*60*24)).round
            ]
          end
        end

        render csv: csv, filename: "manufacturing-times-#{Date.today}"
      }
    end
  end

  def client_rankings
    params[:q] = {} unless params[:q]

    if params[:q][:completed_at_gt].blank?
      params[:q][:completed_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:completed_at_gt] = Time.zone.parse(params[:q][:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:completed_at_lt].blank?
      params[:q][:completed_at_lt] = Time.zone.parse(params[:q][:completed_at_lt]).end_of_day rescue ""
    end

    params[:q][:s] ||= "completed_at desc"

    @search = Spree::Order.complete.ransack(params[:q])
    @orders = @search.result

    @orders_by_users = []

    @orders.group_by(&:user).each do |groups|
      row = {}
      groups.each_with_index  do |group, index|


        if index == 0
          if group.is_a?(Spree::User)
            row[:email] = group.email
          else
            row[:email] = ''
          end
        else
          row[:item_count] = 0
          row[:total_spent] = 0

          group.each do |order|
            row[:item_count] += order.item_count
            row[:total_spent] += order.item_total
          end
        end
      end

      @orders_by_users << row
    end

    @orders_by_users.sort_by! { |x| x[:total_spent] }
    @orders_by_users.reverse!

    respond_to do |format|
      format.html{

      }

      format.csv {
        csv = CSV.generate(headers:true) do |csv|
          csv << ['Rank', 'Client Email', 'Items Ordered', 'Total Spent']

          @orders_by_users.each_with_index do |user_order, index|
            csv << [
                index + 1,
                user_order[:email],
                user_order[:item_count],
                user_order[:total_spent]
            ]
          end
        end

        render csv: csv, filename: "doctor-rankings-#{Date.today}"
      }
    end
  end

  private
    def get_table_headers
      ['Client Email','Date', 'Subtotal', 'Tax', 'Shipping', 'Promo', 'Sales Total']
    end

    def get_table_row(order)
      [order.user ? order.user.email : '', (l order.completed_at.to_date, :format => '%b %d, %Y'), order.item_total, order.additional_tax_total, order.shipment_total, order.promo_total, order.total]
    end
end