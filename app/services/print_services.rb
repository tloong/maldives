class PrintServices < Struct.new(:pyear, :pmonth, :pacco)

  include ActionView::Helpers::NumberHelper

  #def initialize
  #end
  def error(job, exception)
    Rails.logger.info "======================================= running"
    Rails.logger.error "Job failed #{exception}"
    Delayed::Worker.logger.debug("Job failed #{exception}")
  end

  def success(job)
      Delayed::Worker.logger.debug("Job success")
  end
  
  def month_difference(end_date, start_date)
    (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
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

  def generate_data(data_hash,row_count,title_ary)

    page_ary = Array.new    #=> []
    table_ary = Array.new 
    data_ary = Array.new
    
      
    row_per_page = 33
    row_last = row_per_page

    data_array = data_hash.values
    total_sum_array = Array.new(13,0)
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
        puts " ******  new page ****** "
      end
      
      if (row_last == row_per_page)
        # 如果是新的一行, then 需放title
        data_ary.push(title_ary)
        table_ary.push(data_ary)
      end

      data_ary = Array.new
      sum_array = Array.new(13,0)

      (0..count-1).each do |j|
        puts "i=#{i}, j=#{j}"
        sum_array[0] = ""
        sum_array[1] = "小計:"
        sum_array[2] = sum_array[2] + data_array[i+j][2]
        sum_array[3] = sum_array[3] + data_array[i+j][3]
        sum_array[4] = sum_array[4] + data_array[i+j][4]
        sum_array[5] = sum_array[5] + data_array[i+j][5]
        sum_array[6] = sum_array[6] + data_array[i+j][6]
        sum_array[7] = sum_array[7] + data_array[i+j][7]
        sum_array[8] = sum_array[8] + data_array[i+j][8]
        sum_array[9] = sum_array[9] + data_array[i+j][9]
        sum_array[10] = sum_array[10] + data_array[i+j][10]
        sum_array[11] = sum_array[11] + data_array[i+j][11]
        sum_array[12] = sum_array[12] + data_array[i+j][12]
        data_array[i+j].map! {|a| (a==0)? "" : a}
        data_array[i+j].map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
        data_ary.push(data_array[i+j])
        
      end

      total_sum_array[2] = total_sum_array[2] + sum_array[2]
      total_sum_array[3] = total_sum_array[3] + sum_array[3]
      total_sum_array[4] = total_sum_array[4] + sum_array[4]
      total_sum_array[5] = total_sum_array[5] + sum_array[5]
      total_sum_array[6] = total_sum_array[6] + sum_array[6]
      total_sum_array[7] = total_sum_array[7] + sum_array[7]
      total_sum_array[8] = total_sum_array[8] + sum_array[8]
      total_sum_array[9] = total_sum_array[9] + sum_array[9]
      total_sum_array[10] = total_sum_array[10] + sum_array[10]
      total_sum_array[11] = total_sum_array[11] + sum_array[11]
      total_sum_array[12] = total_sum_array[12] + sum_array[12]

      sum_array.map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}

      data_ary.push(sum_array)
      table_ary.push(data_ary)
      row_last = row_last - count - 1
      i = i + count
    end
    total_sum_array.map! {|a| (a.is_a? Integer)? number_with_delimiter(a) : a}
    data_ary = Array.new
    data_ary.push(total_sum_array)
    table_ary.push(data_ary)
    page_ary.push(table_ary)
    puts page_ary
    return page_ary
  end


  #def do_print(year,month,acco)
  def perform
    year = pyear
    month = pmonth
    acco = pacco
    Rails.logger.info "===(#{year}, #{self.class}) running"  
    Delayed::Worker.logger.debug("Job start")

    # input1: query_date
    query_date = DateTime.new(year,month,Time.days_in_month(month,year),0,0,0)

    # input2: according_to (department or category)
    according_to = acco


    d84_date = DateTime.new(1997,1,1,0,0,0)
    today = DateTime.now
    this_year = DateTime.new(today.year,1,1,0,0,0)

    if according_to == "dep"
      sort_index1 = :department_id
      sort_index2 = :category_id
      order_by_index1 = "dep_depid"
      order_by_index2 = "category_id"
      title_ary = ["資產部門","資產種類","取得原價","預留殘值","重估後總值","重估後殘值","續提折舊總值","續提後殘值","應提折舊總額","本期折舊額","本年度折舊額","累計折舊額","未折減餘額"]
    elsif according_to == "cat"
      sort_index1 = :category_id
      sort_index2 = :department_id
      order_by_index1 = "category_id"
      order_by_index2 = "dep_depid"
      title_ary = ["資產種類","資產部門","取得原價","預留殘值","重估後總值","重估後殘值","續提折舊總值","續提後殘值","應提折舊總額","本期折舊額","本年度折舊額","累計折舊額","未折減餘額"]
    end

    f = Fixedasset.
                  select(
                  "id",
                  "departments.dep_id as dep_depid",
                  "departments.alias as dep_alias",
                  :category_id,
                  "sum(original_cost) as oc", 
                  "sum(final_scrap_value) as fsv", 
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

      data_hash[index] = Array.new(13)
     
      if according_to == "dep"
        if (row_count[fe.department_id] == 0)
          data_hash[index][0] = "#{fe.department.dep_id} #{fe.department.alias}"
        end
        data_hash[index][1] = "#{fe.category_id} #{fc.first.cat_name}"
        row_count[fe.department_id] = row_count[fe.department_id] + 1
      elsif according_to == "cat"
        if (row_count[fe.category_id] == 0)
          data_hash[index][0] = "#{fe.category_id} #{fc.first.cat_name}"
        end
        data_hash[index][1] = "#{fe.department.dep_id} #{fe.department.alias}"
        row_count[fe.category_id] = row_count[fe.category_id] + 1
      end

      data_hash[index][2] = fe.oc
      data_hash[index][3] = fe.fsv
      data_hash[index][4] = 0
      data_hash[index][5] = 0
      data_hash[index][6] = 0
      data_hash[index][7] = 0
      data_hash[index][8] = data_hash[index][2] - data_hash[index][3]
      data_hash[index][9] = 0
      data_hash[index][10] = 0
      data_hash[index][11] = 0
      data_hash[index][12] = 0  

      # for normal status fixedassets
      ff = Fixedasset.select(
                      :id,
                      :depreciated_value_per_month,
                      :depreciated_value_last_month,
                      :end_use_date,
                      :depreciation84,
                      :start_use_date).where("ab_type='A' and get_date <= ? and (typeof(fixedassets.out_date) = 'null' or out_date > ? ) and department_id = ? and category_id = ?",query_date,query_date,fe.department_id,fe.category_id)
      ff.each do |ffe|
        f_redep = FixedassetRedepreciation.
                          select(
                          :re_start_use_date,
                          :re_end_use_date,
                          :fixedasset_id
                          ).joins(:fixedasset).where("fixedassets.get_date <= ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedassets.id = ?",query_date,query_date,ffe.id)

        redep = f_redep.first
        e_date = get_end_date(ffe.end_use_date,redep)

        if ffe.start_use_date > e_date
          next
        end

        if (month_difference(e_date,query_date)==0)
          data_hash[index][9] = data_hash[index][9] + ffe.depreciated_value_last_month
          data_hash[index][10] = data_hash[index][10] + ffe.depreciated_value_per_month * (month_difference(query_date,this_year)) + ffe.depreciated_value_last_month 
          
          if (ffe.depreciation84 > 0)
            data_hash[index][11] = data_hash[index][11] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(query_date,d84_date)) + ffe.depreciated_value_last_month 
          else
            data_hash[index][11] = data_hash[index][11] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
          end
        elsif (month_difference(e_date,query_date)<0)
            if (month_difference(e_date,this_year)>0)
              data_hash[index][10] = data_hash[index][10] + ffe.depreciated_value_per_month * (month_difference(e_date,this_year)) + ffe.depreciated_value_last_month 
            end
          if (ffe.depreciation84 > 0)
            data_hash[index][11] = data_hash[index][11] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(e_date,d84_date)) + ffe.depreciated_value_last_month 
          else
            data_hash[index][11] = data_hash[index][11] + ffe.depreciated_value_per_month * (month_difference(e_date,ffe.start_use_date)) + ffe.depreciated_value_last_month 
          end  
        elsif (month_difference(query_date,ffe.start_use_date)>=0)
          data_hash[index][9] = data_hash[index][9] + ffe.depreciated_value_per_month
          data_hash[index][10] = data_hash[index][10] + ffe.depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          if (ffe.depreciation84 > 0)
            data_hash[index][11] = data_hash[index][11] + ffe.depreciation84 + ffe.depreciated_value_per_month * (month_difference(query_date,d84_date)+1)  
          else
            data_hash[index][11] = data_hash[index][11] + ffe.depreciated_value_per_month * (month_difference(query_date,ffe.start_use_date) +1)
          end  

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
                          :re_end_use_date,
                          :fixedasset_id
                          ).joins(:fixedasset).where("fixedassets.ab_type='A' and fixedassets.get_date <= ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedassets.department_id = ? and fixedassets.category_id = ?",query_date,query_date,fe.department_id,fe.category_id)

      f_redep.each do |ffe|
        #if ffe.re_start_use_date < ffe.fixedasset.end_use_date
        #  next
        #end
        data_hash[index][8] = data_hash[index][8] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[index][6] = data_hash[index][6] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[index][7] = data_hash[index][7] + ffe.re_final_scrap_value  

        if (month_difference(ffe.re_end_use_date,query_date)==0)
          data_hash[index][9] = data_hash[index][9] + ffe.re_depreciated_value_last_month
          data_hash[index][10] = data_hash[index][10] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year)) + ffe.re_depreciated_value_last_month 
          data_hash[index][11] = data_hash[index][11] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 
        elsif (month_difference(ffe.re_end_use_date,query_date)<0)
            if (month_difference(ffe.re_end_use_date,this_year)>0)
              data_hash[index][10] = data_hash[index][10] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,this_year)) + ffe.re_depreciated_value_last_month 
            end
          data_hash[index][11] = data_hash[index][11] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 
        elsif (month_difference(query_date,ffe.re_start_use_date)>=0)
          data_hash[index][9] = data_hash[index][9] + ffe.re_depreciated_value_per_month
          data_hash[index][10] = data_hash[index][10] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          data_hash[index][11] = data_hash[index][11] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date) +1)
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
                    :id).where("fixedassets.ab_type='A' and get_date <= ? and fixedassets.category_id != ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedasset_changeds.change_type=3",query_date,1,query_date)

    f_reev.each do |reev|
      index = "#{reev.department_id}_#{reev.category_id}"
      #puts "index = #{index}, id = #{reev.id}"
      tmp_f = Fixedasset.find(reev.id)

      data_hash[index][4] = reev.evaluated_value
      data_hash[index][5] = reev.evaluated_scrap_value
      data_hash[index][8] = data_hash[index][8] + (data_hash[index][4] - tmp_f.original_cost) - (data_hash[index][5] - tmp_f.final_scrap_value) 
      data_hash[index][12] = reev.evaluated_scrap_value - tmp_f.final_scrap_value
    end


    # 把query日期到現在之間部門有改過的找出來  由新到舊 rollback 
    f_chd = Fixedasset.joins(:fixedasset_changeds).select(
                          :id,
                          "fixedasset_changeds.old_department_id",
                          "fixedassets.department_id",
                          "fixedassets.fixed_asset_id").where("fixedasset_changeds.changed_date > ? and fixedasset_changeds.changed_date < ? and fixedassets.ab_type='A' and fixedassets.category_id != ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedasset_changeds.change_type=0",query_date,today,1,query_date)

    # 將這筆記錄的所有值都移到其舊有部門. 
    f_chd.each do |chd|
      puts "chd.id=#{chd.id}"
      cat_id = chd.fixed_asset_id[3].to_i

      f_tmp = Fixedasset.find(chd.id)

      src_index = "#{chd.department_id}_#{cat_id}"
      dst_index = "#{chd.old_department_id}_#{cat_id}"

      data_hash[src_index][2] = data_hash[src_index][2] - f_tmp.original_cost
      data_hash[dst_index][2] = data_hash[dst_index][2] + f_tmp.original_cost
      
      data_hash[src_index][3] = data_hash[src_index][3] - f_tmp.final_scrap_value
      data_hash[dst_index][3] = data_hash[dst_index][3] + f_tmp.final_scrap_value

      data_hash[src_index][8] = data_hash[src_index][8] - f_tmp.original_cost + f_tmp.final_scrap_value
      data_hash[dst_index][8] = data_hash[dst_index][8] + f_tmp.original_cost - f_tmp.final_scrap_value

      f_redep = FixedassetRedepreciation.
                        select(
                        :re_start_use_date,
                        :re_end_use_date,
                        :fixedasset_id
                        ).joins(:fixedasset).where("fixedassets.get_date <= ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedassets.id = ?",query_date,query_date,chd.id)

      redep = f_redep.first
      if redep == nil
        if (month_difference(f_tmp.end_use_date,query_date)==0)
            data_hash[src_index][9] = data_hash[src_index][9] - f_tmp.depreciated_value_last_month
            data_hash[dst_index][9] = data_hash[dst_index][9] + f_tmp.depreciated_value_last_month
            
            data_hash[src_index][10] = data_hash[src_index][10] - f_tmp.depreciated_value_per_month * (month_difference(query_date,this_year)) - f_tmp.depreciated_value_last_month 
            data_hash[dst_index][10] = data_hash[dst_index][10] + f_tmp.depreciated_value_per_month * (month_difference(query_date,this_year)) + f_tmp.depreciated_value_last_month 
            
            data_hash[src_index][11] = data_hash[src_index][11] - f_tmp.depreciated_value_per_month * (month_difference(query_date,f_tmp.start_use_date)) - f_tmp.depreciated_value_last_month 
            data_hash[dst_index][11] = data_hash[dst_index][11] + f_tmp.depreciated_value_per_month * (month_difference(query_date,f_tmp.start_use_date)) + f_tmp.depreciated_value_last_month 
        elsif (month_difference(f_tmp.end_use_date,query_date)<0)
            if (month_difference(f_tmp.end_use_date,this_year)>0)
              data_hash[src_index][10] = data_hash[src_index][10] - f_tmp.depreciated_value_per_month * (month_difference(f_tmp.end_use_date,this_year)) - f_tmp.depreciated_value_last_month 
              data_hash[dst_index][10] = data_hash[dst_index][10] + f_tmp.depreciated_value_per_month * (month_difference(f_tmp.end_use_date,this_year)) + f_tmp.depreciated_value_last_month 
            end
          data_hash[src_index][11] = data_hash[src_index][11] - f_tmp.depreciated_value_per_month * (month_difference(f_tmp.end_use_date,f_tmp.start_use_date)) - f_tmp.depreciated_value_last_month 
          data_hash[dst_index][11] = data_hash[dst_index][11] + f_tmp.depreciated_value_per_month * (month_difference(f_tmp.end_use_date,f_tmp.start_use_date)) + f_tmp.depreciated_value_last_month 
        else
          data_hash[src_index][9] = data_hash[src_index][9] - f_tmp.depreciated_value_per_month
          data_hash[dst_index][9] = data_hash[dst_index][9] + f_tmp.depreciated_value_per_month

          data_hash[src_index][10] = data_hash[src_index][10] - f_tmp.depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          data_hash[dst_index][10] = data_hash[dst_index][10] + f_tmp.depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          
          data_hash[src_index][11] = data_hash[src_index][11] - f_tmp.depreciated_value_per_month * (month_difference(query_date,f_tmp.start_use_date) +1)
          data_hash[dst_index][11] = data_hash[dst_index][11] + f_tmp.depreciated_value_per_month * (month_difference(query_date,f_tmp.start_use_date) +1)
        end
      end

      f_redep = FixedassetRedepreciation.
                          select(
                          :re_original_value,
                          :re_final_scrap_value,
                          :re_depreciated_value_per_month,
                          :re_depreciated_value_last_month,
                          :re_start_use_date,
                          :re_end_use_date
                          ).joins(:fixedasset).where("fixedassets.id = ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? )",chd.id,query_date)

      f_redep.each do |ffe|
        puts "2"
        data_hash[src_index][8] = data_hash[src_index][8] - ffe.re_original_value + ffe.re_final_scrap_value
        data_hash[src_index][6] = data_hash[src_index][6] - ffe.re_original_value + ffe.re_final_scrap_value
        data_hash[src_index][7] = data_hash[src_index][7] - ffe.re_final_scrap_value  
        
        data_hash[dst_index][8] = data_hash[dst_index][8] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[dst_index][6] = data_hash[dst_index][6] + ffe.re_original_value - ffe.re_final_scrap_value
        data_hash[dst_index][7] = data_hash[dst_index][7] + ffe.re_final_scrap_value  

        if (month_difference(ffe.re_end_use_date,query_date)==0)
          data_hash[src_index][9] = data_hash[src_index][9] - ffe.re_depreciated_value_last_month
          data_hash[src_index][10] = data_hash[src_index][10] - ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year)) - ffe.re_depreciated_value_last_month 
          data_hash[src_index][11] = data_hash[src_index][11] - ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date)) - ffe.re_depreciated_value_last_month 
      
          data_hash[dst_index][9] = data_hash[dst_index][9] + ffe.re_depreciated_value_last_month
          data_hash[dst_index][10] = data_hash[dst_index][10] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year)) + ffe.re_depreciated_value_last_month 
          data_hash[dst_index][11] = data_hash[dst_index][11] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 

        elsif (month_difference(ffe.re_end_use_date,query_date)<0)
            if (month_difference(ffe.re_end_use_date,this_year)>0)
              data_hash[src_index][10] = data_hash[src_index][10] - ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,this_year)) - ffe.re_depreciated_value_last_month 
              data_hash[dst_index][10] = data_hash[dst_index][10] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,this_year)) + ffe.re_depreciated_value_last_month 
            end
          data_hash[src_index][11] = data_hash[src_index][11] - ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,ffe.re_start_use_date)) - ffe.re_depreciated_value_last_month 
          data_hash[dst_index][11] = data_hash[dst_index][11] + ffe.re_depreciated_value_per_month * (month_difference(ffe.re_end_use_date,ffe.re_start_use_date)) + ffe.re_depreciated_value_last_month 
        else
          data_hash[src_index][9] = data_hash[src_index][9] - ffe.re_depreciated_value_per_month
          data_hash[src_index][10] = data_hash[src_index][10] - ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          data_hash[src_index][11] = data_hash[src_index][11] - ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date) +1)

          data_hash[dst_index][9] = data_hash[dst_index][9] + ffe.re_depreciated_value_per_month
          data_hash[dst_index][10] = data_hash[dst_index][10] + ffe.re_depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          data_hash[dst_index][11] = data_hash[dst_index][11] + ffe.re_depreciated_value_per_month * (month_difference(query_date,ffe.re_start_use_date) +1)
        end
      end     

      # for reevaluation fixedassets
      f_reev = Fixedasset.joins(:fixedasset_changeds).
                    select(
                      :category_id,
                      :evaluated_value,
                      :evaluated_scrap_value,
                      "fixedassets.department_id",
                      :id).where("fixedassets.id = ? and (typeof(fixedassets.out_date) = 'null' or fixedassets.out_date > ? ) and fixedasset_changeds.change_type=3",chd.id,query_date)

      f_reev.each do |reev|
        puts "3"
        data_hash[src_index][4] = data_hash[src_index][4] - reev.evaluated_value
        data_hash[src_index][5] = data_hash[src_index][5] - reev.evaluated_scrap_value
        data_hash[src_index][8] = data_hash[src_index][8] - (reev.evaluated_value - f_tmp.original_cost) + (reev.evaluated_scrap_value - f_tmp.final_scrap_value) 
        data_hash[src_index][12] = data_hash[src_index][12] - reev.evaluated_scrap_value + f_tmp.final_scrap_value

        data_hash[dst_index][4] = data_hash[dst_index][4] + reev.evaluated_value
        data_hash[dst_index][5] = data_hash[dst_index][5] + reev.evaluated_scrap_value
        data_hash[dst_index][8] = data_hash[dst_index][8] + (reev.evaluated_value - f_tmp.original_cost) - (reev.evaluated_scrap_value - f_tmp.final_scrap_value) 
        data_hash[dst_index][12] = data_hash[dst_index][12] + reev.evaluated_scrap_value - f_tmp.final_scrap_value
      end
    end





    # calculate 未折減餘額 = index[] 6 - 9 + 1 - 4
    data_hash.each do |k,v|
      #puts "index = #{k}"
      v[12] = v[12] + v[8] - v[11] + v[3] - v[6]
    end

    puts data_hash.to_yaml
    puts row_count.to_yaml
    puts data_hash.count
    document_data_array = generate_data(data_hash,row_count,title_ary)
    puts document_data_array.count
    #puts data_hash.values
    #row_count.each do |data_set|
    #  puts data_set
    #end

    # start print pdf
    Prawn::Document.generate(Rails.root.to_s+"/public/fixedassets_pdf/各部門折舊明細表_#{year}_#{month}_#{acco}.pdf",:page_size=>[1071,792], :layout => :landscape) do

  def header(page_size,title, subtitle, left1, left2, right1, page_number)
    stroke_color "000000"
    #font("/System/Library/Fonts/gkai00mp.ttf") do
    font("/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/pmingliu.ttf") do
      text title, :size => 18, :align => :center
      text_box right1, :size => 10, :at => [915, 710], :width => 80, :align => :right
      text_box left1, :size => 10, :at => [0, 710], :width => 100, :align => :left
      text_box left2, :size => 10, :at => [0, 695], :width => 100, :align => :left
      text_box "頁次:#{page_number}", size: 10, :at => [915,695], :width => 80, :align => :right
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
      
      (0..document_data_array.count-1).each do |page|
        if (page > 0)
          start_new_page
        end
        header(:us_std_fanfold, "東隆興業股份有限公司", "各部門折舊明細表", "折舊期間: #{year}/#{month}","","折舊方法:平均法",page+1)

        (0..document_data_array[page].count-1).each do |i|
          table document_data_array[page][i] do
            row_number = document_data_array[page][i].count - 1 
            case row_number
            when 0
            when 1
              row(0).padding = [2, 5, 4, 0]
            when 2
              row(0).padding = [2, 5, 0, 0]
              row(1).padding = [0, 5, 4, 0]
            when 3
              row(0).padding = [2, 5, 0, 0]
              row(1).padding = [0, 5, 0, 0]
              row(2).padding = [0, 5, 4, 0]
            else
              row(0).padding = [2, 5, 0, 0]
              rows(1..row_number-2).padding = [0, 5, 0, 0]
              row(row_number-1).padding = [0, 5, 4, 0]
            end
          
            cells.borders = []    
            if according_to == "dep"
              column(0).width = 83
              column(1).width = 77
            else
              column(0).width = 77
              column(1).width = 83
            end
            column(2).width = 74
            
            column(3).width = 68
            columns(4..5).width = 72
            column(6).width=85
            column(7).width=70
            column(8).width = 84
            column(9).width=70
            columns(10..11).width = 84
            column(12).width = 75
            cells.font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/pmingliu.ttf"
            cells.align = :right
            columns(0..1).align = :left

            if (i>0 && row_number >0)
              row(row_number-1).columns(2..12).border_lines = [:dashed]
              row(row_number-1).columns(2..12).borders = [:bottom]
              #row(3).borders = [:bottom]
              #column(0).font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt024.ttf"
              #column(1).font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/document_data_array[page]/fonts/wt024.ttf"
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