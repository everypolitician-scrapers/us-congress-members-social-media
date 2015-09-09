#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'yaml'

def yaml_at(url)
  YAML.load(open(url).read)
end

def scrape_list(url)
  yaml_at(url).each do |person|
    data = { 'id' =>  person['id']['bioguide'] }
    person['social'].each do |k, v|
      data[k] = v unless v.nil?
    end
    ScraperWiki.save_sqlite([:id], data)
  end
end

scrape_list('https://raw.githubusercontent.com/unitedstates/congress-legislators/master/legislators-social-media.yaml')
