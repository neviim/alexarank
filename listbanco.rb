#!/usr/bin/ruby1.8
# Nome rotina: listbanco.rb

require 'rubygems'
require 'sqlite3'

#if defined?(SQLite3::Database)

  $db= SQLite3::Database.new("./db/alexarank.db")

  puts "listando dados: Codigo, Site, Rank"
  puts "----------------------------------"
  #executa comando no banco e retorna num array
  sql = $db.execute("SELECT * FROM sites")

  for row in sql
   #da a saida dos blocos 0,1,2 ou seja codigo, site, rank
   puts %Q{#{(row[0].to_s).ljust(2)} - #{row[1].ljust(25," ")} : #{row[2]}}
  end

  # fecha banco.
  $db.close

