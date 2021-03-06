# file-downloader-service

[![Dependency status](http://img.shields.io/david/octoblu/file-downloader-service.svg?style=flat)](https://david-dm.org/octoblu/file-downloader-service)
[![devDependency Status](http://img.shields.io/david/dev/octoblu/file-downloader-service.svg?style=flat)](https://david-dm.org/octoblu/file-downloader-service#info=devDependencies)
[![Build Status](http://img.shields.io/travis/octoblu/file-downloader-service.svg?style=flat&branch=master)](https://travis-ci.org/octoblu/file-downloader-service)

[![NPM](https://nodei.co/npm/file-downloader-service.svg?style=flat)](https://npmjs.org/package/file-downloader-service)

## Routes

### **GET** /download

Query:
* url:
  - The URL of the file to download.
* fileName:
  - Override the content-disposition with a fileName

Download from url and override content-disposition (filename).

### **GET** /github-release/:owner/:repo/:tag/:asset

Query:
* fileName:
  - Override the content-disposition with a fileName

Download from url and override content-disposition (filename).


## License

The MIT License (MIT)

Copyright 2016 Octoblu Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
