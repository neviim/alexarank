#!/usr/bin/ruby1.8
#por: neviim
#alexarank.rb

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'

def ler_rank(url)
 #abre e le a pagina para doc.
 doc = Nokogiri::HTML(open("http://www.alexa.com/siteinfo/"+url))

 # variavel temporaria.
 nomeky   = ""
 rankal   = rankbr   = linkin   = "" 
 rankyest = chanyest = statyest = ""
 rankdia7 = chandia7 = statdia7 = ""
 rankmes1 = chanmes1 = statmes1 = ""
 rankmes3 = chanmes3 = statmes3 = ""

 # pega o titulo da pagina.
 puts doc.at_css("title").text

 doc.css("#content-inner").each do |item|
    # ler ranks e link
    rankal = item.at_css("td:nth-child(2) .data").text.gsub!(/\D/, "")
    rankbr = item.at_css("td:nth-child(3) .data").text.gsub!(/\D/, "")
    linkin = item.at_css("td:nth-child(4) .data").text.gsub!(/\D/, "")
 end

 doc.css("#rank").each do |item|
    # nome key    
    nomeky = item.at_css("tr:nth-child(2) th").text
    #puts nomeky
    # yeaterday
    rankyest = item.at_css("tr:nth-child(2) .avg").text.gsub!(/\D/, "")
    chanyest = item.at_css("tr:nth-child(2) .percent").text.gsub!(/\D/, "")
    statyest = item.at_css("tr:nth-child(2) .percent").text[1..1] 
    # 7 dias
    rankdia7 = item.at_css("tr:nth-child(3) .avg").text.gsub!(/\D/, "")
    chandia7 = item.at_css("tr:nth-child(3) .percent").text.gsub!(/\D/, "")
    statdia7 = item.at_css("tr:nth-child(3) .percent").text[1..1]

    if nomeky != "1 month" # 1 month 
      rankmes1 = item.at_css("tr:nth-child(4) .avg").text.gsub!(/\D/, "") 
      chanmes1 = item.at_css("tr:nth-child(4) .percent").text.gsub!(/\D/, "")
      statmes1 = item.at_css("tr:nth-child(4) .percent").text[1..1]
    else # efetua um ajuste na matrix
      rankmes3 = rankdia7
      chanmes3 = chandia7
      statmes3 = statdia7
      rankmes1 = rankyest
      chanmes1 = chanyest
      statmes1 = statyest
      rankyest = chanyest = statyest = ""
      rankdia7 = chandia7 = statdia7 = "" 
    end

    if nomeky == "Yesterday" # 3 month.
      rankmes3 = item.at_css("tr:nth-child(5) .avg").text.gsub!(/\D/, "")
      chanmes3 = item.at_css("tr:nth-child(5) .percent").text.gsub!(/\D/, "")
      statmes3 = item.at_css("tr:nth-child(5) .percent").text[1..1]
    else # efetua um ajuste ma matrix
       if nomeky != "1 month"
         rankmes3 = rankmes1 
         chanmes3 = chanmes1
         statmes3 = statmes1
         rankmes1 = rankdia7 
         chanmes1 = chandia7
         statmes1 = statdia7
         rankdia7 = rankyest
         chandia7 = chanyest
         statdia7 = statyest
         rankyest = chanyest = statyest = ""
       end
    end
 end

 # Mostra as variaveis.
 titulo = "Rank In: #{rankal}  Rank Br: #{rankbr}  Site Link: #{linkin}"

 #imprime na tela o resultado das variaveis.
 puts titulo
 puts "-"*titulo.size
 puts "Yesterday  #{rankyest.rjust(7," ")} #{chanyest.rjust(7," ")} #{statyest}"
 puts "7 day      #{rankdia7.rjust(7," ")} #{chandia7.rjust(7," ")} #{statdia7}"
 puts "1 month    #{rankmes1.rjust(7," ")} #{chanmes1.rjust(7," ")} #{statmes1}"
 puts "3 month    #{rankmes3.rjust(7," ")} #{chanmes3.rjust(7," ")} #{statmes3}"
 #--------------------------------------------------------------------------------
end

# ---
  $db= SQLite3::Database.new("./db/alexarank.db")

  #puts "listando dados: Codigo, Site, Rank"
  #puts "----------------------------------"
  #executa comando no banco e retorna num array
  sql_select = "SELECT * FROM sites" 
  #sql_select = "SELECT * FROM sites WHERE id=1 or id=2 or id=9"

  sql = $db.execute(sql_select)

  for row in sql
   #da a saida dos blocos 0,1,2 ou seja codigo, site, rank
   puts %Q{#{(row[0].to_s).ljust(2)} - #{row[1]} : #{row[2]}}

   #pega o rank do sites especificado.
   ler_rank(row[1])
   puts " "
   #break
  end

  # fecha banco.
  $db.close
# ---

