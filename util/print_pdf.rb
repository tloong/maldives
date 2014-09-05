
def header(page_size,title, subtitle, left1, left2, right1, page_number)
  stroke_color "000000"
  #font("/System/Library/Fonts/gkai00mp.ttf") do
  font("/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt024.ttf") do
    text title, :size => 18, :align => :center
    text_box right1, :size => 10, :at => [445, 760], :width => 80, :align => :right
    text_box left1, :size => 10, :at => [0, 760], :width => 100, :align => :left
    text_box left2, :size => 10, :at => [0, 745], :width => 100, :align => :left
    text_box "頁次: #{page_number}", size: 10, :at => [445,745], :width => 80, :align => :right
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

title_ary = ["部門代號","部門名稱","資產代號","資產種類","本期折舊額","折舊額小計","備註"]

document_data_array=[[[
  title_ary,["0000","不分部門","3","建築物","2,000,000","",""],["","","5","電器設備","2,000,000","4,000,000",""],
                      ]]]

# start print pdf 
Prawn::Document.generate("dd.pdf",:page_size=>"A4", :layout => :landscape) do
  
  (0..document_data_array.count-1).each do |page|
    if (page > 0)
      start_new_page
    end
    header(:a4, "東隆興業股份有限公司", "各部門折舊明細表", "折舊期間: 103/06-103/06","","折舊方法:平均法",page+1)

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
        column(0).width = 82
        column(1).width = 72
        columns(2..3).width = 67
        columns(4..5).width = 75
        column(6).width=85

        cells.font = "/Users/jakobcho/.rvm/gems/ruby-2.0.0-p481/gems/prawn-1.2.1/data/fonts/wt024.ttf"
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