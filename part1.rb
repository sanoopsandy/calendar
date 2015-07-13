require 'date'
require 'io/console'
time = Time.new
date = Date.today
month1 = time.month
day = time.day
w = time.wday
year1= time.year
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

    print "\t \t",year
    puts "\n"
    print "\t \t",month_name[month]
	puts 
	puts printhead 0
    puts (countmonth(month,year,0))
    puts " Hit 'N' for next month "
    puts " Hit 'P' for previous month "
    puts " Hit 'E' for exit calendar "
    
     ch = STDIN.getch
while (ch == 'p'|| ch == 'n')  
    puts "\e[H\e[2J"
    if ch == 'N'||ch == 'n'
        date = date >> 1
    elsif ch == 'P' || ch == 'p'
        date = date << 1
    elsif ch == 'E' || ch == 'e'
            exit
    else
        puts " Error "
        exit
    end
    year = date.year
    month = date.month
    print "\t \t",year
    puts "\n"
    print "\t \t",month_name[month]
    puts "\n"
    puts printhead 0
    puts (countmonth(month,year,0))
    puts " Hit 'N' for next month "
    puts " Hit 'P' for previous month "
    puts " Hit 'E' for exit calendar "
    ch = STDIN.getch
end 
