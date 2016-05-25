class activemq::package(
  $package = undef,
  $version = undef,
  $versionlock = false
) {

  validate_re($version, '^[~+._0-9a-zA-Z:-]+$')

  $version_real = $version

  package { $package :
    ensure  => $version_real
  }

  case $versionlock {
    true: {
      packagelock { $package : }
    }
    false: {
      packagelock { $package : ensure => absent }
    }
    default: { fail('Class[Activemq::Package]: parameter versionlock must be true or false') }
  }

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease < 7 {
        file { '/etc/init.d/activemq':
          ensure  => file,
          mode    => '0755',
          content => template("${module_name}/init/activemq"),
        }
      }
    }
  }

}
