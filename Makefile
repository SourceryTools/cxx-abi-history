######################################################### -*-Makefile-*-
#
# File:   Makefile
# Author: Alex Samuel
# Date:   03/18/2001
#
# Contents:
#   Makefile for uploading C++ ABI documents to the web site.
# 
# Copyright (c) 2001 by CodeSourcery, LLC.  All rights reserved.
#
########################################################################

ALL_FILES		= $(filter-out CVS Makefile% %~, $(wildcard *))

# Host name of new web server.
WEB_SERVER_NAME	      	= www.codesourcery.com

# Path to root of html on web server.
WEB_SERVER_HTML_ROOT  	= /var/inet/html/cxx-abi


all:


upload: 
	@echo "Web site in $(WEB_SERVER_HTML_ROOT) on $(WEB_SERVER_NAME)."
# Set the files so that the web server can access them.
	@echo "Setting file permissions."; \
	chmod -R o+r $(ALL_FILES); chmod o+x `find . -type d`; 
# Now synchronize with the active web site.
	@echo "Uploading web site."; \
	RSYNC_RSH=ssh rsync -v --archive --update --relative \
	  $(ALL_FILES) $(WEB_SERVER_NAME):$(WEB_SERVER_HTML_ROOT)
