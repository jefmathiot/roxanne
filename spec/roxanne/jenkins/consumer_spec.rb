require 'spec_helper'

describe Roxanne::Jenkins::Consumer do

  def jobs(*colors)
    { 'jobs' => colors.map{|color| {'color'=>color} } }.to_json
  end

  it 'defaults to green' do
    subject.new.handle_response(jobs).must_equal :green
  end

  it 'ignores unknown job colors' do
    subject.new.handle_response(jobs('british_racing_green')).must_equal :green
  end

  it 'returns green if all good' do
    subject.new.handle_response(jobs('blue', 'yellow')).must_equal :green
  end

  it 'returns orange if one of the jobs is orange' do
    subject.new.handle_response(jobs('yellow_anime', 'blue', 'yellow')).must_equal :orange
    subject.new.handle_response(jobs('blue_anime', 'blue', 'yellow')).must_equal :orange
    subject.new.handle_response(jobs('red_anime', 'blue', 'yellow_anime')).must_equal :orange
  end

  it 'returns red if one of the jobs is read' do
    subject.new.handle_response(jobs('red', 'blue', 'yellow_anime')).must_equal :red
  end

end
