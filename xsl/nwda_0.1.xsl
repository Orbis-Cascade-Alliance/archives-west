<?xml version="1.0" encoding="UTF-8"?>
<!--
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1

Overhaul to HTML5/Bootstrap 3 by Ethan Gruber in March 2015.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#" xmlns:arch="http://purl.org/archival/vocab/arch#"
	xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="nwda xsd vcard xsl fo ead">
	<xsl:output encoding="UTF-8" method="html" omit-xml-declaration="yes" doctype-public="html"/>
	<xsl:param name="doc"/>

	<!-- ********************* <MODULES> *********************** -->
	<!--set stylesheet preferences -->
	<xsl:include href="nwda.mod.preferences.xsl"/>
	<!--line breaks, lists and such-->
	<xsl:include href="nwda.mod.generics.xsl"/>
	<!--table of contents-->
	<xsl:include href="nwda.mod.toc.xsl"/>
	<!--controlled access points-->
	<xsl:include href="nwda.mod.controlaccess.xsl"/>
	<!--description of subordinate components-->
	<xsl:include href="nwda.mod.dsc.xsl"/>
	<!--tables-->
	<xsl:include href="nwda.mod.tables.xsl"/>
	<!--loose archdesc-->
	<xsl:include href="nwda.mod.structures.xsl"/>

	<!-- *** RDF and CHO variables moved into nwda.mod.preferences.xsl *** -->

	<!-- ********************* </MODULES> *********************** -->
	
	<!-- ********************* <XML_VARIABLES> *********************** -->
	<xsl:variable name="identifier" select="string(normalize-space(//ead/eadheader/eadid/@identifier))"/>
	<xsl:variable name="titleproper">
		<xsl:apply-templates select="//ead/archdesc/did/unittitle" mode="no-highlights" />
		<xsl:if test="//ead/archdesc/did/unitdate">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="//ead/archdesc/did/unitdate"/>
		</xsl:if>
	</xsl:variable>
	<!--check later for not()altrender-->
	<xsl:variable name="filingTitleproper" select="string(normalize-space(//ead/eadheader/titlestmt/titleproper[@altrender]))"/>
	<xsl:variable name="dateLastRev">
		<xsl:value-of select="string(//revisiondesc/change[position()=last()]/date/@normal)"/>
	</xsl:variable>
	<!-- ********************* </XML_VARIABLES> *********************** -->
	
	<!-- Hide elements with altrender nodisplay and internal audience attributes-->
	<xsl:template match="*[@altrender='nodisplay']"/>
	<xsl:template match="*[@audience='internal']"/>
	<!-- Hide elements not matched in-toto elsewhere-->
	<xsl:template match="profiledesc"/>
	<xsl:template match="eadheader/eadid | eadheader/revisiondesc | archdesc/did"/>
	
	<xsl:template match="/">
    <div id="transformation">
      <xsl:apply-templates select="//ead/archdesc" mode="flag"/>
    </div>
	</xsl:template>

</xsl:stylesheet>
