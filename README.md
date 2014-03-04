Roots-CMS
=========

A tool for easier dynamic content management in [roots](http://roots.cx/) projects.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Installation

`npm install roots-cms -g`

### Usage

`roots-cms` in your roots project directory

This starts an Express server and opens a browser to a GUI app for managing your dynamic content files. When you're finished editing, `<ctrl>+c` to stop the web server. All your changes should be written to your dynamic content files, ready for you to commit and deploy!

`mocha` will run the test suite.

### Setting up Roots CMS in a production environment

While this app is primarily intended to be run locally, it can also be deployed to a server to manage a roots project repo on the server. A [guide](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server) to setting it up on a server can be found in the [wiki](https://github.com/carrot/roots-cms/wiki/Deploying-Roots-CMS-to-a-server).
