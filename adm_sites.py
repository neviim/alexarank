#!/usr/bin/env python
# Modulo: adm_sites.py
# 
# Esta rotina ainda nao trata se o tabela exeinte ou nao, ela considera
# que a tabela exista.
#
# Modo de usar: python adm_site.py <-i (url_site)> <-d (Codigo ID)>
# -i Inseri uma url
# -d Deleta um registro
#
# Exemplo:
# >$ python adm_site.py -i cancaonova.com  # insere a url cancaonova.com na base
# >$ python adm_site.py -d 10              # deleta o registro 10 da tabela site
# >$ _
#
# Por: Neviim - 20/05/2010 Cachoeira Paulista - SP (Cancao Nova)
##
import sys
import sqlite3

def site_chamada(sql):
    try:
      
	# Insere uma url na tamela sites
        db = sqlite3.connect('./db/alexarank.db')

	cr = db.cursor()
        cr.execute(sql)
        db.commit()
	db.close() 	
          
        return 

    except (KeyboardInterrupt, SystemExit):
       raise
    except:
       return None     
   
if __name__ == '__main__':
     if len(sys.argv) < 2:
	print 'Modo de usar: python %s <url-site>' % (sys.argv[1])
	sys.exit(2)

     idc = sys.argv[1] 
     status = 0  

     #print idc
     if idc == '-i':
        status = 1 
        # Insere itens na tabela.
        sql = "INSERT INTO sites (nome, rank) VALUES('%s', 0)" % (sys.argv[2])

     if idc == '-d' and len(sys.argv[2]) > 0:
        status = 1
        # Deleta item da tabela.
        sql = "DELETE FROM sites WHERE id = %s" % (sys.argv[2])

     # se parametro esta correto chama rotina
     if status > 0:
        #print sql
        site_chamada(sql)


