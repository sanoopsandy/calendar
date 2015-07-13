require 'date'
require 'optparse'
require 'io/console'
require 'csv'
time = Time.new
month1 = time.month
day = time.day
w = time.wday
year1= time.year
month_name = Hash.new
(1..12).each {|m| month_name[m] = Date::ABBR_MONTHNAMES[m]}

$holiday = []
CSV.foreach('holiday.csv') do |row|    
    $holiday.push(row)
end

 def hol (month,year)
    temp = [ ]
    ch = 'a'
    holiday2 = $holiday
    for i in 0..12
        if $holiday [i][0].mon == month && $holiday[i][0].year == year
            holiday2[i][2] = ch
            temp.push(holiday2[i])
            ch=ch.next
        end
    end
    return temp
end

def holiday (day_count,month,year,h)
    if h == true
      temp_hol = hol(month,year)
      len = temp_hol.length
      temp_hol1 = []
      for i in 0..len-1
          if temp_hol[i][0].day==day_count
              temp_hol1.push(temp_hol[i][2])
          end
      end
      return temp_hol1[0]
    end
end

def hol_list (month,year)
    temp_hol = []
    for i in 0..12
        if $holiday [i][0].mon == month && $holiday[i][0].year == year
                temp_hol.push($holiday[i][1])
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


def count_month (month,year,startday,h)
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
                        printf("%5s",day_count.to_s+holiday(day_count,month,year,h).to_s)
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
    if h == true
      print_leg (hol_list month,year)
    end
end


def print_head(startday)
    days = %w[ mon tue wed thu fri sat sun]
    puts ("   "+days[startday%7] + "  " + days[(startday+ 1)%7] + "  " + days[(startday + 2)%7] + "  " + days[(startday + 3)%7] + "  " + days[(startday + 4)%7] + "  " + days[(startday + 5)%7] + "  " + days[(startday + 6)%7])
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



month = options [:month].to_i
year =  options [:year].to_i
w =  options [:w].to_i
h = options[:holiday]
  print "\t \t",year
  puts "\n"
  print "\t \t",month_name[month]
  puts "\n"
  count_month month,year,w,h


