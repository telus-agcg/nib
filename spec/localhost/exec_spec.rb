RSpec.describe 'exec' do
  around(:each) do |example|
    `
      cd spec/dummy/rails
      docker-compose up -d
    `

    example.run

    `
      cd spec/dummy/rails
      docker-compose stop
      docker-compose rm --all -f
    `
  end

  describe command("cd spec/dummy/rails; nibtest exec web 'ps x'") do
    its(:stdout) { should match(%r{\/bin\/rackup\ -p}) }
    its(:exit_status) { should eq 0 }
  end
end
