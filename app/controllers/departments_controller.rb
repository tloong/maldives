class DepartmentsController < ApplicationController
  def parts
    part_nos = FixedassetPart.select(:part_no).distinct
    @parts = Hash.new
    @departments = Hash.new
    part_nos.each do |pn|
      case pn.part_no
      when 1
        d = Department.find_by_dep_id("1261")
        @parts[pn.part_no] = "土地、建物分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      when 2 
        d = Department.find_by_dep_id("0000")
        @parts[pn.part_no] = "土地、建物分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      when 3
        d = Department.find_by_dep_id("0000")
        @parts[pn.part_no] = "電器設備分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      end
    end
  end
end
