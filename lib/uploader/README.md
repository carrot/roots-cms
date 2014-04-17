Image Uploaders
==============

Image uploaders in this directory follow an adapter pattern. The appropriate uploader is loaded through a wrapper `Uploader` class in `index.coffee`. This should be the only public interface to image uploaders for other components in the project.  This class will then instatiate the relevant uploader adapter based on the config.

All uploaders should have a method `upload` that accepts a file path and returns a promise object that when resolved returns the image's URL.

The default uploader is `BaseUploader`. This will upload the image directly into the roots project. `BaseUploader` can be extended to quickly create other adapters. Just override `setup`, `read_file`, `upload_file`, and `return_url` as you see fit, look at `S3Uploader` for an example.

Once you've created your uploader, add it to the list of uploaders in `index.coffee`.
