# Extract the version string from ncrack.h.
export NCRACK_VERSION := $(shell grep '^\#[ \t]*define[ \t]\+NCRACK_VERSION' \
	ncrack.h | sed -e 's/.*"\(.*\)".*/\1/' -e 'q')
NCRACK_NAME= Ncrack
NCRACK_URL= http://ncrack.org
NCRACK_PLATFORM=x86_64-pc-mingw64
prefix = /usr/local
exec_prefix = ${prefix}
bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
mandir = ${prefix}/share/man
srcdir = .
ncrackdatadir = ${prefix}/share/ncrack

export NBASEDIR = nbase
export NSOCKDIR = nsock
export OPENSSHLIB_DIR = opensshlib

DEFS = -DHAVE_CONFIG_H -DNCRACK_NAME=\"$(NCRACK_NAME)\" -DNCRACK_URL=\"$(NCRACK_URL)\" \
-DNCRACK_PLATFORM=\"$(NCRACK_PLATFORM)\" -DNCRACKDATADIR=\"$(ncrackdatadir)\"
DEFS += -D_FORTIFY_SOURCE=2 

CC = gcc
CXX = g++
CCOPT = 
DBGFLAGS = 
STRIP = /e/Program-Files/Editor/Perl/Strawberry/c/bin/strip
CXXFLAGS =  -O2 -Wall -fno-strict-aliasing $(DBGFLAGS)
CPPFLAGS =  -Inbase -Insock/include -Iopensshlib -Imodules $(DEFS)
export CFLAGS = $(CXXFLAGS)
STATIC =
LDFLAGS =  -Lnbase -Lnsock/src -Lopensshlib $(DBGFLAGS) $(STATIC)
INSTALL = /usr/bin/install -c

MOD_OBJS = ncrack_ssh.o ncrack_smb.o ncrack_smb2.o ncrack_rdp.o ncrack_sip.o ncrack_psql.o ncrack_mysql.o ncrack_winrm.o ncrack_mongodb.o ncrack_ftp.o ncrack_telnet.o ncrack_http.o ncrack_pop3.o ncrack_vnc.o ncrack_redis.o ncrack_owa.o ncrack_imap.o ncrack_cassandra.o ncrack_mssql.o ncrack_cvs.o ncrack_wordpress.o ncrack_webform.o ncrack_joomla.o ncrack_dicom.o ncrack_mqtt.o
MOD_OBJS := $(addprefix modules/,$(MOD_OBJS))
MOD_SRCS = ncrack_ssh.cc ncrack_smb.cc ncrack_smb2.cc ncrack_rdp.cc ncrack_sip.cc ncrack_psql.cc ncrack_mysql.cc ncrack_winrm.cc ncrack_mongodb.cc ncrack_ftp.cc ncrack_telnet.cc ncrack_http.cc ncrack_pop3.cc ncrack_vnc.cc ncrack_redis.cc  ncrack_owa.cc ncrack_imap.cc ncrack_cassandra.cc ncrack_mssql.cc ncrack_cvs.cc ncrack_wordpress.cc ncrack_webform.cc ncrack_joomla.cc ncrack_dicom.cc ncrack_mqtt.cc
MOD_SRCS := $(addprefix modules/,$(MOD_SRCS))

LIBS = -lnsock -lnbase $(OPENSSL_LIBS) -lopenssh # $(ZLIB_LIBS)
OPENSSL_LIBS = -lssl -lcrypto
#ZLIB_LIBS = @ZLIB_LIBS@

DESTDIR =

TARGET = ncrack

export SRCS = ncrack.cc utils.cc TargetGroup.cc Target.cc targets.cc \
NcrackOps.cc Service.cc ServiceGroup.cc Connection.h services.cc \
timing.cc ncrack_error.cc output.cc ncrack_tty.cc Buf.cc \
NcrackOutputTable.cc ncrack_input.cc ncrack_resume.cc crypto.cc http.cc \
http_digest.cc xml.cc ntlmssp.cc

OBJS = ncrack.o utils.o TargetGroup.o Target.o targets.o NcrackOps.o \
Service.o ServiceGroup.o Connection.o services.o timing.o \
ncrack_error.o output.o ncrack_tty.o Buf.o NcrackOutputTable.o \
ncrack_input.o ncrack_resume.o crypto.o http.o http_digest.o xml.o ntlmssp.o


.cc.o :
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@

all: nbase_build nsock_build opensshlib_build modules_build
	$(MAKE) $(TARGET)

$(TARGET): $(NSOCKDIR)/src/libnsock.a $(NBASEDIR)/libnbase.a $(OBJS) $(MOD_OBJS)
	@echo Compiling Ncrack... 
	rm -f $@
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(MOD_OBJS) $(LIBS)
	@echo Ncrack compiled successfully!


modules_build:
	@echo Compiling modules
	cd modules && $(MAKE)

nbase_build: $(NBASEDIR)/Makefile
	@echo Compiling libnbase;
	cd $(NBASEDIR) && $(MAKE)

nsock_build: $(NSOCKDIR)/src/Makefile nbase_build
	@echo Compiling libnsock;
	cd $(NSOCKDIR)/src && $(MAKE)

opensshlib_build: $(OPENSSHLIB_DIR)/Makefile
	@echo Compiling openssh lib;
	cd $(OPENSSHLIB_DIR) && $(MAKE)



install: install-ncrack
	@echo "NCRACK SUCCESSFULLY INSTALLED"

install-ncrack: $(TARGET)
	$(INSTALL) -d $(DESTDIR)$(bindir) $(DESTDIR)$(mandir)/man1 $(DESTDIR)$(ncrackdatadir)
	$(INSTALL) -c -m 755 ncrack $(DESTDIR)$(bindir)/ncrack
	$(STRIP) $(DESTDIR)$(bindir)/ncrack
	$(INSTALL) -c -m 644 docs/$(TARGET).1 $(DESTDIR)$(mandir)/man1/
#	$(INSTALL) -c -m 644 docs/ncrack.xsl $(DESTDIR)$(ncrackdatadir)/
#	$(INSTALL) -c -m 644 docs/ncrack.dtd $(DESTDIR)$(ncrackatadir)/
	$(INSTALL) -c -m 644 ncrack-services $(DESTDIR)$(ncrackdatadir)/
	$(INSTALL) -c -m 644 lists/* $(DESTDIR)$(ncrackdatadir)/


uninstall: uninstall-ncrack

uninstall-ncrack:
	rm -f $(DESTDIR)$(bindir)/$(TARGET)
	rm -f $(DESTDIR)$(mandir)/man1/$(TARGET).1
	rm -rf $(DESTDIR)$(ncrackdatadir)


# cleaning stuff

clean: nsock_clean nbase_clean opensshlib_clean modules_clean my_clean 

my_clean:
	rm -f dependencies.mk makefile.dep
	rm -f $(OBJS) $(TARGET) config.cache
nbase_clean:
	-cd $(NBASEDIR) && $(MAKE) clean
nsock_clean:
	-cd $(NSOCKDIR)/src && $(MAKE) clean
opensshlib_clean:
	-cd $(OPENSSHLIB_DIR) && $(MAKE) clean
modules_clean:
	-cd modules && $(MAKE) clean

Makefile: Makefile.in config.status
	./config.status

config.status: configure
	./config.status --recheck

makefile.dep:
	$(CXX) -MM $(CPPFLAGS) $(SRCS) > $@
include makefile.dep
