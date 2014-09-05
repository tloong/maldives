# coding: utf-8

# (A)
require 'rubygems'    # Ruby1.9 or above is required
require 'thinreports'

# (B)
report = ThinReports::Report.new :layout => '/Users/jakobcho/railsbridge/tXoong/util/hello_world.tlf'

# (C) Page 1
report.start_new_page



report.generate   :filename => "hello_world.pdf"