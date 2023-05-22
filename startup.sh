#!/bin/bash
# © Copyright IBM Corporation 2019.
#
	. /opt/ibm/ace-12/server/bin/mqsiprofile \
    && for FILE in /tmp/*.bar; do ibmint deploy --input-bar-file "$FILE" --output-work-directory /home/aceuser/initial-config/serverconf/ 2>&1; done \
	&& IntegrationServer -w /home/aceuser/initial-config/serverconf