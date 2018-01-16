+++
date = "2015-03-28T14:48:31-04:00"
title = "#golang stream caching"
author = "djherbis"
tags = ["golang", "stream", "cache"]

+++

## [djherbis/fscache](https://github.com/djherbis/fscache)

[![GoDoc](https://godoc.org/github.com/djherbis/fscache?status.svg)](https://godoc.org/github.com/djherbis/fscache)
[![Release](https://img.shields.io/github/release/djherbis/fscache.svg)](https://github.com/djherbis/fscache/releases/latest)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.txt)
[![Build Status](https://travis-ci.org/djherbis/fscache.svg?branch=master)](https://travis-ci.org/djherbis/fscache)
[![Coverage Status](https://coveralls.io/repos/djherbis/fscache/badge.svg?branch=master)](https://coveralls.io/r/djherbis/fscache?branch=master)
[![Go Report Card](https://goreportcard.com/badge/github.com/djherbis/fscache)](https://goreportcard.com/report/github.com/djherbis/fscache)

## Objective

* Our Web server needs to perform an “expensive” process to create downloads.
* We want to cache these files so they don’t have to be generated on every request.
* If two or more concurrent clients ask for the same file, don’t generate it twice.

A naive cache design might look like this:
<script src="https://gist.github.com/djherbis/450ac4dfd1c062593d25.js"></script>

Well the above code is pretty bad. We’re blocking all requests while the cache is being written to.

But we need the lock since if we have a cache miss we’ll need to write it. If we only lock while checking the map and then again when inserting into the map there’s the potential for multiple clients to do expensiveProcessReader().

So we’ll need to add another requirement:

* Don’t block clients while writing to the cache

But this raises a another problem, we need to be able to read and write concurrently.

## Solved by djherbis/fscache.

* you can read from and write to a stream concurrently
* multiple readers are allowed (even while writing)
* all readers get a complete copy of the stream
* each reader can read independently of other readers
* readers only return io.EOF once the writer is closed.
* readers block if they catch up to the writer, and only read when data is available

Our problem becomes incredibly easy with the help of fscache:
<script src="https://gist.github.com/djherbis/be170c3f3a5e489ce216.js"></script>

## How does it work?
fscache only locks briefly, and creating a new cache entry is always fast.

A new cache entry just contains an empty “File” which can be read/written from concurrently.

Normally, if a reader and a writer both have access to a stream, the reader returns io.EOF when it catches up.

To get around this we borrow some ideas from io.Pipe(). If the readers catch up to the writer, they block until they are signaled by a new Write() or Close() action by the writer. Therefore the readers sit patiently until data is available, and don’t return io.EOF until the writer closes.