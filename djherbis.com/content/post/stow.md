+++
date = "2015-03-10T21:55:40-04:00"
title = "#golang persistence with boltdb and djherbis/stow"
author = "djherbis"
tags = ["golang", "persistence", "boltdb"]

+++

## [djherbis/stow](https://github.com/djherbis/stow)

[![GoDoc](https://godoc.org/github.com/djherbis/stow?status.svg)](https://godoc.org/github.com/djherbis/stow)
[![Release](https://img.shields.io/github/release/djherbis/stow.svg)](https://github.com/djherbis/stow/releases/latest)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.txt)
[![Build Status](https://travis-ci.org/djherbis/stow.svg?branch=master)](https://travis-ci.org/djherbis/stow)
[![Coverage Status](https://coveralls.io/repos/djherbis/stow/badge.svg?branch=master)](https://coveralls.io/r/djherbis/stow?branch=master)
[![Go Report Card](https://goreportcard.com/badge/github.com/djherbis/stow)](https://goreportcard.com/report/github.com/djherbis/stow)

I like the simplicity behind [boltdb](https://github.com/boltdb/bolt) however constantly converting your structs to and from an []byte can introduce a lot of extra code.

So I created [stow](https://github.com/djherbis/stow). Stow wraps a bucket in your boltdb database so that it works a little bit more like a map.

Stow can use any encoding for storing your data, which will be transparently encoded/decoded when you [Put](http://godoc.org/github.com/djherbis/stow#Store.Put), [Get](http://godoc.org/github.com/djherbis/stow#Store.Get) or [Pull](http://godoc.org/github.com/djherbis/stow#Store.Pull) from your [Store](http://godoc.org/github.com/djherbis/stow#Store).

[Json](http://godoc.org/github.com/djherbis/stow#JSONCodec), [Xml](http://godoc.org/github.com/djherbis/stow#XMLCodec), and [Gob](http://godoc.org/github.com/djherbis/stow#GobCodec) (which includes Binary) encodings are built-in and use the stdlib, but feel free to implement your own [Codec](http://godoc.org/github.com/djherbis/stow#Codec).

<script src="https://gist.github.com/djherbis/898283c55f1b58811840.js"></script>