# nokogiri_test.rb
require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.alexa.com/siteinfo/cancaonova.com#"
#url = "http://www.alexa.com/siteinfo/vatican.va#"
#url = "http://www.alexa.com/siteinfo/a12.com#"

doc = Nokogiri::HTML(open(url))

# variavel temporaria.
rankal   = rankbr   = linkin   = "" 
rankdia7 = rankmes1 = rankmes3 = ""
chandia7 = chanmes1 = chanmes3 = ""
statdia7 = statmes1 = statmes3 = ""

# pega o titulo da pagina.
puts doc.at_css("title").text

doc.css("#content-inner").each do |item|
    # ler ranks e link
    puts item.at_css("tr:nth-child(2) th").text
    puts "-"
    rankal = item.at_css("td:nth-child(2) .data").text.gsub!(/\D/, "")
    rankbr = item.at_css("td:nth-child(3) .data").text.gsub!(/\D/, "")
    linkin = item.at_css("td:nth-child(4) .data").text.gsub!(/\D/, "")
end

doc.css("#rank").each do |item|
    # rank 7 dias, 1 mes, 3 mes.
    rankdia7 = item.at_css("tr:nth-child(2) .avg").text.gsub!(/\D/, "")
    rankmes1 = item.at_css("tr:nth-child(3) .avg").text.gsub!(/\D/, "")
    # porcentagem de crescimento ou queda.
    chandia7 = item.at_css("tr:nth-child(2) .percent").text.gsub!(/\D/, "")
    chanmes1 = item.at_css("tr:nth-child(3) .percent").text.gsub!(/\D/, "")
    # retira e armazena o sinal + ou - da string
    statdia7 = item.at_css("tr:nth-child(2) .percent").text[1..1]
    statmes1 = item.at_css("tr:nth-child(3) .percent").text[1..1]

    if rankal.to_i < 100000  # Se site for ranquiado pelo alexa.
       rankmes3 = item.at_css("tr:nth-child(4) .avg").text.gsub!(/\D/, "")
       chanmes3 = item.at_css("tr:nth-child(4) .percent").text.gsub!(/\D/, "")
       statmes3 = item.at_css("tr:nth-child(4) .percent").text[1..1]
    else
       # Aplica inversao das variaveis.
       rankmes3 = rankmes1 # 1 month para 3 month.
       chanmes3 = chanmes1
       statmes3 = statmes1
       rankmes1 = rankdia7 # 7 day para 1 month.
       chanmes1 = chandia7
       statmes1 = statdia7   
       rankdia7 = chandia7 = statdia7 = "" # limpa variavel.
    end
end

# Mostra as variaveis.
puts "Rank In: #{rankal}  Rank Br: #{rankbr}  Site Link: #{linkin}"
puts " "
puts "7 day    #{rankdia7} : #{chandia7} #{statdia7}"
puts "1 month  #{rankmes1} : #{chanmes1} #{statmes1}"
puts "3 month  #{rankmes3} : #{chanmes3} #{statmes3}"





