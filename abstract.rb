require 'date'
require 'io/console'
require 'optparse'
require 'csv'
date = Date.today
month_name =Date::ABBR_MONTHNAMES

$holiday = [ ]
if File.exist?('holiday.csv') 
  CSV.foreach('holiday.csv') do |row|    
  $holiday.push(row)
end
else
  puts " No CSV file found "
end


def month_len (year,month)
  	time = Date.new(year,month,-1)
 	return time.day
end

def week_day(year,month,day)
	x = Date.new(year,month,day)
	return x.wday
end

def print_head(start_dow)
	days = Date::ABBR_DAYNAMES
	puts ("   "+days[start_dow%7] + "  " + days[(start_dow+ 1)%7] + "  " + days[(start_dow + 2)%7] + "  " + days[(start_dow + 3)%7] + "  " + days[(start_dow + 4)%7] + "  " + days[(start_dow + 5)%7] + "  " + days[(start_dow + 6)%7])
end

def startweek(start_dow,weekday)
	temp = (weekday - start_dow -1 ) 
    if temp == -1
      temp = -1
    elsif temp < -1
      temp = temp +7
    end 
      return temp+1
end

def hol (month,year)
    temp = [ ]
    ch = 'a'
    holiday2 = $holiday
    for i in 0..12
      if $holiday [i][1].to_i== month && $holiday[i][0].to_i== year
        holiday2[i][4] = ch
        temp.push(holiday2[i])
        ch=ch.next
      end
    end
    return temp
end

def hol_list (month,year)
    temp_hol = []
    for i in 0..12
      if $holiday [i][1].to_i == month && $holiday[i][0].to_i == year
        temp_hol.push($holiday[i][3])
      end
    end
    return temp_hol
end

def print_leg (arr2)
    legend = arr2
    ch = 'a'
    i = legend.length
    for j in 0..i-1
      print ch,":",legend[j]
      puts
      ch=ch.next
    end 
end


def prev_mon_date(weekday,start_dow,prev_len) 
    count = (weekday - start_dow - 1) 
    if count < 0
      count = count + 7
    end
      t = prev_len - count 
    return t
end

holiday = lambda do |day_count,month,year|	
    temp_hol = hol(month,year)
	len = temp_hol.length
	temp_hol1 = []
    for i in 0..len-1
      if temp_hol[i][2].to_i==day_count
        temp_hol1.push(temp_hol[i][4])
      end
    end
    return temp_hol1[0]
end

flags = lambda do |h,day_count,cur_month,month,year,j| 
	if cur_month != month
	  return "*"
	end
	if h == true
	  holiday.call(day_count,cur_month,year)
	else
	  return ''
	end
end
			

def create_calendar(month,year,start_dow,flags,h)
	len = month_len(year,month)
	weekday = week_day(year,month,1)
	print_head(start_dow)
	if month==1
      prev_len = month_len(year-1,12)
    else
      prev_len = month_len(year,month-1)
    end
	day_count = 1
	next_mon = 0
	count = startweek(start_dow,weekday)
	for i in 0..5
		for j in 0..6
			if i == 0 
			  if j>=count && day_count<= len
                printf("%5s",day_count.to_s+flags.call(h,day_count,month,month,year,j).to_s)
			    day_count +=1
			  else
			    printf("%5s",prev_mon_date(weekday,start_dow+j,prev_len).to_s+flags.call(h,day_count,month,month-1,year,j))
			  end
			elsif day_count<= len
			  printf("%5s",day_count.to_s+flags.call(h,day_count,month,month,year,j).to_s)
			  day_count +=1				
			else
			  next_mon += 1
			  printf("%5s",next_mon.to_s+flags.call(h,day_count,month,month+1,year,j))
			end
		end
	puts
	end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  opts.on("-m", "--m Month", "Month") do |m|
  options[:month] = m
  end
  opts.on("-y", "--y Year", "Year") do |y|
  options[:year] = y
  end
  opts.on("-w", "--w startday", "startday") do |w|
  options[:w] = w
  end
  opts.on("-h", "--hholiday", "holiday") do |h|
  options[:holiday] = h
  end
end.parse!

puts "\e[H\e[2J"
month = options [:month].to_i
year =  options [:year].to_i
w =  options [:w].to_i
h = options[:holiday]
if !options[:month] or !options[:year]
  puts " Month and Year not mentioned "
else
  print "\t \t",year
  puts "\n"
  print "\t \t",month_name[month]
  puts "\n"
  puts create_calendar(month,year,w,flags,h)
  if h == true
    print_leg (hol_list month,year)
  end
end
