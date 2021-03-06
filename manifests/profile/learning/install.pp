class bootstrap::profile::learning::install {

  $prod_module_path = '/etc/puppetlabs/code/environments/production/modules'

  package { 'python-pip':
    ensure => 'present',
    require => Class['epel'],
  }

  # Symlink pip to /usr/bin/pip-python where the provider expects it
  file { '/usr/bin/pip-python':
    ensure  => symlink,
    target  => '/usr/bin/pip',
    require => Package['python-pip']
  }

  service {['pe-puppet', 'puppet']:
    ensure  => 'stopped',
    enable => 'false',
  }

  package { 'graphviz':
    ensure  => 'present',
  }

  file { ['/etc/motd', '/root/README']:
    ensure => 'file',
    owner  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/bootstrap/learning/README',
  }

  file { '/var/lib/hiera':
    ensure => directory,
  }

  file { '/usr/local/bin/reset_demo':
    ensure => 'file',
    owner  => 'root',
    mode   => '0500',
    source => 'puppet:///modules/bootstrap/learning/reset_demo',
  }

  #enable GSSAPIAuthentication so we can disable it in the quest
  file_line { 'sshd_config':
    ensure => present,
    path   => '/etc/ssh/sshd_config',
    line   => 'GSSAPIAuthentication yes',
    match  => '^GSSAPIAuthentication',
  }

}
