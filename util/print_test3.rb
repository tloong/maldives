    include ActionView::Helpers::NumberHelper

    def month_difference(end_date, start_date)
      (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
    end


    def header(page_size,title, subtitle, left1, left2, right1, page_number)
      stroke_color "000000"

      if page_size == :a4
        r1_x = 445
        r1_y = 760
        r2_x = 445
        r2_y = 745
        l1_x = 0
        l1_y = 760
        l2_x = 0
        l2_y = 745
        l_width=300
        r_width=80
      elsif page_size == :us_std_fanfold
        r1_x = 915
        r1_y = 710
        r2_x = 915
        r2_y = 695
        l1_x = 0
        l1_y = 710
        l2_x = 0
        l2_y = 695
        l_width=300
        r_width=80
      end


      #font("/System/Library/Fonts/gkai00mp.ttf") do
      font(Rails.root.to_s+"/resources/fonts/wt003.ttf") do
        text title, :size => 18, :align => :center
        text_box right1, :size => 10, :at => [r1_x, r1_y], :width => r_width, :align => :right
        text_box left1, :size => 10, :at => [l1_x, l1_y], :width => l_width, :align => :left
        text_box left2, :size => 10, :at => [l2_x, l2_y], :width => l_width, :align => :left
        text_box "頁次: #{page_number}", size: 10, :at => [r2_x,r2_y], :width => r_width, :align => :right
        text subtitle, size: 18, :align => :center
        stroke do
          move_down 3
          dash(3, space: 1, phase: 0)
          horizontal_rule
          move_down 3
          horizontal_rule
        end
        undash
      end
    end


    def generate_data(data_hash,row_count,title_ary)

      page_ary = Array.new    #=> []
      table_ary = Array.new 
      data_ary = Array.new
      
      row_per_page = 40
      row_last = row_per_page

      data_array = data_hash.values
      total_sum_array = Array.new(7,0)
      total_sum_array[0] = ""
      total_sum_array[1] = "總計:"
      i = 0
      # deal with by department or category.
      row_count.each do |dep, count|
        
        if (row_last < count)
          # 如已經不夠放新的section, then 換頁
          page_ary.push(table_ary)
          table_ary = Array.new
          data_ary = Array.new
          row_last = row_per_page
          #puts " ******  new page ****** "
        end
        
        if (row_last == row_per_page)
          # 如果是新的一行, then 需放title
          data_ary.push(title_ary)
          table_ary.push(data_ary)
        end

        data_ary = Array.new
        sum = 0

        (0..count-1).each do |j|
          #puts "i=#{i}, j=#{j}"
          sum = sum + data_array[i+j][4]
          if (j == count - 1)
            data_array[i+j][5] = sum
          end
          data_array[i+j].map! {|a| (a==0)? "" : a}
          data_array[i+j].map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
          data_ary.push(data_array[i+j])
        end
        
        total_sum_array[4] = total_sum_array[4] + sum
        table_ary.push(data_ary)
        row_last = row_last - count
        i = i + count
      end
      total_sum_array.map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
      data_ary = Array.new
      data_ary.push(total_sum_array)
      table_ary.push(data_ary)
      page_ary.push(table_ary)
      #puts page_ary
      return page_ary
    end

    # input1: query_date
    query_date = DateTime.new(2014,6,1,0,0,0)

    # input2: according_to (department or category)
    according_to = :cat


    today = DateTime.now
    this_year = DateTime.new(today.year,1,1,0,0,0)

    if according_to == :dep
      sort_index1 = :department_id
      sort_index2 = :category_id
      order_by_index1 = "dep_depid"
      order_by_index2 = "category_id"
      title_ary = ["部門代號","部門名稱","資產代號","資產種類","本期折舊額","折舊額小計","備註"]
    elsif according_to == :cat
      sort_index1 = :category_id
      sort_index2 = :department_id
      order_by_index1 = "category_id"
      order_by_index2 = "dep_depid"
      title_ary = ["資產代號","資產種類","部門代號","部門名稱","本期折舊額","折舊額小計","備註"]
    end

    f = Fixedasset.
                  select(
                  "id",
                  "departments.dep_id as dep_depid",
                  "departments.alias as dep_alias",
                  :category_id,
                  :department_id).joins(:department).where("ab_type='A' and get_date <= ? and category_id != ? and (typeof(fixedassets.out_date) = 'null' or out_date>?)", query_date,1, query_date).group(sort_index1, sort_index2).order(order_by_index1, order_by_index2)

    data_hash = {}
    row_count = {}
    row_count.default = 0 # 計算分類後資料有幾個row, 畫分隔線使用
    today = DateTime.now
    this_year = DateTime.new(today.year,1,1,0,0,0)

    dep_index = f.first.department_id
    cat_index = f.first.category_id

    f.each do |fe|
      
      index = "#{fe.department_id}_#{fe.category_id}"
      fc = FixedassetCategory.select(:cat_name).where("cat_id = ?", fe.category_id)

      data_hash[index] = Array.new(7)
     
      if according_to == :dep  
        data_hash[index][0] = "#{fe.department.dep_id}"
        data_hash[index][1] = "#{fe.department.alias}"
        data_hash[index][2] = "#{fe.category_id}"
        data_hash[index][3] = "#{fc.first.cat_name}"
        #row_count[fe.department_id] = row_count[fe.department_id] + 1
      elsif according_to == :cat
        data_hash[index][0] = "#{fe.category_id}"
        data_hash[index][1] = "#{fc.first.cat_name}"
        data_hash[index][2] = "#{fe.department.dep_id}"
        data_hash[index][3] = "#{fe.department.alias}"
        row_count[fe.category_id] = row_count[fe.category_id] + 1
      end

      data_hash[index][4] = 0
      data_hash[index][5] = ""
      data_hash[index][6] = ""
      # for normal status fixedassets
      ff = Fixedasset.select(
                      :id,
                      :depreciated_value_per_month,
                      :depreciated_value_last_month,
                      :end_use_date,
                      :start_use_date).where("get_date <= ? and ab_type='A' and (typeof(fixedassets.out_date) = 'null' or out_date > ? ) and department_id = ? and category_id = ?",query_date,query_date,fe.department_id,fe.category_id)
      ff.each do |ffe|

        redep = ffe.fixedasset_redepreciation
        e_date = get_end_date(ffe.end_use_date,redep)

        if ffe.start_use_date > e_date
          next
        end

        if (month_difference(e_date,query_date)==0)
          data_hash[index][4] = data_hash[index][4] + ffe.depreciated_value_last_month
        elsif (month_difference(e_date,query_date)>0 && month_difference(query_date,ffe.start_use_date)>=0)
          data_hash[index][4] = data_hash[index][4] + ffe.depreciated_value_per_month
        end
      end

      # for redepreciated fixedassets
      f_redep = FixedassetRedepreciation.
                          select(
                          :re_original_value,
                          :re_final_scrap_value,
                          :re_depreciated_value_per_month,
                          :re_depreciated_value_last_month,
                          :re_start_use_date,
                          :re_end_use_date
                          ).joins(:fixedasset).where("fixedassets.get_date <= ? and fixedassets.ab_type='A' and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedassets.department_id = ? and fixedassets.category_id = ?",query_date,query_date,fe.department_id,fe.category_id)

      f_redep.each do |ffe|
        if (month_difference(ffe.re_end_use_date,query_date)==0)
          data_hash[index][4] = data_hash[index][4] + ffe.re_depreciated_value_last_month
        elsif (month_difference(ffe.re_end_use_date,query_date)>0 && (month_difference(query_date,ffe.re_start_use_date)>=0))
          data_hash[index][4] = data_hash[index][4] + ffe.re_depreciated_value_per_month
        end
      end                          
    end


    #puts data_hash.to_yaml
    #puts row_count.to_yaml
    #puts data_hash.count

    # process hash, need to separate 0000 to 2xxx and 1261 to 1xxx
    if (according_to == :dep)
    # process hash, need to separate 0000 to 2xxx and 1261 to 1xxx
      d = Department.find_by_dep_id("0000")
      dep0 = d.id
      d = Department.find_by_dep_id("1261")
      dep1 = d.id
      parts = {}
      
      # collection key to be process
      data_hash.each do |key, value|
        tmp = key.index("_")
        depart = key[0..tmp-1].to_i
      
        slen = key.length
        category = key[tmp+1..slen-1].to_i
        
        if depart == dep0   # 0000 桃園
          if category == 5
            parts[key] = 3
          else
            parts[key] = 2
          end
        elsif depart == dep1
          parts[key] = 1
        end
      end

      #puts parts.count

      parts.each do |key, part_no|
        tmp = key.index("_")
        depart = key[0..tmp-1].to_i
      
        slen = key.length
        category = key[tmp+1..slen-1].to_i

        #puts "department_id = #{depart} and part_no = #{part_no}"
        # 找出要share的parts
        fp_set = FixedassetPart.where("department_id = ? and part_no = ?", depart, part_no)

        fp_set.each do |fp|
          shared_department_id = fp.refed_department_id
          weight = fp.weight
          index = "#{shared_department_id}_#{category}"
          #puts index

          d = Department.find(shared_department_id)

          if (data_hash.has_key?(index))
            data_hash[index][4] = (data_hash[index][4] + (data_hash[key][4] * weight/100)).round
          else
            fc = FixedassetCategory.select(:cat_name).where("cat_id = ?", category)
            data_hash[index] = Array.new(7)
            if according_to == :dep
              data_hash[index][0] = "#{d.dep_id}"
              data_hash[index][1] = "#{d.alias}"
              data_hash[index][2] = "#{category}"
              data_hash[index][3] = "#{fc.first.cat_name}"
              #row_count[shared_department_id] = row_count[shared_department_id] + 1
            elsif according_to == :cat
              data_hash[index][0] = "#{category}"
              data_hash[index][1] = "#{fc.first.cat_name}"
              data_hash[index][2] = "#{d.dep_id}"
              data_hash[index][3] = "#{d.alias}"
              #row_count[category] = row_count[category] + 1
            end

            data_hash[index][4] = (data_hash[key][4] * weight / 100).round
            data_hash[index][5] = ""
            data_hash[index][6] = ""
            
          end
        end
        data_hash.except!(key)

      end    
data_hash = Hash[data_hash.sort_by{|k,v| "#{v[0]}#{v[2]}"}]

    #calculate row_count

    data_hash.each do |k,v|
      tmp = k.index("_")
      depart = k[0..tmp-1].to_i

      row_count[depart] = row_count[depart] + 1
    end
    elsif (according_to == :cat)

    end




    

    document_data_array = generate_data(data_hash,row_count,title_ary)

    Prawn::Document.generate("dd.pdf",:page_size=>"A4", :layout => :landscape) do #[1071,792]
      
      (0..document_data_array.count-1).each do |page|
        if (page > 0)
          start_new_page
        end
        header(:a4, "東隆興業股份有限公司", "各部門折舊明細表", "折舊期間: 103/06-103/06","","折舊方法:平均法",page+1)

        (0..document_data_array[page].count-1).each do |i|
          table document_data_array[page][i] do
            row_number = document_data_array[page][i].count - 1 
            puts "row_number=#{row_number}"
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
          
            cells.borders = []    
            column(0).width = 82
            column(1).width = 72
            columns(2..3).width = 67
            columns(4..5).width = 75
            column(6).width=85

            cells.font = Rails.root.to_s+"/resources/fonts/wt003.ttf"
            cells.align = :right
            columns(0..1).align = :left
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

