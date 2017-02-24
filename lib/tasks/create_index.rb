class Tasks::CreateIndex
<<<<<<< HEAD
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
=======

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
>>>>>>> origin
      end
    end
  end
end
