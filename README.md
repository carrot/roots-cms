Roots-CMS
=========

A tool for easier dynamic content management in [roots](http://roots.cx/) projects.

> **Note:** This project is in early, active development and is not ready for use. Expect any and all API specs to change at any notice, there's still a lot of experimentation going on around here. If you'd like to contribute or view the project so far, the most stable branch is `develop`.

### Installation

`npm install roots-cms -g`

### Usage

`roots-cms` in your roots project directory

This starts an Express server and opens a browser to a GUI app for managing your dynamic content files. When you're finished editing, `<ctrl>+c` to stop the web server. All your changes should be written to your dynamic content files, ready for you to commit and deploy!

`mocha` will run the test suite.

### Setting up Roots CMS in a production environment

While this app is primarily intended to be run locally, it can also be deployed to a server to manage a roots project repo on the server. Copy `config.coffee.example` and `deploy.conf.example`, remove `.example`, and update the config values. Note that this will not be a supported feature, but it is possible, try at your own risk.

### License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
