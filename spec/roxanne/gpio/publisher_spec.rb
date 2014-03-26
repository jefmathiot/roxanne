describe Roxanne::GPIO::Publisher do

  before do
    @publisher = subject.new
    @publisher.green_pin = 17
    @publisher.orange_pin = 25
    @publisher.red_pin = 22
  end

  it 'disable gpio pins' do
    expects_all_off
    @publisher.disable
  end
  
  it 'sets all pins to zero on nil status' do
    expects_all_off
    @publisher.push nil, nil
  end

  it 'switch green pin to 1 on green status' do
    expects_pin(@publisher.green_pin).expects(:value).with 1
    expects_pin(@publisher.orange_pin).expects(:value).with 0
    expects_pin(@publisher.red_pin).expects(:value).with 0
    @publisher.push nil, :green
  end

  it 'switch red pin to 1 on red status' do
    expects_pin(@publisher.green_pin).expects(:value).with 0
    expects_pin(@publisher.orange_pin).expects(:value).with 0
    expects_pin(@publisher.red_pin).expects(:value).with 1
    @publisher.push nil, :red
  end

  it 'switch orange pin to 1 on orange status' do
    expects_pin(@publisher.green_pin).expects(:value).with 0
    expects_pin(@publisher.orange_pin).expects(:value).with 1
    expects_pin(@publisher.red_pin).expects(:value).with 0
    @publisher.push nil, :orange
  end

  def expects_pin(num)
    mock.tap do |pin|
      Taopaipai.gpio.expects(:pin).with(num, direction: :out).returns(pin)
    end
  end

  def expects_all_off
    [17, 25, 22].each do |num|
      expects_pin(num).expects(:value).with(0)
    end
  end

end

