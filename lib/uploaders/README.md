File Uploaders
==============

All the uploaders in this directory follow an adapter pattern. They should all have a method `upload` that accepts a file buffer as an option and then returns a promise object that when resolved will return a url string of location of the uploaded file.

Once you've created your uploader, add the logic on when it should be used into `../uploader.coffee`.
