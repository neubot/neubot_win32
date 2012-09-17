# Makefile

#
# Copyright (c) 2012 Simone Basso <bassosimone@gmail.com>,
#  NEXA Center for Internet & Society at Politecnico di Torino
#
# This file is part of Neubot <http://www.neubot.org/>.
#
# Neubot is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Neubot is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Neubot.  If not, see <http://www.gnu.org/licenses/>.
#

VERSION = $$(cat VERSION)
MIRROR = http://releases.neubot.org/source
SOURCE = neubot-$(VERSION).tar.gz

.PHONY: all

all:
	wget $(MIRROR)/VERSION
	wget $(MIRROR)/VERSION.sig
	openssl dgst -sha256 -verify pubkey.pem -signature		\
			VERSION.sig VERSION
	wget $(MIRROR)/$(SOURCE)
	wget $(MIRROR)/$(SOURCE).sig
	openssl dgst -sha256 -verify pubkey.pem -signature		\
			$(SOURCE).sig $(SOURCE)
	tar -xzf $(SOURCE)
	for PATCH in $$(ls *.patch); do					\
		(cd neubot-0.4.14 && patch -Np1 -i ../$$PATCH);		\
	done
