CC = gcc
CXX = g++

SRCS = ncrack_ssh.cc ncrack_smb.cc ncrack_smb2.cc ncrack_rdp.cc ncrack_sip.cc ncrack_psql.cc ncrack_mysql.cc ncrack_winrm.cc ncrack_mongodb.cc ncrack_ftp.cc ncrack_telnet.cc ncrack_http.cc ncrack_pop3.cc ncrack_vnc.cc ncrack_redis.cc  ncrack_owa.cc ncrack_imap.cc ncrack_cassandra.cc ncrack_mssql.cc ncrack_cvs.cc ncrack_wordpress.cc ncrack_webform.cc ncrack_joomla.cc ncrack_dicom.cc ncrack_mqtt.cc
OBJS = ncrack_ssh.o ncrack_smb.o ncrack_smb2.o ncrack_rdp.o ncrack_sip.o ncrack_psql.o ncrack_mysql.o ncrack_winrm.o ncrack_mongodb.o ncrack_ftp.o ncrack_telnet.o ncrack_http.o ncrack_pop3.o ncrack_vnc.o ncrack_redis.o ncrack_owa.o ncrack_imap.o ncrack_cassandra.o ncrack_mssql.o ncrack_cvs.o ncrack_wordpress.o ncrack_webform.o ncrack_joomla.o ncrack_dicom.o ncrack_mqtt.o

include_dirs := .. ../nsock/include ../nbase ../opensshlib
CPPFLAGS += $(addprefix -I,$(include_dirs)) -DHAVE_CONFIG_H
CXXFLAGS =  -O2 -Wall -fno-strict-aliasing -Wno-attributes

vpath %.h $(include_dirs)


all: $(OBJS)

.cc.o :
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@

clean :
	rm -f $(OBJS) 


