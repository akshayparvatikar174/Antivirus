# Cookbook Name:: antivirus
# Recipe:: install_antivirus

package %w(clamav clamav-daemon) do
  action :install
end

# Ensure the ClamAV Daemon is enabled and started
service 'clamav-daemon' do
  action [:enable, :start]
end

# Verify the ClamAV installation
execute 'verify_clamav_installation' do
  command 'clamscan --version'
  action :run
end
