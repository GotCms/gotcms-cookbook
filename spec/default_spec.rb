require 'chefspec'

describe 'gotcms::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes recipes' do
    expect(chef_run).to include_recipe('php')
    expect(chef_run).to include_recipe('apache2')
    expect(chef_run).to include_recipe('apache2::mod_php5')
    expect(chef_run).to include_recipe('gotcms::database')
  end

  it 'create directory' do
    expect(chef_run).to create_directory('/var/www/gotcms').with(
      owner: 'www-data',
      group: 'www-data'
    )
  end

  it 'download archive' do
    expect(chef_run).to create_remote_file('/var/chef/cache/gotcms.tar.gz').with(
      source: 'https://github.com/GotCms/GotCms/archive/master.tar.gz'
    )
  end

  it 'extract archive' do
    expect(chef_run).to run_execute('extract-gotcms').with(
      command: 'tar xf /var/chef/cache/gotcms.tar.gz --strip-components 1 -C /var/www/gotcms',
      creates: '/var/www/gotcms/public/index.php'
    )
  end
end
