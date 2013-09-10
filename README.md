# Spacewalk Server Cookbook #

This cookbook installs and configures a node as a [Spacewalk](http://spacewalk.redhat.com/)
server.

# Requirements #

## Platform ##

* RHEL / CentOS  > 6

# Usage #

Include `spacewalk-server` in either your `run_list` or inside a wrapper
cookbook / recipe.

# Attributes #

## default ##

- `default.spacewalk.server.db.type` - ['postgres'|'oracle'], default: 'postgres'

- `default.spacewalk.server.admin_email`
- `default.spacewalk.server.ssl.org`
- `default.spacewalk.server.ssl.org_unit`
- `default.spacewalk.server.ssl.city`
- `default.spacewalk.server.ssl.state`
- `default.spacewalk.server.ssl.country`
- `default.spacewalk.server.ssl.password`
- `default.spacewalk.server.ssl.email`
- `default.spacewalk.server.ssl.config_vhost` - ['Y'|'N'], default: 'Y'
- `default.spacewalk.server.enable_tftp` - ['Y'|'N'], default: 'N'
- `default.spacewalk.server.db.backend`
- `default.spacewalk.server.db.name`
- `default.spacewalk.server.db.user`
- `default.spacewalk.server.db.password`
- `default.spacewalk.server.db.host`
- `default.spacewalk.server.db.port`

# Recipes #

## default ##

Installs and configures Spacewalk using the embedded PostgreSQL and the answer
file generated from the attributes.

# Author #

Author:: Yet Another Clever Name (<admin@yacn.pw>)
