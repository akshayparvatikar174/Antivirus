# Cookbook Name:: nginxphp
# Recipe:: install_antivirus
# Description:: Installs ClamAV antivirus from a pre-downloaded package

antivirus_package = '/home/ubuntu/chef-repo/cookbooks/antivirus/clamav-milter_1.4.2+dfsg-0ubuntu1_amd64.deb'

# Step 1: Ensure the package exists before installing
file antivirus_package do
  action :nothing
end

# Step 2: Install ClamAV using dpkg
dpkg_package 'clamav' do
  source antivirus_package
  action :install
  notifies :run, 'execute[fix_missing_dependencies]', :immediately
end

# Step 3: Fix missing dependencies if any
execute 'fix_missing_dependencies' do
  command 'apt-get install -f -y'
  action :nothing
end

# Step 4: Verify ClamAV installation
execute 'verify_clamav_installation' do
  command 'clamd --version'
  action :run
  only_if 'which clamd'
end
