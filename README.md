[![Build Status](https://travis-ci.org/mburns/paramount.svg?branch=master)](https://travis-ci.org/mburns/paramount)
[![Coverage Status](https://coveralls.io/repos/github/mburns/paramount/badge.svg?branch=master)](https://coveralls.io/github/mburns/paramount?branch=master)
[![Code Climate](https://codeclimate.com/github/mburns/paramount/badges/gpa.svg)](https://codeclimate.com/github/mburns/paramount)
[![Test Coverage](https://codeclimate.com/github/mburns/paramount/badges/coverage.svg)](https://codeclimate.com/github/mburns/paramount/coverage)
[![Issue Count](https://codeclimate.com/github/mburns/paramount/badges/issue_count.svg)](https://codeclimate.com/github/mburns/paramount)

# Paramount Cookbook

A Chef cookbook for running a personal computer stack.

Inspired by https://github.com/al3x/sovereign

## Supported Platforms

 * Ubuntu 14.04 LTS

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['paramount']['domain']</tt></td>
    <td>String</td>
    <td>FQDN</td>
    <td><tt>example.com</tt></td>
  </tr>
  <tr>
    <td><tt>['paramount']['user']</tt></td>
    <td>String</td>
    <td>Username</td>
    <td><tt>admin</tt></td>
  </tr>
  <tr>
    <td><tt>['paramount']['contact']</tt></td>
    <td>String</td>
    <td>E-Mail address</td>
    <td><tt>*computed*</tt></td>
  </tr>
</table>

## Usage

### paramount::default

Include `paramount` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[paramount::default]"
  ]
}
```

## License and Authors

Author:: Michael Burns (michael@mirwin.net)

[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.3.0/dist/gratipay.svg)](https://gratipay.com/USERNAME/)
