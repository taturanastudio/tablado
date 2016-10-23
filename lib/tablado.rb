require "tablado/version"

module Tablado

  require 'rmagick'

  class Presentation

    attr_accessor :fps,
                  :slides,
                  :width,
                  :height

    def fps
      @fps ||= 60
    end

    def slides
      @slides ||= []
    end

    def width
      @width ||= 1280
    end

    def height
      @height ||= 720
    end

    def build
      slides.each_with_index do |slide, s_index|
        frames = (fps * slide.duration) - 1
        (0..frames).each do |index|
          file_name = "%06d-%06d.%s" % [s_index, index, 'jpg']
          puts file_name
          puts slide.background.color
          slide.compose(index).write file_name
        end
      end
    end

  end

  class Presentation::Slide

    attr_accessor :duration,
                  :presentation,
                  :background,
                  :elements

    def presentation
      @presentation ||= Presentation.new
    end

    def duration
      @duration ||= 1
    end

    def background
      @background ||= Presentation::Slide::Background.new
    end

    def elements
      @elements ||= []
    end

    def compose(index = 0)
      puts index
      image = background.image.dup
      elements.each do |element|
        puts 'elements'
        animated = element.animate index
        image.composite!(animated.draw, Magick::NorthWestGravity, animated.left, animated.top, Magick::CopyCompositeOp)
      end
      return image
    end

  end

  class Presentation::Slide::Background
    attr_accessor :slide, :image

    def slide
      @slide ||= Presentation::Slide.new
    end

    def image
      @image ||= Magick::Image.new(slide.presentation.width, slide.presentation.height)
    end

    def image=(new_image)
      @image = new_image
    end
  end
  
  class Presentation::Slide::Background::Solid < Presentation::Slide::Background

    attr_accessor :color

    def color
      @color ||= "red"
    end

    def initialize params={}
      params.each { |key, value| instance_variable_set("@#{key}", value) }
      # TODO: Refactory this! Please!
      $color = color
      self.image = Magick::Image.new(slide.presentation.width, slide.presentation.height) { self.background_color = $color}
    end

  end

  class Presentation::Slide::Element

    attr_accessor :width,
                  :height,
                  :top,
                  :left,
                  :draw,
                  :animations
    
    def initialize params={}
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def draw
      @draw ||= Magick::Image.new(100, 100)  { self.background_color = '#333'}
    end

    def image=(new_draw)
      @draw = new_draw
    end

    def animations
      @animations ||= []
    end

    def animate(index = 0)
      result = self
      animations.each do |animation|
        puts 'anims'
        result = animation.process result, index
      end
      result
    end

  end

  class Presentation::Slide::Element::Image < Presentation::Slide::Element
  end

  class Presentation::Animation
    
    def process(element , index = 0)
      element.top += index
      element
    end

  end

end
