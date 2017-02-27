class TopController < ApplicationController
  require 'csv'
  def index
    if params[:word].present?
      @results = {}

      char_index = Hash[JSON.load(File.read("#{Rails.root}/file/char.index"))]

      zips = []
      params[:word].each_char do |char|
        next if char.match(/[\s　]/)

        unless char_index.has_key?(char)
          zips = []
          break
        end

        if zips.size == 0 
          zips.concat(char_index[char]['zip'])
        else
          zips = extract_duplicate_values(zips, char_index[char]['zip'])
          break if zips.size == 0
        end
      end
      char_index = nil

      if zips.size > 0
        zip_index = Hash[JSON.load(File.read("#{Rails.root}/file/zip.index"))]
        zips.sort!
        zips.each do |zip|
          @results[zip] = zip_index[zip]
        end
      end
    end
  end

  def extract_duplicate_values(a, b)
    arr = a.concat(b)
    arr.sort!
    arr.select.with_index{|e, i| e == arr[i+1] }
  end

end
