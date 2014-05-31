#GotCms Cookbook [![Build Status](https://travis-ci.org/GotCms/gotcms-cookbook.svg?branch=master)](https://travis-ci.org/GotCms/gotcms-cookbook)

The Chef GotCms cookbook installs and configures GotCms.

##Requirements

###Platform

Requires PHP 5.3.23 or later, we recommend using the latest PHP version whenever possible. So a recent linux distribution ;)

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
| Key                                 | Type    | Description                                                                             | Default                                                                       |
|-------------------------------------|---------|-----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| gotcms['version']                   | String  | Version of GotCms to download. Use 'master', to download most recent version.           | master                                                                        |
| gotcms['url']                       | String  | Url of GotCms to download.                                                              | https://github.com/GotCms/GotCms/archive/#{node['gotcms']['version']}.tar.gz  |
| gotcms['parent_dir']                | String  | Parent directory to where GotCms will be extracted.                                     | node['apache']['docroot_dir']                                                 |
| gotcms['dir']                       | String  | Location to plage GotCms files.                                                         | #{node['gotcms']['parent_dir']}/gotcms                                        |
| gotcms['db']['driver']              | String  | Driver of GotCms database (can be pdo_mysql or pdo_pgsql).                              | pdo_mysql                                                                     |
| gotcms['db']['username']            | String  | Name of the GotCms database user.                                                       | gotcmsuser                                                                    |
| gotcms['db']['password']            | String  | Password of the GotCms database user.                                                   | gotcmspassword                                                                |
| gotcms['db']['name']                | String  |  Name of the GotCms database.                                                           | gotcmsdb                                                                      |
| gotcms['db']['host']                | String  | Host of the GotCms database.                                                            | localhost                                                                     |
| gotcms['server_name']               | String  | Server name for apache2 virtualhost.                                                    | node['fqdn']                                                                  |
| gotcms['server_aliases']            | String  | Server aliases for apache2 virtualhost.                                                 | [node['fqdn']]                                                                |
| gotcms['config']['language']        | String  | Language to used.                                                                       | en_GB                                                                         |
| gotcms['config']['website_name']    | String  | Name of the website.                                                                    | GotCms                                                                        |
| gotcms['config']['is_offline']      | Boolean | Set the website offline.                                                                | false                                                                         |
| gotcms['config']['admin_email']     | String  | The admin email.                                                                        | demo@got-cms.com                                                              |
| gotcms['config']['admin_lastname']  | String  | The admin last name.                                                                    | GotCms                                                                        |
| gotcms['config']['admin_firstname'] | String  | The admin first name.                                                                   | GotCms                                                                        |
| gotcms['config']['admin_login']     | String  | The admin login.                                                                        | demo                                                                          |
| gotcms['config']['admin_password']  | String  | The admin password.                                                                     | demo                                                                          |
| gotcms['config']['template']        | String  | The template to use for installation, can be `silverblog`, `arcana`, or `photoartwork`. | arcana                                                                        |


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
