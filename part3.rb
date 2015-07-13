require 'date'
require 'io/console'
time = Time.new
month1 = time.month
day = time.day
w = time.wday
year1= time.year
month_name = Hash.new
(1..12).each {|m| month_name[m] = Date::ABBR_MONTHNAMES[m]}

$holiday = [[Date.new(2015,1,1)," New Year "," "],
            [Date.new(2015,1,26) ,"Republic Day"," "],
            [Date.new(2015,2,14),"Valentines Day"," "],
            [Date.new(2015,7,19)," Ramzan"," "],
            [Date.new(2015,7,31)," Jamat Ul Vida"," "],
            [Date.new(2015,8,15)," Independance Day "," "],
            [Date.new(2015,8,28)," Onam "," "],
            [Date.new(2015,9,17)," Ganesh Chaturthi"," "],
            [Date.new(2015,10,22)," Dussehra"," "],
            [Date.new(2015,11,11)," Diwali"," "],
            [Date.new(2015,12,25)," Christmas "," "],
            [Date.new(2016,1,1), "New Year "," "],
            [Date.new(2016,1,26)," Republic Day"," "]]


def month_len (year,month)
    time = Date.new(year,month,-1)
    return time.day
end

def week_day(year,month,day)
    x = Date.new(year,month,day)
    return x.wday
end

def prev_mon_date (month,year,startday,prev_len)
    week = week_day(year,month,1)
    temp = (week - startday - 1) 
        if temp < 0
            temp = temp + 7
        end 
    t = prev_len - temp + 1
    return t.to_s+"*"
end

def count_month (month,year,startday)
    print_head startday
    len= month_len(year,month)
    if month==1
        prev_len = month_len(year-1,12)
    else
        prev_len = month_len(year,month-1)
    end
    temp = 0
    day_count = 1
    for i in 0..5
        for j in 0..6
            if day_count <= len
                if ((j+1+startday)%7) == week_day(year,month,day_count)
                        printf("%5s",day_count.to_s)
                        day_count = day_count + 1
                else                             
                    printf("%5s",prev_mon_date(month,year,startday+j,prev_len))
                end     
            else
                temp +=1
                printf("%5s",temp.to_s+"*")
            end
        end
        puts 
    end
end


def print_head(startday)
    days = %w[ mon tue wed thu fri sat sun]
    puts ("   "+days[startday%7] + "  " + days[(startday+ 1)%7] + "  " + days[(startday + 2)%7] + "  " + days[(startday + 3)%7] + "  " + days[(startday + 4)%7] + "  " + days[(startday + 5)%7] + "  " + days[(startday + 6)%7])
 end

    w = 0
	year = year1
    month = month1
	print "\t \t",year
	puts "\n"
    print "\t \t",month_name[month]
	puts "\n"
	count_month month,year,w

    puts " Hit 'N' for next month "
    puts " Hit 'P' for previous month "
    puts " Hit 'E' for exit calendar "
    ch = STDIN.getch
    
while (ch != 'e') do     
	puts "\e[H\e[2J"
    if ch == 'N'||ch == 'n'
    	if month == 12 
    		year += 1
    		month = 1
    	else
    		month +=1
    	end

    elsif ch == 'P' || ch == 'p'
    	if month == 1 
    		year -= 1
    		month = 12
    	else
    		month -=1
    	end
    elsif ch == 'E' || ch == 'e'
    		exit
    else
    	puts " Error "
    	exit
    end
    
    print "\t \t",year
	puts "\n"
    print "\t \t",month_name[month]
	puts "\n"
    count_month month,year,w
	puts " Hit 'W' to choose a startday "
	puts " Hit 'N' for next month "
    puts " Hit 'P' for previous month "
    puts " Hit 'E' for exit calendar "
    ch = STDIN.getch
		if ch == 'w'
			puts " Choose a startday (sunday - saturday ) : 0 - 6"
    		w = STDIN.getch.to_i
    		puts " Hit 'N' for next month "
		    puts " Hit 'P' for previous month "
		    puts " Hit 'E' for exit calendar "
		    ch = STDIN.getch
    	end    
end