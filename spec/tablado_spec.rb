require 'spec_helper'

describe Tablado do
  it 'has a version number' do
    expect(Tablado::VERSION).not_to be nil
  end
end

describe Tablado::Presentation do

  let(:presentation) { Tablado::Presentation.new }

  it 'should have attribute FPS' do expect( presentation.respond_to? :fps) end
  it 'should have attribute width' do expect( presentation.respond_to? :witdh) end
  it 'should have attribute height' do expect( presentation.respond_to? :height) end

  describe '#width' do
    it 'default value should be 1280' do expect(presentation.width).to eq(1280) end
    it 'should be set' do expect{presentation.width = 800}.to change{presentation.width}.from(1280).to(800) end
  end

  describe '#height' do
    it 'default value should be 720' do expect(presentation.height).to eq(720) end
    it 'should be set' do expect{presentation.height = 400}.to change{presentation.height}.from(720).to(400) end
  end

  describe '#fps' do
    it 'default value should be 60' do expect(presentation.fps).to eq(60) end
    it 'should be set' do expect{presentation.fps = 10}.to change{presentation.fps}.from(60).to(10) end
  end

end

describe Tablado::Presentation::Slide do

  let(:slide) { Tablado::Presentation::Slide.new }

  it 'should have attribute duration' do expect( slide.respond_to? :duration) end

  describe '#duration' do

    it 'default value should be 1' do expect(slide.duration).to eq(1) end
    it 'should be set' do expect{slide.duration = 10}.to change{slide.duration}.from(1).to(10) end
  
  end

end

describe Tablado::Presentation::Slide::Background do

  let(:background) { Tablado::Presentation::Slide::Background.new }

  it 'should have attribute image' do expect( background.respond_to? :image) end
  it 'should have attribute slide' do expect( background.respond_to? :slide) end

  describe '#image' do
    it 'default value should be as Magick::Image' do expect(background.image.class).to eq(Magick::Image) end
  end

end

describe Tablado::Presentation::Slide::Element do

  let(:element) { Tablado::Presentation::Slide::Element.new }

  %w[width height top left].each do |a|
    it "should have attribute #{a}" do expect( element.respond_to? a.to_sym) end
  end

end