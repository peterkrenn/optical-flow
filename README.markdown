Optical Flow
============

A web application for optical flow background processing

Setup
-----

The `lucas-kanade-opencv` video processor requires OpenCV:

``` bash
$ brew install opencv
```

Background processing is handled by Resque and depends on Redis:

``` bash
$ brew install redis
```

Running the test suite
----------------------

`autotest-fsevent` improves the file-I/O performance for `autotest` on OS X. `autotest-growl`
displays test results via Growl. They can be enabled in `~/.autotest`:

``` ruby
require 'autotest/fsevent'
require 'autotest/growl'
```

Using the `spork` DRb server makes the tests run significantly faster. Start it with

``` bash
$ spork rspec
```

before running the specs with

``` bash
$ rake spec
```

or

``` bash
$ rspec spec
```
