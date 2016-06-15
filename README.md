# Employer Verification
  

## Requirement
  $ Rails >= 4.2
## Installation

Check out this project
And then execute:

    $ bundle install 


## Configuration

  * setup smtp settings in corresponding  enivourment.rb file

```ruby
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 =>  587,
    :domain               => "gmail.com",
    :user_name            => ENV['EMAIL'],
    :password             => ENV['PASSWORD'],
    :authentication       => "plain",
    :enable_starttls_auto => true
}

```
* Set up enviorment variable in your shell

```bash
export EMAIL=''
export PASSWORD=''
export TWILO_SID=''
export TWILIO_SECRET_KEY=''
export FROM=''

```

## Run

    $ rails s


