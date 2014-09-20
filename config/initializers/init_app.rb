Dir.chdir(Rails.root.to_s)
report_path = Rails.root.to_s + "/public/fixedassets_pdf/"

unless File.directory?(report_path)
  FileUtils.mkdir_p(report_path)
end

report_path = Rails.root.to_s + "/public/fixedassets_pdf2/"

unless File.directory?(report_path)
  FileUtils.mkdir_p(report_path)
end