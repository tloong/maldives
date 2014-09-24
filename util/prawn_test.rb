# encoding: utf-8
#
# The document outline tree is the set of links used to navigate through the
# various document sections and pages.
#
# To define the document outline we first use the <code>outline</code>
# method to lazily instantiate an outline object. Then we use the
# <code>define</code> method with a block to start the outline tree.
#
# The basic methods for creating outline nodes are <code>section</code> and
# <code>page</code>. The only difference between the two is that
# <code>page</code> doesn't accept a block and will only create leaf nodes
# while <code>section</code> accepts a block to create nested nodes.
#
# <code>section</code> accepts the title of the section and two options:
# <code>:destination</code> - a page number to link and <code>:closed</code> -
# a boolean value that defines if the nested outline nodes are shown when the
# document is open (defaults to true).
#
# <code>page</code> is very similar to section. It requires a
# <code>:title</code> option to be set and accepts a <code>:destination</code>.
#
# <code>section</code> and <code>page</code> may also be used without the
# <code>define</code> method but they will need to instantiate the
# <code>outline</code> object every time.
#

def header(page_size,title, subtitle, left1, left2, right1, page_number)
  stroke_color "000000"
  #font("/System/Library/Fonts/gkai00mp.ttf") do
  font(Rails.root.to_s+"/resources/fonts/wt003.ttf") do
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



Prawn::Document.generate("bbb.pdf",:page_size=>[1071,792], :layout => :landscape) do

  (0..1).each do |page|
    if (page > 0)
      start_new_page
    end
    header(:us_std_fanfold, "東隆興業股份有限公司", "各部門折舊明細表", "折舊期間: 103/05-103/05","","折舊方法:平均法",1)

    # generate data

    # the following is ok for fixedassets only fields
    f = Fixedasset.
                  select(
                  "id",
                  "departments.dep_id as dep_depid",
                  "departments.alias as dep_alias",
                  :category_id,
                  "sum(original_cost) as oc", 
                  "sum(final_scrap_value) as fsv", 
                  :department_id).joins(:department).where("ab_type='A' and status<6").group(:department_id, :category_id).order("dep_depid")


    # the following is ok for fixedassets only fields
    f = Fixedasset.
                  select(
                  "id",
                  "departments.dep_id as dep_depid",
                  "departments.alias as dep_alias",
                  :category_id,
                  "sum(original_cost) as oc", 
                  "sum(final_scrap_value) as fsv", 
                  :department_id).joins(:department).where("ab_type='A' and typeof(fixedassets.out_date) = 'null'", DateTime.now).group(:department_id, :category_id).order("dep_depid")

    f_redep = Fixedasset.joins(:department,:fixedasset_redepreciation).
                        select(
                          "departments.dep_id as dep_depid",
                          "departments.alias as dep_alias",
                          :category_id, 
                          "sum(re_original_value) as foc",
                          "sum(re_final_scrap_value) as rfsv",
                          :department_id,
                          :id).where("ab_type='A' and status<6").group(:department_id,:category_id).order("dep_depid")

    f_reev = Fixedasset.joins(:fixedasset_changeds).
                        select(
                          :category_id,
                          :evaluated_value,
                          :evaluated_scrap_value,
                          "fixedassets.department_id",
                          :id).where("ab_type='A' and status<6 and fixedasset_changeds.change_type=3")

    

    data_hash = {}

    f.each do |fe|
      index = "#{fe.department_id}_#{fe.category_id}"
      puts index
      puts "#{fe.department.dep_id}"
      data_hash[index] = Array.new(11)
      data_hash[index][0] = fe.oc
      data_hash[index][1] = fe.fsv
      data_hash[index][2] = 0
      data_hash[index][3] = 0
      data_hash[index][6] = data_hash[index][0] - data_hash[index][1]
    end

    f_redep.each do |kk|
      index = "#{kk.department_id}_#{kk.category_id}"
      puts index
      puts "#{kk.department.dep_id}"
      data_hash[index][4] = kk.foc - kk.rfsv
      data_hash[index][5] = kk.rfsv
      data_hash[index][6] = data_hash[index][6] + data_hash[index][4]
    end

    puts data_hash.to_yaml

    f_reev.each do |reev|
      index = "#{reev.department_id}_#{reev.category_id}"
      tmp_f = Fixedasset.find(reev.id)

      data_hash[index][2] = reev.evaluated_value
      data_hash[index][3] = reev.evaluated_scrap_value
      data_hash[index][6] = data_hash[index][6] + (data_hash[index][2] - tmp_f.original_cost) - (data_hash[index][3] - tmp_f.final_scrap_value) 
    end

    puts "xxxxx"
    puts data_hash.to_yaml
    

    data = [[["資產部門","資產種類","取得原價","預留殘值","重估後總值","重估後殘值","續提折舊總值","續提後殘值","應提折舊總額","本期折舊額","本年度折舊額","本年度折舊額","未折減餘額"]],
           [["0000 不分部門","3 建築物", "212,907,667", "11,279,839", "13,007,180", "470,118", "1,097,331", "365,777", "206,478,795", "747,553", "3,956,732", "112,539,420", "104,299,222"],
            ["","5 電器設備", "52,279,840", "4,486,393", "", "", "1,583,141", "527,714", "49,376,585", "205,768", "1,279,054", "42,263,743", "10,016,097"],
            ["","小計:", "265,187,507", "15,766,232", "13,007,180", "470,118", "2,680,472", "893,491", "255,855,380", "953,321", "5,235,786", "154,803,163", "114,315,319"]],
           [["1261 板橋P","3 建築物", "59,559,612", "2,112,091", "", "", "294,188", "98,063", "57,741,708", "145,432", "891,166", "27,964,566", "31,595,046"],
            ["","6 生財器具", "4,140,668", "704,182", "", "", "297,619", "99,206", "3,374,105", "6,212", "75,638", "3,512,711", "627,957"],
            ["","9 雜項設備", "30,000", "5,000", "", "", "", "", "25,000", "0", "0", "25,000", "5,000"],
            ["","小計:", "63,730,000", "2,821,273", "0", "0", "591,807", "197,269", "61,500,813", "151,644", "966,804", "31,502,277", "32,228,003"]]] 
    
    (0..data.count-1).each do |i|
      table data[i] do
        row_number = data[i].count - 1 
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
          rows(1..row_number-1).padding = [0, 5, 0, 0]
          row(row_number).padding = [0, 5, 4, 0]
        end
      
        cells.borders = []    
        column(0).width = 90
        column(1).width = 70
        columns(2..3).width = 67
        columns(4..5).width = 75
        column(6).width=85
        column(7).width=70
        column(8).width = 85
        column(9).width=70
        columns(10..11).width = 85
        column(12).width = 75
        cells.font = Rails.root.to_s+"/resources/fonts/wt003.ttf"
        cells.align = :right
        columns(0..1).align = :left

        if (i>0)
          row(row_number-1).columns(2..12).border_lines = [:dashed]
          row(row_number-1).columns(2..12).borders = [:bottom]
          #row(3).borders = [:bottom]
          #column(0).font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt024.ttf"
          #column(1).font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt024.ttf"
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