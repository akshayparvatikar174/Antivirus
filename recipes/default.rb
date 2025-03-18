# Cookbook Name:: nginxphp
# Recipe:: install_chrome
# Description:: Installs Google Chrome from a pre-downloaded package

chrome_package = '/home/ubuntu/chef-repo/cookbooks/nginxphp/google-chrome-stable_current_amd64.deb'

# Step 1: Ensure the package exists before installing
file chrome_package do
  action :nothing
end

# Step 2: Install Google Chrome using dpkg
dpkg_package 'google-chrome-stable' do
  source chrome_package
  action :install
  notifies :run, 'execute[fix_missing_dependencies]', :immediately
end

# Step 3: Fix missing dependencies if any
execute 'fix_missing_dependencies' do
  command 'apt-get install -f -y'
  action :nothing
end

# Step 4: Verify Google Chrome installation
execute 'verify_chrome_installation' do
  command 'google-chrome --version'
  action :run
  only_if 'which google-chrome'
end
