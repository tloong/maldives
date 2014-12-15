json.array!(@reports) do |report|
  json.extract! report, :id, :meeting_id, :name, :module, :this_week_work, :need_help, :next_week_work, :share_tech
  json.url report_url(report, format: :json)
end
