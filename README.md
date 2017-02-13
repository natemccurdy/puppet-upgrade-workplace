# Puppet Upgrade Workspace

This project aims to help you get comfortable with upgrading from Puppet 3 to Puppet 4.

It provides a Vagrant environment that comes pre-built with:

* Puppet Enterprise 3.8 and 2016.4 masters.
* The [Catalog Preview](https://github.com/puppetlabs/puppetlabs-catalog_preview) tool
* Example Puppet code that has incompatibilities
* A CentOS Puppet agent

## Setup

1. Install Vagrant 1.5+

  <https://www.vagrantup.com>

1. Install VirtualBox or VMWare

  * <https://www.virtualbox.org/wiki/Downloads>
  * <https://my.vmware.com/web/vmware/info?slug=desktop_end_user_computing/vmware_fusion/8_0>

    > Note: You will need the [Vagrant VMware provider](https://www.vagrantup.com/docs/vmware/installation.html) to use Vagrant with VMWare.

3. Install Vagrant Plugins

  * `vagrant plugin install oscar`

    This will install the `oscar` Vagrant plugin which allows for automating much of the setup of the Vagrant VM's.
    <https://github.com/oscar-stack/oscar>

## Comparing Catalogs

### Running Catalog Preview

Bring up and connect to the PE 3.8 master:

```shell
vagrant up pe-38-master
vagrant ssh pe-38-master
```

Run the Catalog Preview tool to generate a catalog comparison:

```shell
sudo /opt/puppet/bin/puppet preview \
  --baseline-environment production \
  --preview-environment future_production \
  --migrate 3.8/4.0 \
  --nodes /vagrant/nodes.txt \
  --view overview-json | tee /vagrant/catalog_preview_overview-baseline.json
```

Take a look at the JSON report to see the issues that Catalog Preview found. We're saving the report to JSON to make it easier to convert to an HTML report in the next step. If you'd like this to be a bit more human-readable, change the `--view` to `overview`:

```shell
sudo /opt/puppet/bin/puppet preview \
  --baseline-environment production \
  --preview-environment future_production \
  --migrate 3.8/4.0 \
  --nodes /vagrant/nodes.txt \
  --view overview
```

### Generating an HTML report

```shell
/etc/puppetlabs/puppet/environments/production/modules/preview_report/preview_report.rb \
-f /vagrant/catalog_preview_overview-baseline.json \
-w /vagrant/preview_report.html
```

