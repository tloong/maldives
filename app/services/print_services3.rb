class PrintServices3 < Struct.new(:pyear, :pmonth, :pis_mortgaged)

  include ActionView::Helpers::NumberHelper
  include FixedassetsHelper

  def error(job, exception)
    Rails.logger.error "Job failed #{exception}"
  end

  def before(job)
    Rails.logger.error 'newsletter_job/start'
  end

  def after(job)
    Rails.logger.error 'newsletter_job/after'
  end

  def success(job)
    Rails.logger.error 'newsletter_job/success'
  end

  def failure(job)
    Rails.logger.error 'failure'
  end

  def generate_data(data_hash,title_ary)

    page_ary = Array.new    #=> []
    table_ary = Array.new
    data_ary = Array.new   
    type_count = {}
    item_count = {}
    # deal with by department or category.
    data_hash.each do |index, asset_hash|
      sum_array = Array.new
      cat_sum_array = Array.new(18,0)
      cat_sum_array[0] = "本類合計:"
      cat_sum_array[1] = ""
      
      cat_sum_array[2] = ""
      cat_sum_array[3] = ""
      cat_sum_array[4] = ""
      cat_sum_array[6] = ""
      cat_sum_array[12] = ""
      row_per_page = 44
      row_last = row_per_page
      data_array = asset_hash.values
      page_num = 0
      (0..data_array.count-1).each do |index|
    
        if (row_last == row_per_page)
          # 如果是新的一行, then 需放title
          table_ary = Array.new
          data_ary = Array.new
          data_ary.push(title_ary)
          table_ary.push(data_ary)
          sum_array = Array.new(18,0)
          data_ary = Array.new
          sum_array[0] = "本頁小計"
          sum_array[1] = ""
          sum_array[2] = ""
          sum_array[3] = ""
          sum_array[4] = ""
          sum_array[6] = ""
          sum_array[12] = ""
          page_num = page_num + 1
        end
          
        sum_array[5] = sum_array[5] + data_array[index][5]
        sum_array[7] = sum_array[7] + data_array[index][7]
        sum_array[8] = sum_array[8] + data_array[index][8]
        sum_array[9] = sum_array[9] + data_array[index][9]
        sum_array[10] = sum_array[10] + data_array[index][10]
        sum_array[11] = sum_array[11] + data_array[index][11]
        sum_array[13] = sum_array[13] + data_array[index][13]
        sum_array[14] = sum_array[14] + data_array[index][14]
        sum_array[15] = sum_array[15] + data_array[index][15]
        sum_array[16] = sum_array[16] + data_array[index][16]
        sum_array[17] = sum_array[17] + data_array[index][17]
        data_array[index].map! {|a| (a==0)? "" : a}
        data_array[index].map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
        data_ary.push(data_array[index])

        row_last = row_last - 1
        #將每一項加入table_array每33項後，
        if (row_last == 0 || index == data_array.count-1)
          empty_array = Array.new(18,"")
          (0..row_last-1).each do
            # push empty array(19) into data
            data_ary.push(empty_array)
          end

          # push data into table
          table_ary.push(data_ary)
          data_ary = Array.new
          # then new tmp_cat_sum
          # tmp_cat_sum = sum + cat_sum
          tmp_cat_sum_array = Array.new(18) 
          tmp_cat_sum_array[0] = "本類合計:"
          tmp_cat_sum_array[5] = sum_array[5] + cat_sum_array[5]
          tmp_cat_sum_array[7] = sum_array[7] + cat_sum_array[7]
          tmp_cat_sum_array[8] = sum_array[8] + cat_sum_array[8]
          tmp_cat_sum_array[9] = sum_array[9] + cat_sum_array[9]
          tmp_cat_sum_array[10] = sum_array[10] + cat_sum_array[10]
          tmp_cat_sum_array[11] = sum_array[11] + cat_sum_array[11]
          tmp_cat_sum_array[13] = sum_array[13] + cat_sum_array[13]
          tmp_cat_sum_array[14] = sum_array[14] + cat_sum_array[14]
          tmp_cat_sum_array[15] = sum_array[15] + cat_sum_array[15]
          tmp_cat_sum_array[16] = sum_array[16] + cat_sum_array[16]
          tmp_cat_sum_array[17] = sum_array[17] + cat_sum_array[17]

          cat_sum_array[5] = tmp_cat_sum_array[5]
          cat_sum_array[7] = tmp_cat_sum_array[7]
          cat_sum_array[8] = tmp_cat_sum_array[8]
          cat_sum_array[9] = tmp_cat_sum_array[9]
          cat_sum_array[10] = tmp_cat_sum_array[10]
          cat_sum_array[11] = tmp_cat_sum_array[11]
          cat_sum_array[13] = tmp_cat_sum_array[13]
          cat_sum_array[14] = tmp_cat_sum_array[14]
          cat_sum_array[15] = tmp_cat_sum_array[15]
          cat_sum_array[16] = tmp_cat_sum_array[16]
          cat_sum_array[17] = tmp_cat_sum_array[17]



          # push sum into data
          # push tmp_cat_sum into data
          sum_array.map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
          data_ary.push(sum_array)
          tmp_cat_sum_array.map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
          data_ary.push(tmp_cat_sum_array)
          # push data into table
          table_ary.push(data_ary)
          # push table into page
          page_ary.push(table_ary)

          row_last = row_per_page
        end 
      end
      type_count [data_array[0][0][3]] = page_num
      item_count [data_array[0][0][3]] = data_array.count
      #puts page_num

    end

    #puts page_ary
    return [page_ary, type_count, item_count]
  end


  def perform #do_print(year,month)
    year = pyear
    month = pmonth
    is_mortgaged = pis_mortgaged
    Rails.logger.error "is_mortgaged=#{is_mortgaged}"
    if (is_mortgaged==true)
      query_string = "is_mortgaged = 't' and "
    else
      query_string = ""
    end
    # input1: query_date
    
    d84_date = DateTime.new(1997,1,1,0,0,0)
    query_date = DateTime.new(year,month,Time.days_in_month(month,year),0,0,0)
    this_year = DateTime.new(Time.now.year,1,1,0,0,0)
    sort_index1 = :category_id
    sort_index2 = :get_date
    order_by_index1 = "category_id"
    order_by_index2 = "get_date"
    title_ary = ["資產編號","資產名稱 規格","資產部門","數量","取得日期","取得原價","耐年","預留殘值","重估總值","重估殘值","續提總值","續提殘值","續年","應提總額","本期折舊","本年折舊","累計折舊","未折減餘額"]

    if (Rails.env =="development")
      out_date_string = "typeof(fixedassets.out_date) = 'null'"
    elsif (Rails.env=="production")
      out_date_string = "fixedassets.out_date is NULL"
    end

    f = Fixedasset.select(
                  :category_id).where("#{query_string}ab_type='A' and get_date <= ? and (#{out_date_string} or out_date>?)",query_date,query_date).group(sort_index1).order(order_by_index1, order_by_index2)
 
    data_hash = {}
    row_count = {}
    row_count.default = 0 # 計算分類後資料有幾個row, 畫分隔線使用
  

    f.each do |fe|
      index = fe.category_id
      

      data_hash[index] = Hash.new

      # select basic data from fixedasset 
      ff = Fixedasset.includes(:department).where("#{query_string}get_date <= ? and category_id = ? and ab_type='A' and (#{out_date_string} or out_date>?)",query_date,fe.category_id,query_date).order(order_by_index1, order_by_index2)

      ff.each do |ffe|
        #puts ffe.id
        data_hash[index][ffe.id] = Array.new(18)
        data_hash[index][ffe.id][0] = ffe.fixed_asset_id 
        data_hash[index][ffe.id][1] = "#{ffe.name}#{ffe.spec}"
        if (data_hash[index][ffe.id][1].size > 13)
          data_hash[index][ffe.id][1] = "#{data_hash[index][ffe.id][1][0..12]}.."
        end
        data_hash[index][ffe.id][2] = ffe.department.dep_id
        data_hash[index][ffe.id][3] = ffe.quantity 
        tmp_year= ffe.get_date.year-1911
        if (tmp_year >= 100)
          tmp_year=tmp_year-100
        end
        data_hash[index][ffe.id][4] = "#{tmp_year.to_s.rjust(2,'0')}#{ffe.get_date.strftime('%m%d')}"
        data_hash[index][ffe.id][5] = ffe.original_cost
        data_hash[index][ffe.id][6] = ffe.service_life_year
        data_hash[index][ffe.id][7] = ffe.final_scrap_value
        
        
        (8..17).each do |i|
          data_hash[index][ffe.id][i] = 0
        end

        data_hash[index][ffe.id][13] = ffe.original_cost - ffe.final_scrap_value
        
        redep = ffe.fixedasset_redepreciation
        e_date = get_end_date(ffe.end_use_date,redep)

        if ffe.start_use_date >= e_date
          next
        end

        if (month_difference(e_date,query_date)==0)
          data_hash[index][ffe.id][14] = data_hash[index][ffe.id][14] + ffe.depreciated_value_last_month
          data_hash[index][ffe.id][15] = data_hash[index][ffe.id][15] + ffe.depreciated_value_per_month * (month_difference(query_date,this_year)) + ffe.depreciated_value_last_month 
          if (ffe.depreciation84 > 0)
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(query_date,d84_date)) + ffe.depreciated_value_last_month 
          else
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
          end
        elsif (month_difference(e_date,query_date)<0)
          if (month_difference(e_date,this_year)>=0)
            data_hash[index][ffe.id][15] = data_hash[index][ffe.id][15] + ffe.depreciated_value_per_month * (month_difference(e_date,this_year)) + ffe.depreciated_value_last_month 
          end
          if (ffe.depreciation84 > 0)
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(e_date,d84_date)) + ffe.depreciated_value_last_month 
          else
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciated_value_per_month * (month_difference(e_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
          end      
        elsif (month_difference(query_date,ffe.start_use_date)>=0)
          data_hash[index][ffe.id][14] = data_hash[index][ffe.id][14] + ffe.depreciated_value_per_month
          if (this_year > ffe.start_use_date)
            data_hash[index][ffe.id][15] = data_hash[index][ffe.id][15] + ffe.depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          else
            data_hash[index][ffe.id][15] = data_hash[index][ffe.id][15] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date) +1)
          end
          if (ffe.depreciation84 > 0)
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(query_date,d84_date) +1)
          else
            data_hash[index][ffe.id][16] = data_hash[index][ffe.id][16] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date) +1)
          end
        end
      end
      if (is_mortgaged==true)
        query_string2 = "fixedassets.is_mortgaged = 't' and "
      else
        query_string2 = ""
      end
        # for redepreciated fixedassets
      f_redep = FixedassetRedepreciation.
                          select(
                          :re_original_value,
                          :re_final_scrap_value,
                          :re_depreciated_value_per_month,
                          :re_depreciated_value_last_month,
                          :re_start_use_date,
                          :re_end_use_date,
                          :fixedasset_id
                          ).joins(:fixedasset).where("#{query_string2}fixedassets.get_date <= ? and fixedassets.ab_type='A' and (#{out_date_string} or fixedassets.out_date > ? ) and fixedassets.category_id = ?",query_date ,query_date,fe.category_id)

      f_redep.each do |ffe|

        #if ffe.re_start_use_date < ffe.fixedasset.end_use_date
        #  next
        #end
        
        #puts index + ffe.fixedasset_id
        fid =  ffe.fixedasset_id.to_i
        data_hash[index][fid][12] = 3

        data_hash[index][fid][13] = data_hash[index][fid][13] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[index][fid][10] = data_hash[index][fid][10] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[index][fid][11] = data_hash[index][fid][11] + ffe.re_final_scrap_value  

        if (month_difference(ffe.re_end_use_date,query_date)==0)
          data_hash[index][fid][14] = data_hash[index][fid][14] + ffe.re_depreciated_value_last_month
          data_hash[index][fid][15] = data_hash[index][fid][15] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year)) + ffe.re_depreciated_value_last_month 
          data_hash[index][fid][16] = data_hash[index][fid][16] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 
        elsif (month_difference(ffe.re_end_use_date,query_date)<0)
          if (month_difference(ffe.re_end_use_date,this_year)>=0)
            data_hash[index][fid][15] = data_hash[index][fid][15] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,this_year)) + ffe.re_depreciated_value_last_month 
          end
          data_hash[index][fid][16] = data_hash[index][fid][16] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 
        elsif (month_difference(query_date,ffe.re_start_use_date)>=0)
          data_hash[index][fid][14] = data_hash[index][fid][14] + ffe.re_depreciated_value_per_month
          data_hash[index][fid][16] = data_hash[index][fid][16] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date) +1)
          if (this_year > ffe.re_start_use_date)
            data_hash[index][fid][15] = data_hash[index][fid][15] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          else
            data_hash[index][fid][15] = data_hash[index][fid][15] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date) +1)
          end
        end
      end 

      # for reevaluation fixedassets
      f_reev = Fixedasset.joins(:fixedasset_changeds).
                    select(
                      :category_id,
                      :evaluated_value,
                      :evaluated_scrap_value,
                      "fixedassets.department_id",
                      :original_cost,
                      :final_scrap_value,
                      :id).where("#{query_string}get_date <= ? and ab_type='A' and category_id = ? and (#{out_date_string} or out_date > ? ) and change_type=3",query_date,fe.category_id,query_date)

      f_reev.each do |ffe|
        
        #puts "index = #{index}, id = #{ffe.id}"
        tmp_f = Fixedasset.find(ffe.id)

        data_hash[index][ffe.id][8] = ffe.evaluated_value
        data_hash[index][ffe.id][9] = ffe.evaluated_scrap_value
        data_hash[index][ffe.id][17] = ffe.evaluated_scrap_value - ffe.final_scrap_value
        data_hash[index][ffe.id][13] = data_hash[index][ffe.id][13] + (data_hash[index][ffe.id][8] - ffe.original_cost) - (data_hash[index][ffe.id][9] - ffe.final_scrap_value) 
      end

      data_hash[index].each do |k,v|
        #puts "index = #{k}"
        v[17] = v[17] + v[13] - v[16] + v[7] - v[10]
        #puts v.to_yaml
      end
    end
    
    document_data_array,page_count,item_count = generate_data(data_hash,title_ary)
    if (is_mortgaged==true)
      filename_postfix = "(已抵押)"
    else
      filename_postfix = ""
    end 
    Rails.logger.error "filename_postfix=#{filename_postfix}"
    # start print pdf
    Prawn::Document.generate(Rails.root.to_s+"/public/fixedassets_pdf/財產明細總表#{filename_postfix}_#{year}_#{month}.pdf",:page_size=>[1071,792], :layout => :landscape) do

      def header(page_size,title, subtitle, left1, left2, right1, page_number)
        stroke_color "000000"
        #font("/System/Library/Fonts/gkai00mp.ttf") do
        font(Rails.root.to_s+"/resources/fonts/wt003.ttf") do
          text title, :size => 18, :align => :center
          text_box right1, :size => 10, :at => [915, 710], :width => 80, :align => :right
          text_box left1, :size => 10, :at => [0, 710], :width => 300, :align => :left
          text_box left2, :size => 10, :at => [0, 695], :width => 300, :align => :left
          text_box "頁次: #{page_number}", size: 10, :at => [915,695], :width => 80, :align => :right
          text subtitle, size: 18, :align => :center
          stroke do
            dash(3, space: 1, phase: 0)
            horizontal_rule
            move_down 3
            horizontal_rule
          end
          undash
        end
      end

      page_count_a = page_count.to_a
      item_count_a = item_count.to_a
      page_index = 0
      page_num = 0
      page_string = ""
      total_page = page_count_a[page_index][1]
      total_item = item_count_a[page_index][1]
      #puts "total_page = #{document_data_array.count}"
      (0..document_data_array.count-1).each do |page|
        if (page > 0)
          start_new_page
        end

        if(total_page==page_num)
          #puts "we have alreay #{page_num} pages"
          page_index = page_index + 1
          page_num = 0
          total_page = page_count_a[page_index][1]
          total_item = item_count_a[page_index][1]
        end

        if (page_num ==0)
          fc = FixedassetCategory.select(:cat_name).where("cat_id = ?", page_count_a[page_index][0])
          page_string = "類別: #{page_count_a[page_index][0]} #{fc.first.cat_name} (共#{total_item}項)" 
        end
        page_num = page_num + 1

        if (is_mortgaged==true)
          title_postfix = "(已抵押)"
        else
          title_postfix = ""
        end 
        Rails.logger.error "title_postfix=#{title_postfix}"
        header(:us_std_fanfold, "東隆興業股份有限公司", "財產目錄總表#{title_postfix}", "折舊期間: #{year}/#{month}",page_string,"折舊方法:平均法","#{page_num} / #{total_page}")

        (0..document_data_array[page].count-1).each do |i|
          table document_data_array[page][i] do
            row_number = document_data_array[page][i].count - 1 

            cells.borders = []    
            column(0).width = 66
            column(1).width = 157
            column(2).width = 32
            column(3).width = 22
            columns(4).width = 37
            column(5).width=68
            column(6).width=22
            column(7).width = 56
            column(8).width=54
            column(9).width=54
            columns(10..11).width = 54
            column(12).width = 22
            column(13).width = 68
            columns(14..15).width = 54
            column(16).width = 68
            column(17).width = 57
            cells.font = Rails.root.to_s+"/resources/fonts/wt003.ttf"
            cells.align = :right
            columns(0..1).align = :left
            cells.style(:size =>10)
            case row_number
            when 0
            when 1
              rows(0).padding = [4, 5, 2, 0]
              rows(1).padding = [2, 5, 4, 0]
            when 2
              row(0).padding = [2, 5, 0, 0]
              row(1).padding = [0, 5, 4, 0]
        
            when 3
              row(0).padding = [2, 5, 0, 0]
              row(1).padding = [0, 5, 0, 0]
              row(2).padding = [0, 5, 4, 0]
            else
              #column(0).style(:font => "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/Inconsolata-Regular.ttf")
              row(0).padding = [2, 5, 0, 0]
              rows(1..row_number-1).padding = [0, 5, 0, 0]
              row(row_number).padding = [0, 5, 10, 0]
            end
          end     

          if (i == 0)
            stroke_horizontal_rule
          elsif (i > 0)
            stroke do
              dash(3, space: 2, phase: 0)
              horizontal_rule
            end
            undash
          end
        end
      end
    end  
  end
  
end