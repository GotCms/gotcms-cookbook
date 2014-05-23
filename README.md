#GotCms Cookbook (Work in progress)[![Build Status](https://travis-ci.org/GotCms/gotcms-cookbook.svg?branch=master)](https://travis-ci.org/GotCms/gotcms-cookbook)

The Chef GotCms cookbook installs and configures GotCms.

##Requirements

###Platform

* Ubuntu
* Debian
* RHEL/CentOS

###Cookbooks

* apache2
* database
* mysql
* php
* postgresql

##Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gotcms']['version']</tt></td>
    <td>String</td>
    <td>Version of GotCms to download. Use 'master', to download most recent version.</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['url']</tt></td>
    <td>String</td>
    <td>Url of GotCms to download.</td>
    <td><tt>https://github.com/GotCms/GotCms/archive/#{node['gotcms']['version']}.tar.gz</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['parent_dir']</tt></td>
    <td>String</td>
    <td>Parent directory to where GotCms will be extracted.</td>
    <td><tt>node['apache']['docroot_dir']</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['dir']</tt></td>
    <td>String</td>
    <td>Location to plage GotCms files.</td>
    <td><tt>#{node['gotcms']['parent_dir']}/gotcms</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['db']['driver']</tt></td>
    <td>String</td>
    <td>Driver of the GotCms database (should be pdo_mysql or pdo_pgsql).</td>
    <td><tt>pdo_mysql</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['db']['username']</tt></td>
    <td>String</td>
    <td>Name of the GotCms database user.</td>
    <td><tt>gotcmsuser</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['db']['password']</tt></td>
    <td>String</td>
    <td>Password of the GotCms database user.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['db']['name']</tt></td>
    <td>String</td>
    <td>Name of the GotCms database.</td>
    <td><tt>gotcmsdb</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['db']['host']</tt></td>
    <td>String</td>
    <td>Host of the GotCms database.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['server_name']</tt></td>
    <td>String</td>
    <td>Server name for apache2 virtualhost.</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
  <tr>
    <td><tt>['gotcms']['server_aliases']</tt></td>
    <td>String</td>
    <td>Server aliases for apache2 virtualhost.</td>
    <td><tt>[node['fqdn']]</tt></td>
  </tr>
</table>

##Usage


#### gotcms::default
Just include `gotcms` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gotcms]"
  ]
}
```

##Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `issue_x`)
3. Write your change
4. Write tests for your change
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

##License and Authors

* Authors: Pierre Rambaud (pierre.rambaud86@gmail.com)
