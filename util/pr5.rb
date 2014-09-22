include ActionView::Helpers::NumberHelper

def month_difference(end_date, start_date)
  (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
end


def header(page_size,title, subtitle, left1, left2, right1, page_number)
  stroke_color "000000"
  #font("/System/Library/Fonts/gkai00mp.ttf") do
  font("/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt003.ttf") do
    text title, :size => 18, :align => :center
    text_box right1, :size => 11, :at => [885, 710], :width => 80, :align => :right
    text_box left1, :size => 11, :at => [0, 710], :width => 200, :align => :left
    text_box left2, :size => 11, :at => [0, 695], :width => 100, :align => :left
    text_box "頁次:#{page_number}", size: 11, :at => [885,695], :width => 80, :align => :right
    text subtitle, size: 18, :align => :center
    stroke do
      dash(3, space: 1, phase: 0)
      horizontal_line 0,970
      move_down 3
      horizontal_line 0,970
    end
    undash
  end
end

def get_end_date (end_date, redep)
  e_date = end_date
  if redep != nil
    if (end_date > redep.re_start_use_date)
      e_date = redep.re_start_use_date
    end
  end
  return e_date
end

def generate_data(data_hash,title_ary)

  page_ary = Array.new    #=> []
  table_ary = Array.new
  data_ary = Array.new   
  type_count = {}
  # deal with by department or category.
  
  sum_array = Array.new(11)
  sum_array[7] = 0
  sum_array[8] = 0
  sum_array[9] = 0
  row_per_page = 44
  row_last = row_per_page
  data_array = data_hash.values
  sum_array[6] = "共#{data_array.count}筆"
  puts "data_array.count=#{data_array.count}"
  page_num = 0

  (0..data_array.count-1).each do |index|

    if (row_last == row_per_page)
      # 如果是新的一行, then 需放title
      table_ary = Array.new
      data_ary = Array.new
      data_ary.push(title_ary)
      table_ary.push(data_ary)
      data_ary = Array.new
      page_num = page_num + 1
    end
      
    sum_array[7] = sum_array[7] + data_array[index][7]
    data_array[index][7] = number_with_delimiter(data_array[index][7])

    sum_array[8] = sum_array[8] + data_array[index][8]
    data_array[index][8] = number_with_delimiter(data_array[index][8])

    sum_array[9] = sum_array[9] + data_array[index][9]
    data_array[index][9] = number_with_delimiter(data_array[index][9])


    data_ary.push(data_array[index])

    row_last = row_last - 1
    #將每一項加入table_array每33項後，
    if (row_last == 0 || index == data_array.count-1)
      # push data into table
      table_ary.push(data_ary)

      if (index == data_array.count-1)
        data_ary = Array.new
        sum_array[7] = number_with_delimiter(sum_array[7])
        sum_array[8] = number_with_delimiter(sum_array[8])
        sum_array[9] = number_with_delimiter(sum_array[9])
        data_ary.push(sum_array)
        table_ary.push(data_ary)
      end
      # push table into page
      page_ary.push(table_ary)
      # push data into table
      row_last = row_per_page
    end 
  end
  
  return [page_ary, page_num]
end

  # input1: query_date
  start_query_date = Date.new(2014,6,1)
  end_query_date = Date.new(2014,7,1)
  query_date = Date.new(2014,6,1)
  
  order_by = "changed_date"
  change_type = 1
  title_ary = ["異動單","報廢日","資產編號","資產名稱及規格","使用部門","取得日期","報廢部門","取得原價","累計折舊","報廢金額","報廢原因"]

  fc = FixedassetChanged.includes(:fixedasset).where("change_type = ? and changed_date < ? and changed_date >= ?",change_type,end_query_date,start_query_date).order(order_by)
  data_hash = {}

  fc.each do |fe|
    index = fe.id

    data_hash[index] = Hash.new
    data_hash[index] = Array.new(11)
    data_hash[index][0] = "#{fe.voucher_no.to_s.rjust(6,'0')}" 
    tmp_year= fe.changed_date.year-1911
    if (tmp_year >= 100)
      tmp_year=tmp_year-100
    end
    data_hash[index][1] = "#{tmp_year.to_s.rjust(2,'0')}#{fe.changed_date.strftime('%m%d')}"
    data_hash[index][2] = fe.fixedasset.fixed_asset_id
    data_hash[index][3] = "#{fe.fixedasset.name}#{fe.fixedasset.spec}"
    data_hash[index][4] = "#{fe.fixedasset.department.dep_id} #{fe.fixedasset.department.alias}"
    tmp_year= fe.fixedasset.get_date.year-1911
    if (tmp_year >= 100)
      tmp_year=tmp_year-100
    end
    data_hash[index][5] = "#{tmp_year.to_s.rjust(2,'0')}#{fe.fixedasset.get_date.strftime('%m%d')}"
    data_hash[index][6] = "#{fe.department.dep_id} #{fe.department.alias}"
    data_hash[index][7] = fe.fixedasset.original_cost
    data_hash[index][8] = 0
    data_hash[index][9] = fe.price
    data_hash[index][10] = fe.note

    ffe = fe.fixedasset

    f_redep = FixedassetRedepreciation.
                      select(
                      :re_original_value,
                      :re_final_scrap_value,
                      :re_depreciated_value_per_month,
                      :re_depreciated_value_last_month,
                      :re_start_use_date,
                      :re_end_use_date,
                      :fixedasset_id
                      ).joins(:fixedasset).where("fixedassets.id = ?",ffe.id)

    redep = ffe.fixedasset_redepreciation #f_redep.first
    e_date = get_end_date(ffe.end_use_date,redep)

    if ffe.start_use_date >= e_date
      next
    end

    if (month_difference(e_date,query_date)==0)
      data_hash[index][8] = data_hash[index][8] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
    elsif (month_difference(e_date,query_date)<0)
      data_hash[index][8] = data_hash[index][8] + ffe.depreciated_value_per_month * (month_difference(e_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
    elsif (month_difference(query_date,ffe.start_use_date)>=0)
      data_hash[index][8] = data_hash[index][8] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date) +1)
    end

    if (redep != nil)
      if (month_difference(redep.re_end_use_date,query_date)==0)
        data_hash[index][8] = data_hash[index][8] + redep.re_depreciated_value_per_month * (month_difference(query_date,redep.re_start_use_date)) + redep.re_depreciated_value_last_month 
      elsif (month_difference(redep.re_end_use_date,query_date)<0)
        data_hash[index][8] = data_hash[index][8] + redep.re_depreciated_value_per_month * (month_difference(redep.re_end_use_date,redep.re_start_use_date)) + redep.re_depreciated_value_last_month 
      elsif (month_difference(query_date,redep.re_start_use_date)>=0)
        data_hash[index][8] = data_hash[index][8] + redep.re_depreciated_value_per_month * (month_difference(query_date,redep.re_start_use_date) +1)
      end
    end
  end

  puts data_hash
  document_data_array,page_count = generate_data(data_hash,title_ary)
  # start print pdf
  Prawn::Document.generate("pt5.pdf",:page_size=>[1071,792], :layout => :landscape) do
    page_num = 0
    page_string = ""
    total_page = page_count
    #puts "total_page = #{document_data_array.count}"
    (0..document_data_array.count-1).each do |page|
      if (page > 0)
        start_new_page
      end

      page_num = page_num + 1

      header(:us_std_fanfold, "東隆興業股份有限公司", "固定資產報廢統計表", "折舊期間: 103/06-103/06","","","#{page_num} / #{total_page}")

      (0..document_data_array[page].count-1).each do |i|
        table document_data_array[page][i] do
          row_number = document_data_array[page][i].count - 1 
          
          cells.borders = []    
          column(0).width = 60
          column(1).width = 60
          column(2).width = 80
          column(3).width = 220
          columns(4).width = 80
          column(5).width=80
          column(6).width=80
          column(7).width = 66
          column(8).width=64
          column(9).width=64
          column(10).width = 64
          column(11).width = 100

          cells.font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt003.ttf"
          cells.align = :right
          columns(0..6).align = :left
          cells.style(:size =>11)
          #row(0).column(6).style(:size => 6)
          case row_number
          when 0
          when 1
            row(0).padding = [2, 5, 0, 0]
            row(1).padding = [0, 5, 4, 0]
          when 2
            row(0).padding = [2, 5, 0, 0]
            row(1).padding = [0, 5, 0, 0]
            row(2).padding = [0, 5, 4, 0]
          else
            row(0).padding = [2, 5, 0, 0]
            rows(1..row_number-1).padding = [0, 5, 0, 0]
            row(row_number).padding = [0, 5, 4, 0]
          end
      
        end     
        if (i == 0)
          horizontal_line 0, 970
        elsif (i > 0)
          stroke do
            dash(3, space: 2, phase: 0)
            horizontal_line 0, 970
          end
          undash
        end
      end
    end
  end  
