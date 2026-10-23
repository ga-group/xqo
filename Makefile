PYTHON = ~/usr/intel/intelpython/python3.9/bin/python

all: xqo.rdf xqo-xm.rdf xqo-ps.rdf index.html ps/index.html xm/index.html

%.rdf: %.owl.ttl
	rapper -i turtle -o rdfxml-abbrev $< \
	| mawk 'NR==2{print "<?xml-stylesheet type=\"text/xsl\" href=\"owl2html.xslt.xml\"?>"}1' \
	> $@.t && mv $@.t $@

index.html: xqo.owl.ttl
	$(PYTHON) -m pylode -c true -o $@ $< \
	|| $(RM) $@
	sed -i 's/ns1:0000/orcid:0000/' $@

ps/index.html: xqo-ps.owl.ttl
	$(PYTHON) -m pylode -c true -o $@ $< \
	|| $(RM) $@
	sed -i 's/ns1:0000/orcid:0000/' $@

xm/index.html: xqo-xm.owl.ttl
	$(PYTHON) -m pylode -c true -o $@ $< \
	|| $(RM) $@
	sed -i 's/ns1:0000/orcid:0000/' $@
