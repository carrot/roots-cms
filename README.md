Roots-CMS
=========

A tool for easier dynamic content management in [roots](http://roots.cx/) projects.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

Development is tracked through a public [Trello board](https://trello.com/b/IubkH8lp/roots-cms). There you can see what's being worked on and discuss future features.

Any bugs should be logged in the [Github Issue tracker](https://github.com/carrot/intel-wearables-v2/issues?direction=desc&sort=updated&state=open).

### Installation

`npm install roots-cms -g`

### Usage

`roots-cms` in your roots project directory

This starts an Express server and opens a browser to a GUI app for managing your dynamic content files. When you're finished editing, `<ctrl>+c` to stop the web server. All your changes should be written to your dynamic content files, ready for you to commit and deploy!

`mocha` will run the test suite.

### Configuring a roots project

You can configure a roots project to add additional behavior to roots-cms such as custom css templates, s3 image uploading, basic auth, and custom view templates.

Take a look at `cms.json.example` to get a good overview of what's available. Then add your own `cms.json` to the roots project to get started! Here are options you can set:

`content_dir`  
If you want to only display one directory of dynamic content, specify the path to the content directory relative to the roots project.

`basic_auth`  
Takes an object with keys `username` and `password`. Adds HTTP Basic auth if defined.

`uploader`  
Choose which file uploader to use for uploading images to the project. Use `"fs"` to upload directly into the `assets/img` directory into your roots project. Use `"s3"` for uploading images to Amazon S3 (you'll need to set `aws` in your config as well)

`img_upload_dir`  
The directory prefix to use for all uploaded images, defaults to `uploads`.

`aws`  
An object with `key`, `secret`, and `bucket` key value pairs. Used to configure the Amazon S3 client.

`templates`  
You can pass an object with key-value pairs to a jade template in your roots project that Roots-CMS will attempt to compile and use those templates for its Marionette views. Use this to customize the markup for the Roots-CMS front-end. Right now the only template you can override is `content_edit`.

`css`  
Pass it a relative path to a custom stylesheet you'd like Roots-CMS to load.

### Setting up Roots CMS in a production environment

While this app is primarily intended to be run locally, it can also be deployed to a server to manage a roots project repo on the server. A [guide](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server) to setting it up on a server can be found in the [wiki](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server).
