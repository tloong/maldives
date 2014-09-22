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
  
  row_per_page = 44
  row_last = row_per_page
  data_array = data_hash.values
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
      
    data_ary.push(data_array[index])

    row_last = row_last - 1
    #將每一項加入table_array每33項後，
    if (row_last == 0 || index == data_array.count-1)
      # push data into table
      table_ary.push(data_ary)
      # push table into page
      page_ary.push(table_ary)
      # push data into table
      row_last = row_per_page
    end 
  end
  
  return [page_ary, page_num]
end

  # input1: query_date
  start_query_date = Date.new(2013,3,1)
  end_query_date = Date.new(2013,4,1)
  query_date = Date.new(2014,6,1)

  order_by = "changed_date"
  change_type = 0 # 0 transfer
  title_ary = ["異動單","轉移日","資產編號","資產名稱及規格","移出部門","原保管人","移入部門","新保管人","-","-","備註"]

  fc = FixedassetChanged.includes(:fixedasset).where("change_type = ? and changed_date < ? and changed_date >= ?",change_type,end_query_date,start_query_date).order(order_by)
  data_hash = {}

  fc.each do |fe|
    index = fe.id

    data_hash[index] = Hash.new

    #puts fe.id
    data_hash[index] = Array.new(11)
    data_hash[index][0] = "#{fe.voucher_no.to_s.rjust(6,'0')}" 
    tmp_year= fe.changed_date.year-1911
    if (tmp_year >= 100)
      tmp_year=tmp_year-100
    end
    data_hash[index][1] = "#{tmp_year.to_s.rjust(2,'0')}#{fe.changed_date.strftime('%m%d')}"
    data_hash[index][2] = fe.fixedasset.fixed_asset_id
    data_hash[index][3] = "#{fe.fixedasset.name}#{fe.fixedasset.spec}"
    data_hash[index][4] = "#{fe.old_department.dep_id} #{fe.old_department.alias}"
    data_hash[index][5] = ""
    data_hash[index][6] = "#{fe.department.dep_id} #{fe.department.alias}"
    data_hash[index][7] = ""
    data_hash[index][8] = ""
    data_hash[index][9] = ""
    data_hash[index][10] = fe.note
  end
  
  puts data_hash
  document_data_array,page_count = generate_data(data_hash,title_ary)
  # start print pdf
  Prawn::Document.generate("pt7.pdf",:page_size=>[1071,792], :layout => :landscape) do
    page_num = 0
    page_string = ""
    total_page = page_count
    (0..document_data_array.count-1).each do |page|
      if (page > 0)
        start_new_page
      end

      page_num = page_num + 1

      header(:us_std_fanfold, "東隆興業股份有限公司", "固定資產轉移統計表", "折舊期間: 103/06-103/06","","","#{page_num} / #{total_page}")

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
