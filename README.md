# about

Just a quick webapp to view your iPhone location data in Google Maps.  You'll need to locate your consolidated.db, export the tracking data, and convert it to JSON (see below). When you run the app, you'll see all of your datapoints at once (yes, it's a bit slow), where red indicates a "HorizontalAccuracy" of <= 500, while blue is > 500.

# 1. install

    rvm use 1.9
    bundle

# 2. retrieve consolidated.db from iphone backup

see http://petewarden.github.com/iPhoneTracker/

# 3. convert consolidated.db to json

    sqlite3 consolidated.db
    
    sqlite> .output location.txt
    sqlite> select * from CellLocation;
    sqlite> .quit
    
    ruby lib/consolidated_to_json.rb /path/to/consolidated.txt

# 4. run webapp

    ruby app.rb

# 5. view map

    http://localhost:4567
