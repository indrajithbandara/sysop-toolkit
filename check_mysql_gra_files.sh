#!/bin/bash
	ls -l /var/lib/mysql/*GRA*  2>>/dev/null|wc -l
	exit $?
