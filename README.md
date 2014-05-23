#GotCms Cookbook (Work in progress)[![Build Status](https://travis-ci.org/GotCms/gotcms-cookbook.svg?branch=master)](https://travis-ci.org/GotCms/gotcms-cookbook)

The Chef GotCms cookbook installs and configures GotCms.

##Requirements

###Platform

* Ubuntu
* Debian
* RHEL/CentOS

###Cookbooks

* apt
* apache2
* build-essential
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
    <td><tt>gotcms['version']</tt></td>
    <td>String</td>
    <td>Version of GotCms to download. Use 'master', to download most recent version.</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['url']</tt></td>
    <td>String</td>
    <td>Url of GotCms to download.</td>
    <td><tt>https://github.com/GotCms/GotCms/archive/#{node['gotcms']['version']}.tar.gz</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['parent_dir']</tt></td>
    <td>String</td>
    <td>Parent directory to where GotCms will be extracted.</td>
    <td><tt>node['apache']['docroot_dir']</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['dir']</tt></td>
    <td>String</td>
    <td>Location to plage GotCms files.</td>
    <td><tt>#{node['gotcms']['parent_dir']}/gotcms</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['db']['driver']</tt></td>
    <td>String</td>
    <td>Driver of the GotCms database (should be pdo_mysql or pdo_pgsql).</td>
    <td><tt>pdo_mysql</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['db']['username']</tt></td>
    <td>String</td>
    <td>Name of the GotCms database user.</td>
    <td><tt>gotcmsuser</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['db']['password']</tt></td>
    <td>String</td>
    <td>Password of the GotCms database user.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['db']['name']</tt></td>
    <td>String</td>
    <td>Name of the GotCms database.</td>
    <td><tt>gotcmsdb</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['db']['host']</tt></td>
    <td>String</td>
    <td>Host of the GotCms database.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['server_name']</tt></td>
    <td>String</td>
    <td>Server name for apache2 virtualhost.</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['language']</tt></td>
    <td>String</td>
    <td>Language to used.</td>
    <td><tt>en_GB</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['website_name']</tt></td>
    <td>String</td>
    <td>Name of the website.</td>
    <td><tt>GotCms</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['is_offline']</tt></td>
    <td>Boolean</td>
    <td>Set the website offline.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['admin_email']</tt></td>
    <td>String</td>
    <td>The admin email.</td>
    <td><tt>demo@got-cms.com</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['admin_lastname']</tt></td>
    <td>String</td>
    <td>The admin last name.</td>
    <td><tt>GotCms</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['admin_firstname']</tt></td>
    <td>String</td>
    <td>The admin first name.</td>
    <td><tt>GotCms</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['admin_login']</tt></td>
    <td>String</td>
    <td>The admin login.</td>
    <td><tt>demo</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['admin_password']</tt></td>
    <td>String</td>
    <td>The admin password.</td>
    <td><tt>demo</tt></td>
  </tr>
  <tr>
    <td><tt>gotcms['config']['template']</tt></td>
    <td>String</td>
    <td>The template to use for installation, can be `silverblog`, `arcana`, or `photoartwork`.</td>
    <td><tt>arcana</tt></td>
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
