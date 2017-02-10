# Puppet Upgrade Workspace

This project provides a Vagrant environment for demonstrating the process of upgrading Puppet code from Puppet 3 to Puppet 4 compatibility

## Setup

### Install Vagrant 1.5+

<https://www.vagrantup.com>

### Install VirtualBox or VMWare

* <https://www.virtualbox.org/wiki/Downloads>

* <https://my.vmware.com/web/vmware/info?slug=desktop_end_user_computing/vmware_fusion/8_0>

  > Note: You will need the [Vagrant VMware provider](https://www.vagrantup.com/docs/vmware/installation.html) to use Vagrant with VMWare.

### Install Vagrant Plugins

* `vagrant plugin install oscar`:

  This will install the `oscar` Vagrant plugin.
  <https://github.com/oscar-stack/oscar>

## Comparing Catalogs

### Running Catalog Preview

```shell
vagrant up pe-386-master
```

```shell
vagrant ssh pe-386-master
```

```shell
sudo /opt/puppet/bin/puppet preview \
  --baseline-environment production \
  --preview-environment future_production \
  --migrate 3.8/4.0 \
  --nodes /vagrant/nodes.txt \
  --view overview-json | tee /vagrant/catalog_preview_overview-baseline.json
```

### Generating an HTML report

```shell
/etc/puppetlabs/puppet/environments/production/modules/preview_report/preview_report.rb \
-f /vagrant/catalog_preview_overview-baseline.json \
-w /vagrant/preview_report.html
```

