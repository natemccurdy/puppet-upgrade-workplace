class example::base::users {
  include example::account::removals
  include example::admin::users
  file { "/etc/sudo-ldap.conf":
    ensure    => absent,
  }
  user { root:
    password => '$1$v4K9E8Wj$gZIHJ5JtQL5ZGZXeqSSsd0',
  }
  if $::user_exists_oracle {
    user { oracle:
      managehome => true,
      password   => '$1$v4K9E8Wj$gZIHJ5JtQL5ZGZXeqSSsd0',
    }
  }
  if $::user_exists_weblogic {
    user { weblogic:
      password => '$1$v4K9E8Wj$gZIHJ5JtQL5ZGZXeqSSsd0',
    }
  }
  if $::user_exists_splex {
    user { splex:
      password => '$1$v4K9E8Wj$gZIHJ5JtQL5ZGZXeqSSsd0',
    }
  }
  if $::user_exists_infraadm {
    user { infraadm:
      password => '$1$v4K9E8Wj$gZIHJ5JtQL5ZGZXeqSSsd0',
    }
  }
}
class example::base::config {
  include example::base::users
  include selinux
  include example::postfix::client
  class { 'sudo': }
  service { "ntpd":
    ensure    => stopped,
    enable    => false,
  }
  package { "openssh":
    ensure    => latest,
  }
  package { "glibc":
    ensure    => latest,
  }
  package { "bash":
    ensure    => latest,
  }
  package { "lsof":
    ensure    => latest,
  }
  case $operatingsystemrelease {
    /^6.*/: {
      package { "ntpdate":
        ensure    => latest,
      }
    }
    /^5.*/: {
      package { "python-hashlib":
        ensure    => present,
      }
      package { "ntp":
        ensure    => latest,
      }
    }
  }
  package { "screen":
    ensure    => latest,
  }
  package { "man-db":
    ensure => latest,
  }
  package { "nfs-utils":
    ensure    => present,
  }
  service { "crond":
    ensure    => running,
    enable    => true,
  }
  limits::domain { 'maxlogins':
    maxlogins => {
      'soft' => '4',
      'hard' => '5',
    },
  }
  cron { ntpdate:
    ensure     => present,
    command    => "/usr/sbin/ntpdate ntp.example.com > /dev/null 2>&1",
    user       => root,
    minute     => '*/10',
#    require    => Package[ntpdate],
  }
  file { "/etc/init.d/firstboot":
    ensure     => Absent,
  }
}
class example::admin::users {
  include accounts
  realize (Accounts::Virtual['melanthius'])
  realize (Accounts::Virtual['melantho'])
  realize (Accounts::Virtual['calypso'])
  realize (Accounts::Virtual['travis'])
  realize (Accounts::Virtual['alan'])
  realize (Accounts::Virtual['polyphemus'])
  realize (Accounts::Virtual['circe'])
  # Service account for Security scanning
  realize (Accounts::Virtual['svc-nexpose'])

  sudo::conf { 'ops':
    priority   => 10,
    content    => '%wheel ALL=(ALL) NOPASSWD: ALL',
  }
}
class example::dba::users {
  include accounts
  group { "dba":
    gid        => 500,
    ensure     => "present",
  }
  realize (Accounts::Virtual['Zeus'])
  realize (Accounts::Virtual['Penelope'])
  realize (Accounts::Virtual['odysseus'])
  realize (Accounts::Virtual['Poseidon'])
  realize (Accounts::Virtual['Telemachus'])
  realize (Accounts::Virtual['Athena'])
  realize (Accounts::Virtual['Eumaeus'])
  realize (Accounts::Virtual['Antinous'])
  realize (Accounts::Virtual['Eurymachus'])
  realize (Accounts::Virtual['Amphinomus'])
  sudo::conf { 'dba':
    priority   => 10,
    content    => '%dba ALL=(ALL) NOPASSWD: ALL',
  }

}
class example::erp::users {
  include accounts
  group { "erp":
    gid     => 2000,
    ensure  => "present",
  }
  file { "/etc/sudoers.d/erp-sudoers":
    mode    => 440,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/example/erp-sudoers"
  }
  if $hostname =~ /obie/ {
    file { "/etc/sudoers.d/60-erp":
      mode    => 440,
      owner   => root,
      group   => root,
      source  => "puppet:///modules/sudo/60-erp"
    }
  }
  realize (Accounts::Virtual['nestor'])
  realize (Accounts::Virtual['menelaus'])
  realize (Accounts::Virtual['laertes'])
  realize (Accounts::Virtual['tiresias'])
}
class example::dev::users {
  include accounts
  group { "dev":
    gid    => 60000,
    ensure => "present",
  }
}
