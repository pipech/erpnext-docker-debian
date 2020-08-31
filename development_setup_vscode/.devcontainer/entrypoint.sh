#!/bin/bash
{
	sudo service mysql start
	bench start
} || {
	echo "============================================="
	echo "ERROR: entrypoint command failed to start"
	echo "============================================="
	tail -f /dev/null
}
