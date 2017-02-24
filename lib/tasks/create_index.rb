class Tasks::CreateIndex
  require 'csv'
  class << self
    def execute
      # input & hash
      index = {}
      csv = CSV.read("#{Rails.root}/file/KEN_ALL.CSV")
      csv.each_with_index do |data, idx|
        "#{data[6]}#{data[7]}#{data[8]}".each_char do |char|
          if !index.has_key?(char)
            index[char] = {}
            index[char]['lines'] = []
          end
          index[char]['lines'] << idx
        end
      end

      # unique & count
      index.each do |key, item|
        item['lines'].uniq!
        item['count'] = item['lines'].size
      end

      # sort by count
      index = index.sort_by{|k, v| -v['count']}

      # output
      File.open("#{Rails.root}/file/KEN_ALL.index", "w") do |f| 
        f.puts(index.to_json)
      end
    end
  end
end
