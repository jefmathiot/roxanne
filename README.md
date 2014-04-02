# Roxanne

Roxanne allows you to monitor Continuous Integration servers or other sources (server or
applications monitoring) and to publish the results using a notifier.

[![Build Status](https://travis-ci.org/servebox/roxanne.png)](https://travis-ci.org/servebox/roxanne)

## Installation

Add this line to your application's Gemfile:

    gem 'roxanne'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install roxanne

## Usage

### Configuration

Configuration is stored in a YAML file. By default, Roxanne will search for a `config/config.yml`
file.

#### Activation

Roxanne is configured by default to only be active between 9am and 20pm during working days. You
may use the `activation` section to change the default behavior:

```yaml
roxanne:
  activation:
    # Active from monday to wednesday
    days: !ruby/range 1..3
    # 07:00 to 14:59
    timerange: !ruby/range 7...15
```

#### Consumers

Use the `consumers` section to specify consumers configuration:

```yaml
roxanne:
 consumers:
   jenkins:
     class: "Roxanne::Jenkins::Consumer"
     host: "192.168.20.30"
     port: 8080
     use_ssl: false
     path: "/api/json"
```

#### Publisher

Use the `publisher` section to specify consumers configuration:

```yaml
roxanne:
 publisher:
   class: "Roxanne::GPIO::Publisher"
   green_pin: 25
   orange_pin: 17
   red_pin: 27
```

### Start the daemon

Start the daemon using the `start` command:

```
bundle exec roxanne start
```

If you want to specify a configuration file pass its path as the first argument:

```
bundle exec roxanne start /etc/roxanne/config.yml
```

Other available commands are obviously `stop`, `status` and `restart`.

### Available Consumers

#### Jenkins

Use the `Roxanne::Jenkins::Consumer`, available options:

* **host**: the Jenkins host name or IP address
* **port**: the TCP port the Jenkins service can be reached on
* **path**: the relative path to the JSON API (`/jenkins/api/json`)
* **username**: the username to use for HTTP Basic Auth
* **password**: the password to use for HTTP Basic Auth
* **disable_certificate_verification** : set to true if you use a self-signed SSL certificate

### Available Publishers

#### GPIO

Use the `Roxanne::GPIO::Consumer`, available options:

* **green_pin**: the GPIO pin to turn on when status changes to green
* **orange_pin**: the GPIO pin to turn on when status changes to orange
* **red_pin**: the GPIO pin to turn on when status changes to red

## Statuses

Every 5 seconds, Roxanne will loop to check the status of the consumers:

* if any of the consumers returns `red` the publisher receive `red`
* if all of the consumers return `green` the publisher receive `green`
* if the previous state **was not** `green` and one of the consumer returns `orange` the publisher
  receive `orange`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
