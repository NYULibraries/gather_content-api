# GatherContent Ruby Client

[![Build Status](https://travis-ci.org/NYULibraries/gather_content-api.svg?branch=master)](https://travis-ci.org/NYULibraries/gather_content-api)
[![Dependency Status](https://gemnasium.com/badges/github.com/NYULibraries/gather_content-api.svg)](https://gemnasium.com/github.com/NYULibraries/gather_content-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/ace52f297d3f4160799d/maintainability)](https://codeclimate.com/github/NYULibraries/gather_content-api/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/gather_content-api/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/gather_content-api?branch=master)

This gem is a light wrapper around the [GatherContent API](https://docs.gathercontent.com/reference).

All the endpoints are represented by Objects. Collective Objects (ie Projects, Items etc) are Enumerable, allowing you to loop over them. Singular Objects act like Hashes, giving access to the data via keys.

You can access the underlying data of a Singular Object by using the ```#fetch``` method. The ```#fetch``` method will cache the result - if you want to clear the result, call ```#reset```

# Usage

## Authentication

There are two was to setup [authentication](https://docs.gathercontent.com/reference#authentication):

1. using the _Config_ object
2. via Environmental variables

### The Config Object

```ruby
GatherContent::Api::Config.run do |config|
  config.username = "Your GatherContent username"
  config.api_key = "Your GatherContent API key"
end
```

### Environmental Variables

```bash
export GATHER_CONTENT_API_USERNAME="Your GatherContent username"
export GATHER_CONTENT_API_KEY="Your GatherContent API key"
ruby script_that_uses_the_gem.rb
```

## Me

You have access to all fields of information about the logged in User such as their avatar url, name, and other fields. [Sample Response](https://docs.gathercontent.com/reference#get-me)


```ruby
require 'gather_content'

me = GatherContent::Api::Me.new
me["email"]
=> "andrew@gathercontent.com"

me["first_name"]
=> "Andrew"
```

## Accounts

Retrieves a list of all Accounts associated with the authenticated user. [Sample Response](https://docs.gathercontent.com/reference#get-accounts)

```ruby
require 'gather_content'

accounts = GatherContent::Api::Accounts.new
accounts.each do |account|
  puts account["id"]
  puts account["name"]
end
```

## Account

Retrieve a specific account. [Sample Response](https://docs.gathercontent.com/reference#get-accountsaccount_id)

```ruby
require 'gather_content'

account_id = 123456
accounts = GatherContent::Api::Account.new(account_id)

account["id"]
=> 123456

account["name"]
=> "Example"
```

## Projects

Retrieves a list of all Projects associated with the given Account. [Sample Response](https://docs.gathercontent.com/reference#get-projects)

```ruby
require 'gather_content'

account_id = 123456
projects = GatherContent::Api::Projects.new(account_id)

projects.each do |project|
  puts project["id"]
  puts project["name"]
end
```

### Project

Retrieves all information for a specific Project. [Sample Response](https://docs.gathercontent.com/reference#get-project-by-id)

```ruby
require 'gather_content'

project_id = 123456
project = GatherContent::Api::Project.new(project_id)

project["id"]
=> 123456

project["name"]
=> "Example Project"
```

### Creating a Project

Creates a new Project for a specific Account. When you create a Project, a default Workflow containing four Statuses will be created and associated with it. As part of this request a type can be passed as an argument to specify the project type.

Supported project types

* website-build
* ongoing-website-content
* marketing-editorial-content
* email-marketing-content
* other

If successful, will return the newly created project.

On failure, it will throw a GatherContent::Error::RequestError

[Sample Response](https://docs.gathercontent.com/reference#post-projects)

```ruby
require 'gather_content'

account_id = 123456

begin
  p = GatherContent::Api::Projects.new(account_id)
  # Name is required. Type defaults to "other"
  project = p.create{ "name" => "Project Name", "type" => "website-build" })

  name = project["name"]
rescue GatherContent::Error::RequestError => e
  puts e.message
end
```

### Statuses

Retrieves a list of all the Statuses (what we call the Project’s Workflow) associated with a given Project. This includes their names, descriptions, associated colours and their Due Dates. [Sample Response](https://docs.gathercontent.com/reference#get-project-statuses)

```ruby
require 'gather_content'

project_id = 123456
statuses = GatherContent::Api::Statuses.new(project_id)

statuses.each do |status|
  puts status["id"]
  puts status["name"]
end
```

### Status

Retrieves a list of all the Statuses (what we call the Project’s Workflow) associated with a given Project. This includes their names, descriptions, associated colours and their Due Dates. [Sample Response](https://docs.gathercontent.com/reference#get-project-statuses-by-id)

```ruby
require 'gather_content'

status_id = 123456
status = GatherContent::Api::Status.new(status_id)

status["id"]
=> 123456

status["name"]
=> "Draft"
```

## Items

Get a list of all Items that exist on a particular Project.

```ruby
require 'gather_content'

project_id = 123456
items = GatherContent::Api::Items.new(project_id)

items.each do |item|
  puts item["id"]
  puts item["name"]
end
```

### Item

Get all data related to a particular Item within a Project. You can access all of its properties, including the content which will be separated by the different fields it contains.

```ruby
require 'gather_content'

item_id = 123456
item = GatherContent::Api::Item.new(item_id)

item["id"]
=> 123456

item["name"]
=> "Home"
```

### Create an item

Creates a new Item within a particular Project.

Use the handy [DSL](#config-dsl) to generate a [config field](https://docs.gathercontent.com/reference#the-config-field).


If successful, will return the newly created item.

On failure, it will throw a GatherContent::Error::RequestError

```ruby
require 'gather_content'

project_id = 123456

config = GatherContent::Config::Builder.build do
  label "Content"
  name "tab1"
  hidden false

  text do
    name "el1"
    required false
    label "Blog post"
    value "Hello world"
    microcopy ""
    limit_type :words
    limit 1000
    plain_text false
  end
end

begin
  i = GatherContent::Api::Items.new(project_id)
  item = i.create({
    "name" => "Item Name", # Required
    "parent_id" => 123456, # Optional
    "template_id" => 123456, # Optional
    "config" => config, # Optional
  });

  puts item["name"]

rescue GatherContent::Error::RequestError => e
  puts e.message
end
```

### Save an item

Saves an Item with the newly updated data. It expects a valid configuration structure, otherwise the save request will not be accepted by the API.

Use the handy [DSL](#config-dsl) to generate a [config field](https://docs.gathercontent.com/reference#the-config-field).

```ruby
require 'gather_content'

item_id = 123456
item = GatherContent::Api::Item.new(item_id)

config = GatherContent::Config::Builder.build do
  label "Content"
  name "tab1"
  hidden false

  text do
    name "el1"
    required false
    label "Blog post"
    value "Hello world"
    microcopy ""
    limit_type :words
    limit 1000
    plain_text false
  end
end

begin
  item.save(config)
rescue GatherContent::Error::RequestError => e
  puts e.message
end
```

On failure, it will throw a GatherContent::Error::RequestError

### Apply a template to an item

Applies the structure of a Template to an existing Item.

Beware that, just like within the application, this action will override the existing structure of an Item and may result in loss of content when fields do not match. Ensure you take necessary precautions.

```ruby
require 'gather_content'

item_id = 123456
item = GatherContent::Api::Item.new(item_id)

template_id = 123456
begin
  item.apply_template(template_id)
rescue GatherContent::Error::RequestError => e
  puts e.message
end
```

On failure, it will throw a GatherContent::Error::RequestError

### Choose Status

Set the status of the item

```ruby
require 'gather_content'

item_id = 123456
item = GatherContent::Api::Item.new(item_id)

status_id = 123456
begin
  item.choose_status(status_id)
rescue GatherContent::Error::RequestError => e
  puts e.message
end
```

On failure, it will throw a GatherContent::Error::RequestError

### Files

Get a list of all files related to a particular Item. [Sample Response](https://docs.gathercontent.com/reference#get-item-files)

```ruby
require 'gather_content'

item_id = 123456
files = GatherContent::Api::Files.new(item_id)

files.each do |file|
  puts file["id"]
  puts file["filename"]
end
```

## Templates

Retrieves a list of all Templates associated with the given Project. [Sample Response](https://docs.gathercontent.com/reference#get-templates)

```ruby
require 'gather_content'

project_id = 123456
templates = GatherContent::Api::Templates.new(project_id)

templates.each do |template|
  puts template["id"]
  puts template["name"]
end
```

### Template

This retrieves all data related with a specific Template. [Sample Response](https://docs.gathercontent.com/reference#get-template-by-id)

```ruby
require 'gather_content'

template_id = 123456
template = GatherContent::Api::Status.new(template_id)

template["id"]
=> 123456

template["name"]
=> "Blog theme"
```

## Config DSL

This gem also includes a handy DSL to make creating configurations simple.

### Getting started

Every configuration object starts with some tabs (You can define as many as you like)

```ruby
config = GatherContent::Config::Builder.build do
  tab do
    name "website"                        # Required. Must be unique.
    label "Website"                       # Required
    hidden false
  end

  tab do
    name "email"
    label "Email"
    hidden: false
  end
end
```

### Tabs

Tabs can have sections, text, files, radio buttons and checkboxes

```ruby
config = GatherContent::Config::Builder.build do
  tab do
    name "website"
    label "Website"
    hidden false

    section do
      name "main"                       # Required. Must be unique.
      label "Main Copy"                 # Required
      subtitle ""
    end

    text do
      name "title"                      # Required. Must be unique.
      label "Title"                     # Required
      required true
      value ""
      microcopy "The title of the page"
      limit_type :words                 # Can be :words or :chars
      limit 100                         # Must be positive
      plain_text false
    end

    files do
      name: "images"                    # Required. Must be unique.
      label "Images"                    # Required
      required false
      microcopy "Upload any images referenced in the post"
    end

    choice_radio do
      name "post_type"
      label "Post type"
      required true
      microcopy "What type of post is this?"
      option do
        name "regular"
        label "Regular page"
        selected true
      end
      option do
        name "blog"
        label "Blog Post"
        selected false
      end
    end

    choice_checkbox do
      name "notify"
      label "Notify on publish"
      required true
      microcopy "Who needs to be notified when this post is published?"

      # This DSL is just regular Ruby, so you can do things like...
      [ 'joe@example.com', 'kathy@example.com', 'sam@example.com' ].each_with_index do |email, index|
        option do
          name "email_#{index}"
          label email
          selected false
        end
      end
    end
  end
end
```

### Radio choices with an "other" option

If you set option_other to true, the last option needs to have a value if you set it to true.

```ruby
choice_radio do
  name "post_type"
  label "Post type"
  required false
  microcopy "What type of post is this?"
  option do
    name "regular"
    label "Regular page"
    selected false  # Only one radio option can be selected at a time.
  end
  option do
    name "blog"
    label "Blog Post"
    selected false
  end
  option do
    name "other"
    label "Other"
    selected true
    value "Push notification"   # If the last option is selected, you need to supply a value.
  end
end
```
