require 'dbf'
def month_difference(end_date, start_date)
  year_diff = end_date.year - start_date.year
  month_diff = end_date.month - start_date.month

  if (month_diff < 0)
    year_diff = year_diff - 1
    month_diff = month_diff + 12
  end
  total_month = year_diff * 12 + month_diff
end

CONN = ActiveRecord::Base.connection

fixedassets = DBF::Table.new("./util/FIX0.DBF", nil, 'big5')

inserts = []
puts "total count:" + fixedassets.count.to_s
i = 0
j = 0
fd = nil
now_date = DateTime.now
fixedassets.each do |f|
  if (f == nil )
    puts "fixedasset_id[#{i+2}]: passed, need to modify"
    i = i + 1
    next
  end
 
  fixno  = f.fixno  
  fixed_asset = Fixedasset.find_by_fixed_asset_id(fixno) 
  if (fixed_asset == nil )
    puts "#{fixno} cannot be found" + (i+2).to_s
    i = i+1
    next
  end

  i = i +1

  if (f.bwhy=="C") # (no matter dwhy = "DEMS") 

    fd = FixedassetRedepreciation.find_by_fixedasset_id(fixno)
    if (fd==nil)
      fd = FixedassetRedepreciation.new
    else
      puts fd
    end
    j = i
    fd.fixedasset_id = fixed_asset.id
    fd.re_original_value = fixed_asset.final_scrap_value
    fd.re_final_scrap_value = (fixed_asset.scrap_value.to_f / 4).round
    fd.re_depreciated_value_per_month = f.dtotal.to_i
    fd.re_depreciated_value_last_month = 0
    start_date = f.dbdate
    if (!start_date.blank?)
      year = start_date[0..2].to_i + 1911
      month = start_date[3..4].to_i
      start_use_date = DateTime.new(year,month,1,0,0,0)    
      fd.re_start_use_date = start_use_date
    end
    end_date = f.dedate
    if (!end_date.blank?)
      year = end_date[0..2].to_i + 1911
      month = end_date[3..4].to_i
      end_use_date = DateTime.new(year,month,1,0,0,0)    
      fd.re_end_use_date = end_use_date + 1.month
    end

    fd.save!
    
  elsif (f.bwhy=="E" && (f.dwhy=="" || f.dwhy=="M") && j+1 == i)

    fd.re_depreciated_value_last_month = f.dtotal.to_i
    start_date = f.dbdate
    if (!start_date.blank?)
      year = start_date[0..2].to_i + 1911
      month = start_date[3..4].to_i
      start_use_date = DateTime.new(year,month,1,0,0,0)    
    end

    fd.save!
  elsif (f.bwhy=="C" && (f.dwhy=="D" or f.dwhy=="S"))

  end

end