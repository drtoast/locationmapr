# about

Just a quick webapp to view your iPhone "consolidated.db" location database in Google Maps by date range.  You'll need to locate your consolidated.db and copy it to the root of the app.  Red indicates a "HorizontalAccuracy" of <= 500, while blue is > 500.

![screenshot](https://github.com/drtoast/locationmapr/raw/master/public/images/locationmapr.png)

# 1. install

    git clone git://github.com/drtoast/locationmapr.git
    rvm use ruby-1.9.2-p180
    bundle

# 2. copy consolidated.db from iphone backup to locationmapr root

see http://petewarden.github.com/iPhoneTracker/

# 3. run webapp

    cd locationmapr
    ruby app.rb

# 4. view map and select a date range

    http://localhost:4567
