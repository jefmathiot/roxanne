require 'spec_helper'

describe Roxanne::Configuration::Base do

  after do
    Timecop.return
  end

  it 'initializes settings' do
    subject.new.tap do |config|
        config.publisher.must_be_nil
        config.consumers.must_equal []
    end
  end

  it 'is active when in specified days and time range' do
    Timecop.travel(Time.local(2014, 3, 7, 19, 59, 59))
    subject.new.activated.must_equal true

    Timecop.travel(Time.local(2014, 3, 3, 8, 0, 0))
    subject.new.activated.must_equal true
  end

  it 'is not active when out of specified days' do
    Timecop.travel(Time.local(2014, 3, 8, 8, 0, 0))
    subject.new.activated.must_equal false
  end

  it 'is not active when out of time range' do
    Timecop.travel(Time.local(2014, 3, 7, 20, 0, 0))
    subject.new.activated.must_equal false

    Timecop.travel(Time.local(2014, 3, 3, 7, 59, 59))
    subject.new.activated.must_equal false
  end

end
