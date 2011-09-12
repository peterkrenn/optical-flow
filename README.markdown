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

Run the specs with

``` bash
$ rake spec
```

or

``` bash
$ rspec spec
```

or run them automatically, faster and on file modification with

``` bash
$ guard
```
