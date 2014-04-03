require 'spec_helper'

describe Roxanne::Travis::Consumer do

  before do
    @subject = subject.new
    @subject.organization_or_user = 'servebox'
  end

  def expects_repositories_state( *repos )
    mock_repos = repos.map do |repo|
      mock.tap do |mock|
        mock.stubs(:active?).returns(repo[:active].nil? ? true : repo[:active])
        mock.stubs(:last_build_state).returns(repo[:build_state])
      end
    end
    Travis::Repository.expects(:find_all).with(owner_name: 'servebox').returns(mock_repos)
  end

  it 'defaults to green' do
    expects_repositories_state
    @subject.pull.must_equal :green
  end

  it 'ignores inactive repositories' do
    expects_repositories_state({ active: false, build_state: 'failed' })
    @subject.pull.must_equal :green
  end

  it 'returns green if all good' do
    expects_repositories_state({ build_state: 'passed' })
    @subject.pull.must_equal :green
  end

  it 'returns orange if one of the jobs is orange' do
    expects_repositories_state({ build_state: 'started' }, {build_state: 'passed'})
    @subject.pull.must_equal :orange
  end

  it 'returns red if one of the jobs is read' do
    expects_repositories_state({ build_state: 'failed' }, { build_state: 'started' },
      {build_state: 'passed'})
    @subject.pull.must_equal :red
  end

end
