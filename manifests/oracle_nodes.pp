# Oracle Servers
node 'owas2.example.com' {
  include example::base::config
  include example::dba::users
  file { "40-oracle":
    path      => '/etc/sudoers.d/40-oracle',
    ensure    => file,
    source    => "puppet:///modules/example/owas-sudoers",
    mode      => 440,
  }
}
node /iapps1/ {
  include example::base::config
  include example::dba::users
  include example::iscsi::base
}
node 'fmrepodbprod1.example.com' {
  include example::base::config
  include example::dba::users
}
node 'argodbprod1.example.com' {
  include example::base::config
  include example::dba::users
}
node 'postgresdbprod1.example.com' {
  include example::base::config
  include example::dba::users
}
node 'argodbprod1.ausy.uhs' {
  include example::base::config
  include example::dba::users
  package { "xorg-x11-xauth":
    ensure    => present,
  }
}
node 'argodbprod1.cato.uhs' {
  include example::base::config
  include example::dba::users
  package { "xorg-x11-xauth":
    ensure    => present,
  }
}
node 'dbops1.example.com' {
  include example::base::config
  include example::dba::users
  file { "40-helpdesk":
    path      => '/etc/sudoers.d/40-helpdesk',
    ensure    => file,
    source    => "puppet:///modules/example/helpdesk-sudoers",
    mode      => 440,
  }
}

node /erpapp/ {
  include example::base::config
  include example::dba::users
  include example::iscsi::base
}
node /erpdbadmn/ {
  include example::base::config
  include example::dba::users
  include example::iscsi::base
}

node /webdbprod2/ {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}

node /demantradbprod/ {
  include example::base::config
  include example::dba::users
}

node /slc-demantra/ {
  include example::base::users
  include example::dba::users
}

node 'erpappvis1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::app::sudoers
}

node 'awrdbprod1.example.com' {
  include example::splunk::forwarder
  include example::base::config
  include example::dba::users
  include example::iscsi::base
}

node /agiledbprod2/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
  include example::iscsi::base
}

node /agileappprod2/ {
  include example::base::config
  include example::dba::users
  include example::oracle::app
  include example::oracle::nfs::stage
}

node /odsysrvsdbprod/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
}
### General Catch All - Don't add host definitions after this line ###
#node /appprod/ {
#  include example::base::config
#  include example::dba::users
#}
node 'soaappdev1.example.com' {
  include example::base::config
  include example::dba::users
  file { 'devsudoers':
    path      => '/etc/sudoers.d/devsudoers',
    ensure    => file,
    source    => "puppet:///modules/example/soaappdev1-sudoers",
    mode      => 0440,
  }
}
node 'pocdbdev1.example.com' {
  include example::base::config
  include example::dba::users
  file { '20-oracle':
    path      => '/etc/sudoers.d/20-oracle',
    ensure    => present,
    owner     => root,
    group     => root,
    mode      => 440,
    source    => "puppet:///modules/example/poc-oracle-sudoers",
  }

}

node 'webdbdev1.example.com' {
  include example::base::config
  include example::dba::users
}

node /dbdev/ {
  include example::base::config
  include example::dba::users
}

node /erpappdev/ {
  include example::base::config
  include example::dba::users
}
node /erpapphrdev/ {
  include example::base::config
  include example::dba::users
}

# Oracle Nodes
node /odsysrvsdbstage/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
  include example::iscsi::base
}
node 'argodbstage1.cato.uhs' {
  include example::base::config
  include example::dba::users
  package { "xorg-x11-xauth":
    ensure    => present,
  }
}
node 'argodbstage1.ausy.uhs' {
  include example::base::config
  include example::dba::users
  package { "xorg-x11-xauth":
    ensure    => present,
  }
}
node 'obiaappstage1.example.com' {
  include example::erp::users
  include example::dba::users
  include example::base::config
}
node 'obiadbstage1.example.com' {
  include example::erp::users
  include example::dba::users
  include example::base::config
}
node 'dwodiappstage1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::app
}
node /agiledbstage/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
}
node /agileappstage/ {
  include example::base::config
  include example::dba::users
  include example::oracle::app
}
node 'odysseydbstage1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}
node 'creondbstage1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}
node 'uedwdbstage1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
  include example::iscsi::base
  include example::splunk::forwarder
}
node 'webdbstage01.pni.b1p3f3dc.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}
node /dbstage/ {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}
node /erpappstage/ {
  include example::base::config
  realize (Accounts::Virtual['Antinous'])
}
node 'erpappstage1.example.com' {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
  include example::oracle::app::sudoers
}

# Oracle Nodes
node /erpapptest/ {
  include example::base::config
  include example::dba::users
}
node /iappstest/ {
  include example::base::config
  include example::oracle::db
}
node /demantradbtest/ {
  include example::base::config
  include example::dba::users
}
node /etldbtest/ {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
  include example::iscsi::base
}
node /obia/ {
  include example::base::config
  include example::erp::users
  include example::dba::users
  include example::oracle::nfs::exp
}
node /odsysrvsdbtest/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
  include example::iscsi::base
}
node /agileapptest2/ {
  include example::base::config
  include example::dba::users
  include example::oracle::app
}
node /agiledbtest2/ {
  include example::base::config
  include example::dba::users
  include example::oracle::db
}
node 'odysseydbtest1.example.com' {
  include example::base::config
  include example::dba::users
}
node 'pocdbtest1.example.com' {
  include example::base::config
  include example::dba::users
  include example::service-account
  file { '20-oracle':
    path      => '/etc/sudoers.d/20-oracle',
    ensure    => present,
    owner     => root,
    group     => root,
    mode      => 440,
    source    => "puppet:///modules/example/poc-oracle-sudoers",
  }
}

node 'webdbtest1.example.com' {
  include example::base::config
  include example::dba::users
}
node /dbtest/ {
  include example::base::config
  include example::dba::users
  include example::oracle::sudoers
}
node 'iappstest1.example.com' {
  include example::base::config
  include example::oracle::db
  include example::dba::users
}
