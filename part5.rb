require 'optparse'
require 'date'
require 'io/console'
time = Time.new
month = time.month
day = time.day
w = time.wday
year= time.year
month_name = Hash.new
(1..12).each {|m| month_name[m] = Date::ABBR_MONTHNAMES[m]}


def month_len (year,month)
  	time = Date.new(year,month,-1)
 	return time.day
end

def week_day(year,month,day)
	x = Date.new(year,month,day)
	return x.wday
end


def countmonth (month,year,startday)
    len= month_len(year,month)
    temp = 0
    day_count = 1
    for i in 0..5
        for j in 0..6
            if day_count <= len
                if ((j+1+startday)%7) == week_day(year,month,day_count)
                    
                        printf("%5s",day_count)
                    	day_count = day_count + 1
                else                      
                    printf "     "                       
                end     
            end
        end
        puts 
	end
end


def printhead(startday)
	days = %w[ mon tue wed thu fri sat sun]
	puts ("   "+days[startday%7] + "  " + days[(startday+ 1)%7] + "  " + days[(startday + 2)%7] + "  " + days[(startday + 3)%7] + "  " + days[(startday + 4)%7] + "  " + days[(startday + 5)%7] + "  " + days[(startday + 6)%7])
 end


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-m", "-month", "Month") do |m|
    options[:month] = m
  end
  opts.on("-y", "-year", "Year") do |y|
    options[:year] = y
  end
end.parse!


puts options [:month]
puts options [:year]
	
	print "\t \t",options [:year].to_i
	puts "\n"
    print "\t \t",month_name[options[:month].to_i]
	puts 
	puts printhead 0
    puts countmonth options [:month].to_i,options [:year].to_i,0
    


