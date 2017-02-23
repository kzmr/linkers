class Tasks::CreateIndex

  require 'csv'
  class << self

    def execute
      csv = CSV.read("#{Rails.root}/file/KEN_ALL.CSV")
      index = {}
      csv.each_with_index do |d, idx|
        str = "#{d[6]}#{d[7]}#{d[8]}"
        str.each_char do |c|
          if !index.has_key?(c)
            index[c] = {}
            index[c]['lines'] = []
            index[c]['count'] = 0
          end
          index[c]['lines'] << idx 
          index[c]['lines'].uniq!
          index[c]['count'] = index[c]['lines'].size
        end
      end
      result = index.sort {|(k1, v1), (k2, v2)| v2['count'] <=> v1['count'] }
      File.open("#{Rails.root}/file/KEN_ALL.index", "w") do |f| 
          f.puts(result.to_json)
      end
    end
  end
end
