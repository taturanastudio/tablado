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
      slides.each do |slide|
        frames = fps * slide.duration
        (0..frames).each do |index|
          puts index
        end
      end
    end

  end

  class Presentation::Slide

    attr_accessor :duration, :presentation

    def presentation
      @presentation ||= Presentation.new
    end

    def duration
      @duration ||= 1
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
      image = Magick::Image.new(slide.presentation.width, slide.presentation.height) { self.background_color = @color}
      image.display
    end

  end

end
