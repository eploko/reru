#!/usr/bin/env ruby

require 'reru'

strs = ['here we go', 'Here we go Again', 'woohoo'].as_stream
strs.map(:upcase).log
strs.start


