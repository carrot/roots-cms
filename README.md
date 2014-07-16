Roots-CMS
=========

[![Build Status](https://travis-ci.org/carrot/roots-cms.svg?branch=tests-and-structure)](https://travis-ci.org/carrot/roots-cms)

A tool for easier dynamic content management in [roots](http://roots.cx/) projects.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

Development is tracked through a public [Trello board](https://trello.com/b/IubkH8lp/roots-cms). There you can see what's being worked on and discuss future features.

Any bugs should be logged in the [Github Issue tracker](https://github.com/carrot/intel-wearables-v2/issues?direction=desc&sort=updated&state=open).

### Installation

requires node version > 0.10

`npm install roots-cms -g`

### Usage

`roots-cms` in your roots project directory

This starts an Express server and opens a browser to a GUI app for managing your dynamic content files. When you're finished editing, `<ctrl>+c` to stop the web server. All your changes should be written to your dynamic content files, ready for you to commit and deploy!

`npm test` runs the test suite.

### Configuration

Roots CMS reads special configuration from a JSON file (`cms.json`). This JSON file enables configuration as well as enhanced CMS functionality like custom css templates, s3 image uploading, basic auth, and custom view templates.

Take a look at [`cms.json.example`](/cms.json.example) to get a good overview of what's available. Then add your own `cms.json` to the roots project to get started. Here are options you can set:

**content_dir:** If you want to only display one directory of dynamic content, specify the path to the content directory relative to the roots project.

```json
{"content_dir": "blog_posts"}
```

**basic_auth:** Takes an object with keys `username` and `password`. Adds HTTP Basic auth if defined.

```json
{
  "basic_auth": {
    "username": "username",
    "password": "password"
  }
}
```

**uploader:** Choose which file uploader adapter to use for uploading images to the project. Defaults to uploading to the roots project's file system. Specify the `adapter`, each adapter will have additional options that can be passed in.

FS uploader config:

```json
{
  "uploader": {
    "adapter": "fs",
    "dir": "assets/img/uploads"
  }
}
```
S3 uploader config:

```json
{
  "uploader": {
    "adapter": "s3",
    "key": "XXX",
    "secret": "XXX",
    "bucket": "bucket-name"
  }
}
```

**templates:** You can pass an object with key-value pairs to a jade template in your roots project that Roots-CMS will attempt to compile and use those templates for its Marionette views. Use this to customize the markup for the Roots-CMS front-end. Right now the only template you can override is `content_edit`.

```json
{
  "templates": {
    "content_edit": "assets/cms/templates/_content_show.jade"
  }
}
```

**css:** Pass it a relative path to a custom stylesheet you'd like Roots-CMS to load.

```json
{ "css": "assets/css/_blogging.styl" }
```

### Setting up Roots CMS in a production environment

While this app is primarily intended to be run locally, it can also be deployed to a server to manage a roots project repo on the server. A [guide](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server) to setting it up on a server can be found in the [wiki](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server).
