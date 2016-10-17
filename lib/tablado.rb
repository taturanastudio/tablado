require "tablado/version"

module Tablado

  require 'rmagick'

  class Presentation

    attr_accessor :fps,
                  :slides,
                  :width,
                  :height

    def fps
      @fps || 60
    end

    def slides
      @slides || []
    end

    def width
      @width || 1280
    end

    def height
      @height || 720
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

    attr_accessor :duration

    def duration
      @duration || 1
    end

  end

end
