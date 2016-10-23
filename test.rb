
require 'tablado'

p = Tablado::Presentation.new
%w[red green blue yellow pink].each do |color|
  s = Tablado::Presentation::Slide.new
  s.background = Tablado::Presentation::Slide::Background::Solid.new color: color
  p.slides << s
end
p.build