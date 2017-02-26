class Tasks::CreateZipIndex
  require 'csv'
  class << self
    def execute
      # input & hash
      index = {}
      csv = CSV.read("#{Rails.root}/file/KEN_ALL.CSV")
      csv.each_with_index do |data, idx|
        next unless data[2].present?
        if index.has_key?(data[2])
          index[data[2]]['detail'] << data[8]
        else
          index[data[2]] = {}
          index[data[2]]['ken'] = data[6]
          index[data[2]]['kuchoson'] = data[7]
          index[data[2]]['detail'] = data[8]
        end
      end

      # output
      File.open("#{Rails.root}/file/zip.index", "w") do |f| 
        f.puts(index.to_json)
      end
    end
  end
end
