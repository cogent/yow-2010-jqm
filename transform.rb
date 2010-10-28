require 'rubygems'
require 'yaml'

heading = <<EOF
<!DOCTYPE html>
<html>
  <head>
    <title>YOW! Melbourne Schedule 2010</title>
    <link rel='stylesheet' href='http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.css' />
    <script src='http://code.jquery.com/jquery-1.4.3.min.js'></script>
    <script src='http://code.jquery.com/mobile/1.0a1/jquery.mobile-1.0a1.min.js'></script>
  </head>
  <body>
    <div data-role='page' id='days'>
      <div data-role='header'>
YOW! Melbourne Schedule 2010
      </div>
      <div data-role='content'>
        <ul data-role='listview'> 
          <li data-role="list-divider">Days</li>
EOF

footer = <<-EOF
          </ul>
      </div>
    </div>
  </body>
</html>
EOF

yow = YAML.load(File.open('yow.yaml'))
puts heading
yow.each_with_index do |day, i|
  puts "  <li data-role='list-divider'>Day #{i+1}"
  day.each do |timeslot|
    puts "    <li data-role='list-divider'>#{timeslot[:time]}"
    timeslot[:sessions].each do |session|
      title = session[:title] || session[:track]
      puts "        <li><h3 class='ul-li-heading'>#{title}</h3>"
      puts "            <p class='ul-li-desc'>#{session[:speakers]}</p>"
      puts "            <p class='ul-li-aside'><strong>#{session[:track]}</strong></p>"
      puts "        </li>"
    end
    puts "      </li>"
  end
  puts "    </li>"
end
puts footer