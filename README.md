# Apple Media API

Apple Media acts as an abstraction for interacting with Apple's Music API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple-media', git: 'git@github.com:assemble-inc/apple-media-api.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apple-media-api

Create a `$PROJECT_ROOT/.env` file with your API authentication information:

    APPLE_SECRET_KEY="-----BEGIN PRIVATE KEY-----\nabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/+\n-----END PRIVATE KEY-----"
    APPLE_KEY_ID=ABCDEFG012
    APPLE_TEAM_ID=HIJKLMN345

Note that the underlying libraries are _very_ sensitive to how `APPLE_SECRET_KEY` is formatted.

Test the configuration by verifying `rake load_client` exits silently without error.

## Contributing

Contact Chris (chris [at] weassemble.com)
Melissa (melissa [at] weassemble.com)
Matthew (matthew [at] weassemble.com)
