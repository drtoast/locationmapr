require 'csv'
require 'json'

class ConsolidatedToJson
  
  # convert iphone consolidated.db to JSON
  
  FIELDS = [
    'MCC',              # INTEGER
    'MNC',              # INTEGER
    'LAC',              # INTEGER
    'CI',               # INTEGER
    'Timestamp',        # FLOAT, seconds since 1 Jan 2001
    'Latitude',         # FLOAT
    'Longitude',        # FLOAT, 
    'HorizontalAccuracy', # FLOAT, 50-300
    'Altitude',         # FLOAT
    'VerticalAccuracy', # FLOAT
    'Speed',            # FLOAT 
    'Course',           # FLOAT
    'Confidence',       # INTEGER // 0, 50, 60, 65, 68, or 70 
  ]
  
  def initialize(original)
    @original = original
  end
  
  def convert
    i = 0
    markers = []
    CSV.foreach(@original, {:col_sep => "|", :row_sep => "\n"}) do |row|
        markers << {
          'lat' => row[5],    # ['Latitude']
          'lng' => row[6],    # ['Longitude']
          'time' => row[3],   # ['Timestamp']
          'conf' => row[12],  # ['Confidence']
          'ha' => row[7]      # ['HorizontalAccuracy']
        }
        i += 1
        # break if i >= 1000
    end
    File.open("public/data/markers.json", "w") do |f|
      f << {'markers' => markers}.to_json
    end
  end
  
end

c = ConsolidatedToJson.new(ARGV[0])
c.convert