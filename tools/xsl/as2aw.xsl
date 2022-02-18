<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ead="urn:isbn:1-931666-22-9" xmlns:ns2="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="xsl ead xsi ns2">

  <!-- Stylesheet for converting EAD finding aids from Archivists' Toolkit to NWDA compliant -->
  <!-- Original by Michael Klein, taken over by Ryan Wick in 2010 -->

  <!-- 
Changes:

    04/16/15    JAB     Modified to be compliant with EAD Best Practices v 3.8 by Jodi Allison-Bunnell, 20150-04-16
    04/20/15    KEF     Added to Jodi's work.  All ID attributes are stripped from the incoming EAD. 
    03/02/17    CEW     Updated to convert from ArchivesSpace to Archives West
    12/21/20    BSV     Suppress datechar attributes.  These were added with the move to ASpace 2.8.

-->

  <xsl:variable name="UPPER">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
  <xsl:variable name="LOWER">abcdefghijklmnopqrstuvwxyz</xsl:variable>

  <xsl:output method="xml" indent="yes" doctype-system="ead.dtd"
    doctype-public="+//ISBN 1-931666-00-8//DTD ead.dtd (Encoded Archival Description (EAD) Version 2002)//EN"/>

  <xsl:template match="ead:ead">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <!-- Utility Templates -->

  <!-- Remove whitespace surrounding delimiters in text strings -->
  <xsl:template name="normalize-delimited-text">
    <xsl:param name="string"/>
    <xsl:param name="delimiter">--</xsl:param>
    <xsl:choose>
      <xsl:when test="contains($string,$delimiter)">
        <xsl:value-of select="normalize-space(substring-before($string,$delimiter))"/>
        <xsl:value-of select="$delimiter"/>
        <xsl:call-template name="normalize-delimited-text">
          <xsl:with-param name="string"
            select="normalize-space(substring-after($string,$delimiter))"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Copy existing element, removing @label and adding attributes passed in through the $attributes parameter -->
  <xsl:template name="add-attributes">
    <xsl:param name="attributes"/>
    <xsl:variable name="local-name" select="local-name()"/>
    <xsl:variable name="first-occurrence" select="not(preceding::*[local-name() = $local-name])"/>
    <xsl:element name="{$local-name}">
      <xsl:apply-templates select="@*"/>
      <xsl:if test="$attributes">
        <xsl:variable name="attrs" select="$attributes"/>
        <xsl:for-each select="$attrs/*">
          <xsl:variable name="attr-name" select="local-name()"/>
          <xsl:variable name="attr-value" select="./text()"/>
          <xsl:if test="$attr-value">
            <!-- Special case: Only put the 'id' attribute on the first occurrence -->
            <!-- 20150416: commented out -->
            <xsl:choose>
              <xsl:when test="$attr-name != 'id'">
                <xsl:attribute name="{$attr-name}">
                  <xsl:value-of select="$attr-value"/>
                </xsl:attribute>
              </xsl:when>
              <!--
              <xsl:otherwise>
                <xsl:if test="$first-occurrence">
                  <xsl:attribute name="{$attr-name}">
                      <xsl:value-of select="$attr-value"/>
                  </xsl:attribute>
                </xsl:if>
              </xsl:otherwise>
              -->
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- Add @id values and DC @encodinganalogs to eadheader -->
  <!-- 20150416: "a0" attribute removed -->

  <xsl:template match="ead:eadheader">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a0</id> -->
        <relatedencoding>dc</relatedencoding>
        <scriptencoding>iso15924</scriptencoding>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--
  <xsl:template match="ead:eadheader//ead:eadid">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>identifier</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Added back in #32 with other new attribute 
-->

  <!--
  <xsl:template match="ead:eadheader//ead:titleproper[not(@type='filing')]">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>title</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:eadheader//ead:titleproper/ead:date">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>date</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Added back in #35 with other title changes
-->

  <xsl:template match="ead:eadheader//ead:author">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>creator</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:eadheader/ead:sponsor">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>contributor</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:eadheader//ead:publisher">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>publisher</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- AS2AW: remove <p> element in <publicationstmt><publisher> -->
  <xsl:template match="ead:eadheader//ead:publicationstmt/ead:p">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- AS2AW: remove all <head> elements -->
  <xsl:template match="ead:head"/>

  <!-- AS2AW: remove audience attributes -->
  <xsl:template match="@audience"/>

  <!-- AS2AW: remove altrender attribute from <physdesc> and <extent> -->
  <xsl:template
    match="ead:archdesc//ead:physdesc/@altrender | ead:archdesc//ead:physdesc//ead:extent/@altrender"/>

  <!-- AS2AW: clean up last <addressline> element which contains URL -->
  <xsl:template match="ead:eadheader//ead:address/ead:addressline[last()]">
    <addressline>
      <xsl:value-of
        select="//ead:eadheader//ead:address/ead:addressline[last()]/ead:extptr/@xlink:href"/>
    </addressline>
  </xsl:template>

  <!-- AS2AW: remove findaidstatus attribute -->
  <xsl:template match="ead:eadheader/@findaidstatus"/>

  <!-- AS2AW: reorder <titlestmt><titleproper> elements -->
  <xsl:template match="ead:eadheader/ead:filedesc/ead:titlestmt">
    <titlestmt>
      <xsl:apply-templates select="ead:titleproper[2]"/>
      <xsl:apply-templates select="ead:titleproper[1]"/>
      <xsl:apply-templates select="ead:author"/>
      <xsl:apply-templates select="ead:sponsor"/>
    </titlestmt>
  </xsl:template>

  <!-- updated for AS2AW -->
  <xsl:template match="ead:eadheader//ead:publicationstmt/ead:p/ead:date">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>date</encodinganalog>
        <calendar>gregorian</calendar>
        <era>ce</era>

        <!-- #33 - Add normal attribute to publicationstmt date (if year only) -->
        <xsl:if test="string-length(.) &gt;= 4 and string-length(.) &lt;= 6">
          <xsl:choose>
            <xsl:when test="contains(., 'c')">
              <normal>
                <xsl:value-of select="normalize-space(substring-after(., 'c'))"/>
              </normal>
            </xsl:when>
            <xsl:when test="contains(., '©')">
              <normal>
                <xsl:value-of select="normalize-space(substring-after(., '©'))"/>
              </normal>
            </xsl:when>
            <xsl:when test="string(number(.)) != 'NaN'">
              <normal>
                <xsl:value-of select="number(.)"/>
              </normal>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- #39 - (modified for AS2AW): Clean up <eadheader><creation><date> -->

  <xsl:template match="ead:eadheader//ead:profiledesc/ead:creation/ead:date">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <!-- <xsl:attribute name="calendar">gregorian</xsl:attribute>
		<xsl:attribute name="era">ce</xsl:attribute>
		<xsl:attribute name="normal"><xsl:value-of select="replace(substring-before(., 'T'), '-', '')"/></xsl:attribute> -->

      <!-- <xsl:value-of select="substring-before(., 'T')"/> -->
      <xsl:value-of select="substring(.,1,10)"/>
    </xsl:element>
  </xsl:template>


  <!--
  <xsl:template match="ead:eadheader//ead:langusage/ead:language">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>language</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  -->


  <xsl:template match="ead:eadheader/ead:profiledesc/ead:langusage[not(ead:language)]">
    <!-- if language element already exists correctly encoded, leave alone -->

    <xsl:element name="{local-name()}">

      <xsl:element name="language">
        <xsl:attribute name="langcode">eng</xsl:attribute>
        <xsl:attribute name="encodinganalog">language</xsl:attribute>
        <xsl:attribute name="scriptcode">latn</xsl:attribute>

        <xsl:copy-of select="@*|node()"/>
      </xsl:element>
    </xsl:element>

  </xsl:template>


  <!-- Add @id values and MARC21 @encodinganalogs to archdesc -->

  <xsl:template match="ead:archdesc">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <relatedencoding>marc21</relatedencoding>
        <type>inventory</type>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <!--  #24 - Remove encodinganalog from <repository> -->
  <!--
  <xsl:template match="ead:archdesc//ead:repository">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>852</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
-->

  <xsl:template match="ead:archdesc//ead:repository/ead:corpname">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>852$a</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:repository/ead:subarea">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>852$b</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--
  <xsl:template match="ead:archdesc//ead:unitid">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>099</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Added back in #26 with other new attributes 
-->

  <xsl:template match="ead:archdesc//ead:origination/ead:persname" priority="2">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>100</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:origination/ead:corpname" priority="2">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>110</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:origination/ead:famname" priority="2">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>100</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:unittitle">
    <xsl:choose>
      <xsl:when test=". != ''">
        <xsl:call-template name="add-attributes">
          <xsl:with-param name="attributes">
            <encodinganalog>245$a</encodinganalog>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise/>
      <!-- removes blank unittitle element -->
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:unitdate[@type='inclusive']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>245$f</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--
  <xsl:template match="ead:archdesc//ead:unitdate[@type='bulk']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>245$g</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Added back in #37
-->

  <!--
  <xsl:template match="ead:archdesc//ead:physdesc/ead:extent">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>300$a</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Added back in #38
-->

  <xsl:template match="ead:archdesc//ead:abstract">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>5203_</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- re-added for AS2AW -->
  <xsl:template match="ead:archdesc//ead:langmaterial[1]/ead:language">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>546</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- id commented out 20150416 -->
  <xsl:template match="ead:archdesc//ead:bioghist">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a2</id> -->
        <encodinganalog>
          <xsl:choose>
            <xsl:when test="translate(ead:head/text(),$UPPER,$LOWER) = 'biographical note'"
              >5450_</xsl:when>
            <xsl:when test="translate(ead:head/text(),$UPPER,$LOWER) = 'biographical note:'"
              >5450_</xsl:when>
            <xsl:when test="translate(ead:head/text(),$UPPER,$LOWER) = 'historical note'"
              >5451_</xsl:when>
            <xsl:when test="translate(ead:head/text(),$UPPER,$LOWER) = 'historical note:'"
              >5451_</xsl:when>
            <!-- #29 - Add @encodinganalog to bioghist -->
            <xsl:otherwise>545</xsl:otherwise>
          </xsl:choose>
        </encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- id attributes removed 20150416-->

  <xsl:template match="ead:archdesc//ead:scopecontent">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a3</id> -->
        <encodinganalog>5202_</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:odd">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a5</id> -->
        <encodinganalog>500</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:arrangement">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a4</id> -->
        <encodinganalog>351</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:altformavail">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a9</id> -->
        <encodinganalog>530</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:accessrestrict">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a14</id> -->
        <encodinganalog>506</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:userestrict">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a15</id> -->
        <encodinganalog>540</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:prefercite">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a18</id> -->
        <encodinganalog>524</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:custodhist">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a16</id> -->
        <encodinganalog>561</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:acqinfo">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a19</id> -->
        <encodinganalog>541</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:accruals">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a10</id> -->
        <encodinganalog>584</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:processinfo">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a20</id> -->
        <encodinganalog>583</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:separatedmaterial">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a7</id> -->
        <encodinganalog>5440_</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:otherfindaid">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a8</id> -->
        <encodinganalog>555</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:relatedmaterial">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <!-- <id>a6</id> -->
        <encodinganalog>5441_</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--
  <xsl:template match="ead:archdesc//ead:controlaccess">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a12</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

Aattribute add moved to #30
-->
  <!-- source of browsing terms updated, source for non-browsing terms corrected 20150416 -->
  <xsl:template match="ead:archdesc//ead:controlaccess/ead:subject[@source != 'archiveswest']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>650</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:subject[@source='archiveswest']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>690</encodinganalog>
        <altrender>nodisplay</altrender>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:persname[not(@role != '')]">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>600</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:persname[@role != '']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>700</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:corpname[not(@role != '')]">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>610</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:corpname[@role != '']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>710</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:famname[not(@role != '')]">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>600</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:famname[@role != '']">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>700</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:geogname">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>651</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:genreform">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>655</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:occupation">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>656</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:controlaccess/ead:function">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <encodinganalog>657</encodinganalog>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- commented out 20150416 -->
  <!--   <xsl:template match="ead:archdesc//ead:appraisal">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a39</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:bibliography">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a11</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:did">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a1</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:fileplan">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a37</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:index">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a38</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:originalsloc">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a36</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ead:archdesc//ead:phystech">
    <xsl:call-template name="add-attributes">
      <xsl:with-param name="attributes">
        <id>a35</id>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template> -->

  <!-- #8 - Add appropriate type attribute to dsc element -->
  <!--id attribute match commented out 20150416 -->
  <xsl:template match="ead:dsc">

    <xsl:choose>
      <xsl:when test="ead:c01 or ead:c">

        <xsl:call-template name="add-attributes">
          <xsl:with-param name="attributes">
            <!-- <id>a23</id> -->
            <type>
              <xsl:choose>
                <xsl:when
                  test="*[starts-with(local-name(),'c0') and (@level='series' or @level='subgrp')] and 
              *[starts-with(local-name(),'c0') and (@level='file' or @level='item')]"
                  >combined</xsl:when>
                <xsl:when
                  test="*[starts-with(local-name(),'c0') and (@level='series' or @level='subgrp')]"
                  >analyticover</xsl:when>
                <xsl:when
                  test="*[starts-with(local-name(),'c0') and (@level='file' or @level='item')]"
                  >in-depth</xsl:when>
              </xsl:choose>
            </type>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise/>
      <!-- remove dsc if empty -->
    </xsl:choose>

  </xsl:template>

  <!-- #10 - Convert container type values to lowercase -->
  <xsl:template match="ead:container">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:if test="@type">
        <xsl:attribute name="type">
          <xsl:value-of select="translate(@type,$UPPER,$LOWER)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- #11 - Remove whitespace in controlaccess headings -->
  <xsl:template match="ead:controlaccess/*/text()">
    <xsl:call-template name="normalize-delimited-text">
      <xsl:with-param name="string" select="."/>
      <xsl:with-param name="delimiter">--</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- #6 - Remove all head elements except bioghist/head -->
  <!-- <xsl:template match="ead:head[not(parent::ead:bioghist)]"/> -->
  <xsl:template match="ead:head[not(parent::ead:bioghist)]"/>

  <!-- #12 - Remove call number from title -->
  <xsl:template match="ead:titleproper/ead:num"/>

  <!-- #35 - Add date to finding aid title, also add attributes -->
  <xsl:template match="ead:titleproper[not(@type='filing')]">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="encodinganalog">title</xsl:attribute>
      <xsl:apply-templates/>

      <xsl:element name="date">
        <xsl:attribute name="encodinganalog">date</xsl:attribute>
        <xsl:apply-templates select="//ead:archdesc/ead:did/ead:unitdate[@type='inclusive']/@*"/>
        <xsl:value-of select="//ead:archdesc/ead:did/ead:unitdate[@type='inclusive']"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>


  <!-- #13 - Replace incorrect role attribute values -->
  <xsl:template match="ead:*/@role">
    <xsl:attribute name="role">
      <xsl:choose>
        <xsl:when test="contains(.,'(')">
          <xsl:value-of select="translate(normalize-space(substring-before(.,'(')),$UPPER,$LOWER)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Fix nested <c> elements -->
  <xsl:template match="ead:c">
    <xsl:variable name="nesting-level" select="count(ancestor::ead:c)+1"/>
    <xsl:variable name="display-level">
      <xsl:if test="$nesting-level &lt; 10">0</xsl:if>
      <xsl:value-of select="$nesting-level"/>
    </xsl:variable>
    <xsl:element name="c{$display-level}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>



  <!-- AS2AW: #22 - Add @altrender='nodisplay' on filing title -->

  
  <xsl:template match="ead:titleproper[@type = 'filing']">
	<xsl:call-template name="add-attributes">
		<xsl:with-param name="attributes">
			<altrender>nodisplay</altrender>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

  <!-- #23 - Update DACS text if match in descrules -->
  <!-- Updated to DACS 2nd edition -->

  <xsl:template match="ead:descrules">
    <xsl:element name="{local-name()}">
      <!--
<xsl:copy copy-namespaces="no" xmlns="urn:isbn:1-931666-00-8">
-->
      <xsl:copy-of select="@*"/>

      <xsl:choose>
        <xsl:when test="text() = 'Describing Archives: A Content Standard'">Finding aid based on
          DACS (<title render="italic">Describing Archives: A Content Standard</title>), 2nd
          Edition.</xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>

      <!--
</xsl:copy>
-->
    </xsl:element>
  </xsl:template>


  <!-- #25 - Duplicate <address> from <publisher> to <repository> -->

  <xsl:template match="ead:archdesc//ead:repository">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>

      <xsl:apply-templates select="//ead:filedesc/ead:publicationstmt/ead:address"/>
    </xsl:element>
  </xsl:template>


  <!-- #26 - Copy eadid/@mainagencycode to unitid/@respositorycode and eadid/@countrycode to unitid/@countrycode -->

  <xsl:template match="ead:archdesc/ead:did/ead:unitid">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>

      <xsl:attribute name="encodinganalog">099</xsl:attribute>
      <xsl:attribute name="countrycode">
        <xsl:value-of select="//ead:eadid/@countrycode"/>
      </xsl:attribute>
      <xsl:attribute name="repositorycode">
        <xsl:value-of select="substring-after(//ead:eadid/@mainagencycode, 'us-')"/>
        <xsl:value-of select="substring-after(//ead:eadid/@mainagencycode, 'US-')"/>
      </xsl:attribute>

      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>


  <!-- #27 - Collapse multiple <origination> elements into single one -->

  <xsl:template match="ead:archdesc/ead:did/ead:origination[1]">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="../ead:origination/node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ead:archdesc/ead:did/ead:origination[position() &gt; 1]"/>


  <!-- #28 - Add text to <langmaterial>, expand language element values from codes to names
<xsl:template match="ead:archdesc/ead:did/ead:langmaterial">
<xsl:element name="{local-name()}">

<xsl:choose>
<xsl:when test="normalize-space(text()[1]) = ''">Collection materials are in <xsl:for-each select="ead:language"><xsl:apply-templates select="."/><xsl:if test="count(following-sibling::ead:language) &gt; 1">, </xsl:if><xsl:if test="count(following-sibling::ead:language) = 1"> and </xsl:if></xsl:for-each>.</xsl:when>
<xsl:otherwise><xsl:apply-templates select="@*|node()"/></xsl:otherwise>
</xsl:choose>

</xsl:element>
</xsl:template>

<xsl:template match="ead:archdesc/ead:did/ead:langmaterial/ead:language">
<xsl:element name="{local-name()}">
	<xsl:copy-of select="@*"/>
	<xsl:attribute name="encodinganalog">546</xsl:attribute>

<xsl:call-template name="langcodes"/>

</xsl:element>
</xsl:template> -->

  <!-- AS2AW: pull languages from second <langmaterial>
  <xsl:template match="ead:archdesc/ead:did/ead:langmaterial[2]">
    <xsl:variable name="firstlm" select="//ead:archdesc/ead:did/ead:langmaterial[1]/ead:language"/>
    <xsl:variable name="secondlm" select="//ead:archdesc/ead:did/ead:langmaterial[2]"/>
    
    <langmaterial>
    
    <xsl:if test="starts-with($secondlm, 'Collection is in')">
      
      <xsl:if test="contains(.,',')">
        <xsl:for-each select="tokenize(substring-before(.,'.'),',')">
          <xsl:choose>
            <xsl:when test="starts-with(.,'Collection is in')">
              <xsl:element name="language">
                <xsl:call-template name="languages"/>
                <xsl:attribute name="encodinganalog">546</xsl:attribute>
                <xsl:value-of select="normalize-space(substring-after(.,'Collection is in '))"/>
              </xsl:element>
            </xsl:when>
            <xsl:when test="starts-with(.,' and')">
              <xsl:element name="language">
                <xsl:call-template name="languages"/>
                <xsl:attribute name="encodinganalog">546</xsl:attribute>
                <xsl:value-of select="normalize-space(substring-after(.,'and'))"/>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="language">
                <xsl:call-template name="languages"/>
                <xsl:attribute name="encodinganalog">546</xsl:attribute>
                <xsl:value-of select="normalize-space(.)"/>
              </xsl:element>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>  
      </xsl:if>
      
      <xsl:if test="not(contains(.,','))">
        <xsl:for-each select="tokenize(substring-before(.,'.'),'and')">
          <xsl:choose>
            <xsl:when test="starts-with(.,'Collection is in')">
              <xsl:element name="language">
                <xsl:call-template name="languages"/>
                <xsl:attribute name="encodinganalog">546</xsl:attribute>
                <xsl:value-of select="normalize-space(substring-after(.,'Collection is in '))"/>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="language">
                <xsl:call-template name="languages"/>
                <xsl:attribute name="encodinganalog">546</xsl:attribute>
                <xsl:value-of select="normalize-space(.)"/>
              </xsl:element>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>  
      </xsl:if> 
    </xsl:if>
    
    <xsl:if test="starts-with($secondlm, 'Additional languages')">
        <xsl:element name="language">
          <xsl:attribute name="encodinganalog">546</xsl:attribute>
          <xsl:attribute name="langcode">
            <xsl:value-of select="$firstlm/@langcode"/>
          </xsl:attribute>
          <xsl:value-of select="$firstlm"/>          
        </xsl:element>
        
        <xsl:if test="contains(.,',')">
          <xsl:for-each select="tokenize(substring-before(.,'.'),',')">
            <xsl:choose>
              <xsl:when test="starts-with(.,'Additional languages')">
                <xsl:element name="language">
                  <xsl:attribute name="encodinganalog">546</xsl:attribute>
                  <xsl:call-template name="languages"/>
                  <xsl:value-of select="normalize-space(substring-after(.,'Additional languages: '))"/>
                </xsl:element>
              </xsl:when>
              <xsl:when test="starts-with(.,' and')">
                <xsl:element name="language">
                  <xsl:attribute name="encodinganalog">546</xsl:attribute>
                  <xsl:call-template name="languages"/>
                  <xsl:value-of select="normalize-space(substring-after(.,'and'))"/>
                </xsl:element>
              </xsl:when>
              <xsl:otherwise>
                <xsl:element name="language">
                  <xsl:attribute name="encodinganalog">546</xsl:attribute>
                  <xsl:call-template name="languages"/>
                  <xsl:value-of select="normalize-space(.)"/>
                </xsl:element>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="not(contains(.,','))">
          <xsl:for-each select="tokenize(substring-before(.,'.'),'and')">
            <xsl:choose>
              <xsl:when test="starts-with(.,'Additional languages')">
                <xsl:element name="language">
                  <xsl:attribute name="encodinganalog">546</xsl:attribute>
                  <xsl:call-template name="languages"/>
                  <xsl:value-of select="normalize-space(substring-after(.,'Additional languages: '))"/>
                </xsl:element>
              </xsl:when>
              <xsl:otherwise>
                <xsl:element name="language">
                  <xsl:attribute name="encodinganalog">546</xsl:attribute>
                  <xsl:call-template name="languages"/>
                  <xsl:value-of select="normalize-space(.)"/>
                </xsl:element>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:if>
    </xsl:if>
    </langmaterial>
  </xsl:template>
  -->
  
  <!-- AS2AW langmaterial one
  <xsl:template match="ead:archdesc/ead:did/ead:langmaterial[1]">
    
    <xsl:if test="count(//ead:archdesc/ead:did/ead:langmaterial) &gt;= 2"/>
    
    <xsl:if test="count(//ead:archdesc/ead:did/ead:langmaterial) &lt; 2">
      <langmaterial>
      <xsl:apply-templates select="@*|node()"/>
      </langmaterial>
    </xsl:if>
  </xsl:template>
  -->
    
  <!-- #30 - Collocation and nesting of <controlaccess> -->
  <!-- Removed match on id attribute -->

  <xsl:template match="ead:archdesc/ead:controlaccess">

    <controlaccess>
      <!-- <xsl:attribute name="id">a12</xsl:attribute> -->

      <xsl:if test="ead:persname">
        <controlaccess>
          <xsl:apply-templates select="ead:persname"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:corpname">
        <controlaccess>
          <xsl:apply-templates select="ead:corpname"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:famname">
        <controlaccess>
          <xsl:apply-templates select="ead:famname"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:geogname">
        <controlaccess>
          <xsl:apply-templates select="ead:geogname"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:subject[@source != 'archiveswest']">
        <controlaccess>
          <xsl:apply-templates select="ead:subject[@source != 'archiveswest']"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:subject[@source = 'archiveswest']">
        <controlaccess>
          <xsl:apply-templates select="ead:subject[@source = 'archiveswest']"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:function">
        <controlaccess>
          <xsl:apply-templates select="ead:function"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:genreform">
        <controlaccess>
          <xsl:apply-templates select="ead:genreform"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:occupation">
        <controlaccess>
          <xsl:apply-templates select="ead:occupation"/>
        </controlaccess>
      </xsl:if>

      <xsl:if test="ead:title">
        <controlaccess>
          <xsl:apply-templates select="ead:title"/>
        </controlaccess>
      </xsl:if>

    </controlaccess>

  </xsl:template>


  <!-- #31 - Remove item level ID and parent attributes -->

  <xsl:template match="ead:archdesc/ead:dsc//@id"/>
  <xsl:template match="ead:archdesc/ead:did/ead:container/@id"/>

  <xsl:template match="ead:archdesc/ead:dsc//@parent"/>



  <xsl:template match="ead:eadheader/ead:eadid">

    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>

      <!-- #34 - Remove 'us-' or 'US-' from mainagencycode attribute -->
      <xsl:attribute name="mainagencycode">
        <xsl:value-of select="substring-after(@mainagencycode, 'us-')"/>
        <xsl:value-of select="substring-after(@mainagencycode, 'US-')"/>
      </xsl:attribute>

      <xsl:attribute name="encodinganalog">identifier</xsl:attribute>

      <!-- #32 - Grab ARK ID from finding aid URL -->
      <xsl:attribute name="identifier">
        <xsl:value-of select="substring-after(@url, 'ark:/')"/>
      </xsl:attribute>

      <xsl:apply-templates/>
    </xsl:element>

  </xsl:template>


  <!-- #36 - Update XLink values from schema to be DTD compliant -->
  <!-- updated 6/7/2017 CEW --> 
  
  <xsl:template match="ead:extref">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="actuate">
        <xsl:value-of select="translate(@actuate,$UPPER,$LOWER)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

<!-- AS2AW: lowercase values in dao actuate -->
  <xsl:template match="ead:dao">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="actuate">
        <xsl:value-of select="translate(@xlink:actuate,$UPPER,$LOWER)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  
<!-- AS2AW: change any archdesc <dao> to <daogrp> -->
  <xsl:template match="//ead:archdesc//ead:dao">
    <xsl:element name="daogrp">
      <xsl:element name="resource">
        <xsl:attribute name="label">start</xsl:attribute>
        <!-- <xsl:text> is for display purposes only -->
        <xsl:text> </xsl:text>
      </xsl:element>
      <xsl:element name="daoloc">
        <xsl:attribute name="label">icon</xsl:attribute>
        <xsl:attribute name="role">text/html</xsl:attribute>
        <!-- If the <dao> element includes a title, set it as the link's title attribute -->
        <xsl:if test="@xlink:title">
          <xsl:attribute name="title">
            <xsl:value-of select="@xlink:title"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="href">
          <xsl:value-of select="@xlink:href"/>
        </xsl:attribute>
        </xsl:element>
      <xsl:element name="arc">
        <xsl:attribute name="from">start</xsl:attribute>
        <xsl:attribute name="to">icon</xsl:attribute>
        <xsl:attribute name="show">
          <xsl:value-of select="@xlink:show"/>
        </xsl:attribute>
        <xsl:attribute name="actuate">
          <xsl:value-of select="translate(@xlink:actuate,$UPPER,$LOWER)"/>
        </xsl:attribute>
      </xsl:element>
    </xsl:element>  
  </xsl:template>

<!-- #37 - Remove 'Bulk, ' from archdesc/unitdate -->

  <xsl:template match="ead:unitdate[@type='bulk']">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="encodinganalog">245$g</xsl:attribute>
      <!--<xsl:value-of select="substring-after(., 'Bulk, ')"/>-->
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>


  <!-- #38 - Lowercase values in extent -->

  <xsl:template match="ead:physdesc/ead:extent">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="encodinganalog">300$a</xsl:attribute>

      <xsl:value-of select="translate(., $UPPER, $LOWER)"/>
    </xsl:element>
  </xsl:template>

  <!-- Identity Transform Templates -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- #1 - Change namespace from original schema to DTD -->
  <xsl:template match="ead:*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>

<!-- #2 - Suppress Xlink namespace DTD -->
  <xsl:template match="@ns2:*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <!-- Suppress xsi:schemaLocation -->
  <xsl:template match="@*[local-name() = 'schemaLocation']"/>

  <!-- Suppress label attributes -->
  <xsl:template match="@label"/>

  <!-- Suppress id attributes.  No longer needed as of 04/20/15 -->
  <xsl:template match="@id"/>

  <!-- Suppress datechar attributes.  Added by ArchiveSpace with the move to ASpace 2.8 -->
  <xsl:template match="@datechar"/>

  <!-- AS2AW: change "naf" attribute to "lcnaf" in <persname> and <corpname> -->
  <xsl:template match="ead:persname/@source | ead:corpname/@source">
    <xsl:choose>
      <xsl:when test=".='naf'">
        <xsl:attribute name="source">
          <xsl:value-of select="'lcnaf'"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="source">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="langcodes">
    <xsl:choose>
      <xsl:when test="@langcode = 'aar'">Afar</xsl:when>
      <xsl:when test="@langcode = 'abk'">Abkhazian</xsl:when>
      <xsl:when test="@langcode = 'ace'">Achinese</xsl:when>
      <xsl:when test="@langcode = 'ach'">Acoli</xsl:when>
      <xsl:when test="@langcode = 'ada'">Adangme</xsl:when>
      <xsl:when test="@langcode = 'ady'">Adyghe; Adygei</xsl:when>
      <xsl:when test="@langcode = 'afa'">Afro-Asiatic languages</xsl:when>
      <xsl:when test="@langcode = 'afh'">Afrihili</xsl:when>
      <xsl:when test="@langcode = 'afr'">Afrikaans</xsl:when>
      <xsl:when test="@langcode = 'ain'">Ainu</xsl:when>
      <xsl:when test="@langcode = 'aka'">Akan</xsl:when>
      <xsl:when test="@langcode = 'akk'">Akkadian</xsl:when>
      <xsl:when test="@langcode = 'alb'">Albanian</xsl:when>
      <xsl:when test="@langcode = 'ale'">Aleut</xsl:when>
      <xsl:when test="@langcode = 'alg'">Algonquian languages</xsl:when>
      <xsl:when test="@langcode = 'alt'">Southern Altai</xsl:when>
      <xsl:when test="@langcode = 'amh'">Amharic</xsl:when>
      <xsl:when test="@langcode = 'ang'">English, Old (ca.450-1100)</xsl:when>
      <xsl:when test="@langcode = 'anp'">Angika</xsl:when>
      <xsl:when test="@langcode = 'apa'">Apache languages</xsl:when>
      <xsl:when test="@langcode = 'ara'">Arabic</xsl:when>
      <xsl:when test="@langcode = 'arc'">Official Aramaic (700-300 BCE); Imperial Aramaic (700-300
        BCE)</xsl:when>
      <xsl:when test="@langcode = 'arg'">Aragonese</xsl:when>
      <xsl:when test="@langcode = 'arm'">Armenian</xsl:when>
      <xsl:when test="@langcode = 'arn'">Mapudungun; Mapuche</xsl:when>
      <xsl:when test="@langcode = 'arp'">Arapaho</xsl:when>
      <xsl:when test="@langcode = 'art'">Artificial languages</xsl:when>
      <xsl:when test="@langcode = 'arw'">Arawak</xsl:when>
      <xsl:when test="@langcode = 'asm'">Assamese</xsl:when>
      <xsl:when test="@langcode = 'ast'">Asturian; Bable; Leonese; Asturleonese</xsl:when>
      <xsl:when test="@langcode = 'ath'">Athapascan languages</xsl:when>
      <xsl:when test="@langcode = 'aus'">Australian languages</xsl:when>
      <xsl:when test="@langcode = 'ava'">Avaric</xsl:when>
      <xsl:when test="@langcode = 'ave'">Avestan</xsl:when>
      <xsl:when test="@langcode = 'awa'">Awadhi</xsl:when>
      <xsl:when test="@langcode = 'aym'">Aymara</xsl:when>
      <xsl:when test="@langcode = 'aze'">Azerbaijani</xsl:when>
      <xsl:when test="@langcode = 'bad'">Banda languages</xsl:when>
      <xsl:when test="@langcode = 'bai'">Bamileke languages</xsl:when>
      <xsl:when test="@langcode = 'bak'">Bashkir</xsl:when>
      <xsl:when test="@langcode = 'bal'">Baluchi</xsl:when>
      <xsl:when test="@langcode = 'bam'">Bambara</xsl:when>
      <xsl:when test="@langcode = 'ban'">Balinese</xsl:when>
      <xsl:when test="@langcode = 'baq'">Basque</xsl:when>
      <xsl:when test="@langcode = 'bas'">Basa</xsl:when>
      <xsl:when test="@langcode = 'bat'">Baltic languages</xsl:when>
      <xsl:when test="@langcode = 'bej'">Beja; Bedawiyet</xsl:when>
      <xsl:when test="@langcode = 'bel'">Belarusian</xsl:when>
      <xsl:when test="@langcode = 'bem'">Bemba</xsl:when>
      <xsl:when test="@langcode = 'ben'">Bengali</xsl:when>
      <xsl:when test="@langcode = 'ber'">Berber languages</xsl:when>
      <xsl:when test="@langcode = 'bho'">Bhojpuri</xsl:when>
      <xsl:when test="@langcode = 'bih'">Bihari languages</xsl:when>
      <xsl:when test="@langcode = 'bik'">Bikol</xsl:when>
      <xsl:when test="@langcode = 'bin'">Bini; Edo</xsl:when>
      <xsl:when test="@langcode = 'bis'">Bislama</xsl:when>
      <xsl:when test="@langcode = 'bla'">Siksika</xsl:when>
      <xsl:when test="@langcode = 'bnt'">Bantu (Other)</xsl:when>
      <xsl:when test="@langcode = 'bos'">Bosnian</xsl:when>
      <xsl:when test="@langcode = 'bra'">Braj</xsl:when>
      <xsl:when test="@langcode = 'bre'">Breton</xsl:when>
      <xsl:when test="@langcode = 'btk'">Batak languages</xsl:when>
      <xsl:when test="@langcode = 'bua'">Buriat</xsl:when>
      <xsl:when test="@langcode = 'bug'">Buginese</xsl:when>
      <xsl:when test="@langcode = 'bul'">Bulgarian</xsl:when>
      <xsl:when test="@langcode = 'bur'">Burmese</xsl:when>
      <xsl:when test="@langcode = 'byn'">Blin; Bilin</xsl:when>
      <xsl:when test="@langcode = 'cad'">Caddo</xsl:when>
      <xsl:when test="@langcode = 'cai'">Central American Indian languages</xsl:when>
      <xsl:when test="@langcode = 'car'">Galibi Carib</xsl:when>
      <xsl:when test="@langcode = 'cat'">Catalan; Valencian</xsl:when>
      <xsl:when test="@langcode = 'cau'">Caucasian languages</xsl:when>
      <xsl:when test="@langcode = 'ceb'">Cebuano</xsl:when>
      <xsl:when test="@langcode = 'cel'">Celtic languages</xsl:when>
      <xsl:when test="@langcode = 'cha'">Chamorro</xsl:when>
      <xsl:when test="@langcode = 'chb'">Chibcha</xsl:when>
      <xsl:when test="@langcode = 'che'">Chechen</xsl:when>
      <xsl:when test="@langcode = 'chg'">Chagatai</xsl:when>
      <xsl:when test="@langcode = 'chi'">Chinese</xsl:when>
      <xsl:when test="@langcode = 'chk'">Chuukese</xsl:when>
      <xsl:when test="@langcode = 'chm'">Mari</xsl:when>
      <xsl:when test="@langcode = 'chn'">Chinook jargon</xsl:when>
      <xsl:when test="@langcode = 'cho'">Choctaw</xsl:when>
      <xsl:when test="@langcode = 'chp'">Chipewyan; Dene Suline</xsl:when>
      <xsl:when test="@langcode = 'chr'">Cherokee</xsl:when>
      <xsl:when test="@langcode = 'chu'">Church Slavic; Old Slavonic; Church Slavonic; Old
        Bulgarian; Old Church Slavonic</xsl:when>
      <xsl:when test="@langcode = 'chv'">Chuvash</xsl:when>
      <xsl:when test="@langcode = 'chy'">Cheyenne</xsl:when>
      <xsl:when test="@langcode = 'cmc'">Chamic languages</xsl:when>
      <xsl:when test="@langcode = 'cop'">Coptic</xsl:when>
      <xsl:when test="@langcode = 'cor'">Cornish</xsl:when>
      <xsl:when test="@langcode = 'cos'">Corsican</xsl:when>
      <xsl:when test="@langcode = 'cpe'">Creoles and pidgins, English based</xsl:when>
      <xsl:when test="@langcode = 'cpf'">Creoles and pidgins, French-based</xsl:when>
      <xsl:when test="@langcode = 'cpp'">Creoles and pidgins, Portuguese-based</xsl:when>
      <xsl:when test="@langcode = 'cre'">Cree</xsl:when>
      <xsl:when test="@langcode = 'crh'">Crimean Tatar; Crimean Turkish</xsl:when>
      <xsl:when test="@langcode = 'crp'">Creoles and pidgins</xsl:when>
      <xsl:when test="@langcode = 'csb'">Kashubian</xsl:when>
      <xsl:when test="@langcode = 'cus'">Cushitic languages</xsl:when>
      <xsl:when test="@langcode = 'cze'">Czech</xsl:when>
      <xsl:when test="@langcode = 'dak'">Dakota</xsl:when>
      <xsl:when test="@langcode = 'dan'">Danish</xsl:when>
      <xsl:when test="@langcode = 'dar'">Dargwa</xsl:when>
      <xsl:when test="@langcode = 'day'">Land Dayak languages</xsl:when>
      <xsl:when test="@langcode = 'del'">Delaware</xsl:when>
      <xsl:when test="@langcode = 'den'">Slave (Athapascan)</xsl:when>
      <xsl:when test="@langcode = 'dgr'">Dogrib</xsl:when>
      <xsl:when test="@langcode = 'din'">Dinka</xsl:when>
      <xsl:when test="@langcode = 'div'">Divehi; Dhivehi; Maldivian</xsl:when>
      <xsl:when test="@langcode = 'doi'">Dogri</xsl:when>
      <xsl:when test="@langcode = 'dra'">Dravidian languages</xsl:when>
      <xsl:when test="@langcode = 'dsb'">Lower Sorbian</xsl:when>
      <xsl:when test="@langcode = 'dua'">Duala</xsl:when>
      <xsl:when test="@langcode = 'dum'">Dutch, Middle (ca.1050-1350)</xsl:when>
      <xsl:when test="@langcode = 'dut'">Dutch; Flemish</xsl:when>
      <xsl:when test="@langcode = 'dyu'">Dyula</xsl:when>
      <xsl:when test="@langcode = 'dzo'">Dzongkha</xsl:when>
      <xsl:when test="@langcode = 'efi'">Efik</xsl:when>
      <xsl:when test="@langcode = 'egy'">Egyptian (Ancient)</xsl:when>
      <xsl:when test="@langcode = 'eka'">Ekajuk</xsl:when>
      <xsl:when test="@langcode = 'elx'">Elamite</xsl:when>
      <xsl:when test="@langcode = 'eng'">English</xsl:when>
      <xsl:when test="@langcode = 'enm'">English, Middle (1100-1500)</xsl:when>
      <xsl:when test="@langcode = 'epo'">Esperanto</xsl:when>
      <xsl:when test="@langcode = 'est'">Estonian</xsl:when>
      <xsl:when test="@langcode = 'ewe'">Ewe</xsl:when>
      <xsl:when test="@langcode = 'ewo'">Ewondo</xsl:when>
      <xsl:when test="@langcode = 'fan'">Fang</xsl:when>
      <xsl:when test="@langcode = 'fao'">Faroese</xsl:when>
      <xsl:when test="@langcode = 'fat'">Fanti</xsl:when>
      <xsl:when test="@langcode = 'fij'">Fijian</xsl:when>
      <xsl:when test="@langcode = 'fil'">Filipino; Pilipino</xsl:when>
      <xsl:when test="@langcode = 'fin'">Finnish</xsl:when>
      <xsl:when test="@langcode = 'fiu'">Finno-Ugrian languages</xsl:when>
      <xsl:when test="@langcode = 'fon'">Fon</xsl:when>
      <xsl:when test="@langcode = 'fre'">French</xsl:when>
      <xsl:when test="@langcode = 'frm'">French, Middle (ca.1400-1600)</xsl:when>
      <xsl:when test="@langcode = 'fro'">French, Old (842-ca.1400)</xsl:when>
      <xsl:when test="@langcode = 'frr'">Northern Frisian</xsl:when>
      <xsl:when test="@langcode = 'frs'">Eastern Frisian</xsl:when>
      <xsl:when test="@langcode = 'fry'">Western Frisian</xsl:when>
      <xsl:when test="@langcode = 'ful'">Fulah</xsl:when>
      <xsl:when test="@langcode = 'fur'">Friulian</xsl:when>
      <xsl:when test="@langcode = 'gaa'">Ga</xsl:when>
      <xsl:when test="@langcode = 'gay'">Gayo</xsl:when>
      <xsl:when test="@langcode = 'gba'">Gbaya</xsl:when>
      <xsl:when test="@langcode = 'gem'">Germanic languages</xsl:when>
      <xsl:when test="@langcode = 'geo'">Georgian</xsl:when>
      <xsl:when test="@langcode = 'ger'">German</xsl:when>
      <xsl:when test="@langcode = 'gez'">Geez</xsl:when>
      <xsl:when test="@langcode = 'gil'">Gilbertese</xsl:when>
      <xsl:when test="@langcode = 'gla'">Gaelic; Scottish Gaelic</xsl:when>
      <xsl:when test="@langcode = 'gle'">Irish</xsl:when>
      <xsl:when test="@langcode = 'glg'">Galician</xsl:when>
      <xsl:when test="@langcode = 'glv'">Manx</xsl:when>
      <xsl:when test="@langcode = 'gmh'">German, Middle High (ca.1050-1500)</xsl:when>
      <xsl:when test="@langcode = 'goh'">German, Old High (ca.750-1050)</xsl:when>
      <xsl:when test="@langcode = 'gon'">Gondi</xsl:when>
      <xsl:when test="@langcode = 'gor'">Gorontalo</xsl:when>
      <xsl:when test="@langcode = 'got'">Gothic</xsl:when>
      <xsl:when test="@langcode = 'grb'">Grebo</xsl:when>
      <xsl:when test="@langcode = 'grc'">Greek, Ancient (to 1453)</xsl:when>
      <xsl:when test="@langcode = 'gre'">Greek, Modern (1453-)</xsl:when>
      <xsl:when test="@langcode = 'grn'">Guarani</xsl:when>
      <xsl:when test="@langcode = 'gsw'">Swiss German; Alemannic; Alsatian</xsl:when>
      <xsl:when test="@langcode = 'guj'">Gujarati</xsl:when>
      <xsl:when test="@langcode = 'gwi'">Gwich'in</xsl:when>
      <xsl:when test="@langcode = 'hai'">Haida</xsl:when>
      <xsl:when test="@langcode = 'hat'">Haitian; Haitian Creole</xsl:when>
      <xsl:when test="@langcode = 'hau'">Hausa</xsl:when>
      <xsl:when test="@langcode = 'haw'">Hawaiian</xsl:when>
      <xsl:when test="@langcode = 'heb'">Hebrew</xsl:when>
      <xsl:when test="@langcode = 'her'">Herero</xsl:when>
      <xsl:when test="@langcode = 'hil'">Hiligaynon</xsl:when>
      <xsl:when test="@langcode = 'him'">Himachali languages; Western Pahari languages</xsl:when>
      <xsl:when test="@langcode = 'hin'">Hindi</xsl:when>
      <xsl:when test="@langcode = 'hit'">Hittite</xsl:when>
      <xsl:when test="@langcode = 'hmn'">Hmong; Mong</xsl:when>
      <xsl:when test="@langcode = 'hmo'">Hiri Motu</xsl:when>
      <xsl:when test="@langcode = 'hrv'">Croatian</xsl:when>
      <xsl:when test="@langcode = 'hsb'">Upper Sorbian</xsl:when>
      <xsl:when test="@langcode = 'hun'">Hungarian</xsl:when>
      <xsl:when test="@langcode = 'hup'">Hupa</xsl:when>
      <xsl:when test="@langcode = 'iba'">Iban</xsl:when>
      <xsl:when test="@langcode = 'ibo'">Igbo</xsl:when>
      <xsl:when test="@langcode = 'ice'">Icelandic</xsl:when>
      <xsl:when test="@langcode = 'ido'">Ido</xsl:when>
      <xsl:when test="@langcode = 'iii'">Sichuan Yi; Nuosu</xsl:when>
      <xsl:when test="@langcode = 'ijo'">Ijo languages</xsl:when>
      <xsl:when test="@langcode = 'iku'">Inuktitut</xsl:when>
      <xsl:when test="@langcode = 'ile'">Interlingue; Occidental</xsl:when>
      <xsl:when test="@langcode = 'ilo'">Iloko</xsl:when>
      <xsl:when test="@langcode = 'ina'">Interlingua (International Auxiliary Language
        Association)</xsl:when>
      <xsl:when test="@langcode = 'inc'">Indic languages</xsl:when>
      <xsl:when test="@langcode = 'ind'">Indonesian</xsl:when>
      <xsl:when test="@langcode = 'ine'">Indo-European languages</xsl:when>
      <xsl:when test="@langcode = 'inh'">Ingush</xsl:when>
      <xsl:when test="@langcode = 'ipk'">Inupiaq</xsl:when>
      <xsl:when test="@langcode = 'ira'">Iranian languages</xsl:when>
      <xsl:when test="@langcode = 'iro'">Iroquoian languages</xsl:when>
      <xsl:when test="@langcode = 'ita'">Italian</xsl:when>
      <xsl:when test="@langcode = 'jav'">Javanese</xsl:when>
      <xsl:when test="@langcode = 'jbo'">Lojban</xsl:when>
      <xsl:when test="@langcode = 'jpn'">Japanese</xsl:when>
      <xsl:when test="@langcode = 'jpr'">Judeo-Persian</xsl:when>
      <xsl:when test="@langcode = 'jrb'">Judeo-Arabic</xsl:when>
      <xsl:when test="@langcode = 'kaa'">Kara-Kalpak</xsl:when>
      <xsl:when test="@langcode = 'kab'">Kabyle</xsl:when>
      <xsl:when test="@langcode = 'kac'">Kachin; Jingpho</xsl:when>
      <xsl:when test="@langcode = 'kal'">Kalaallisut; Greenlandic</xsl:when>
      <xsl:when test="@langcode = 'kam'">Kamba</xsl:when>
      <xsl:when test="@langcode = 'kan'">Kannada</xsl:when>
      <xsl:when test="@langcode = 'kar'">Karen languages</xsl:when>
      <xsl:when test="@langcode = 'kas'">Kashmiri</xsl:when>
      <xsl:when test="@langcode = 'kau'">Kanuri</xsl:when>
      <xsl:when test="@langcode = 'kaw'">Kawi</xsl:when>
      <xsl:when test="@langcode = 'kaz'">Kazakh</xsl:when>
      <xsl:when test="@langcode = 'kbd'">Kabardian</xsl:when>
      <xsl:when test="@langcode = 'kha'">Khasi</xsl:when>
      <xsl:when test="@langcode = 'khi'">Khoisan languages</xsl:when>
      <xsl:when test="@langcode = 'khm'">Central Khmer</xsl:when>
      <xsl:when test="@langcode = 'kho'">Khotanese; Sakan</xsl:when>
      <xsl:when test="@langcode = 'kik'">Kikuyu; Gikuyu</xsl:when>
      <xsl:when test="@langcode = 'kin'">Kinyarwanda</xsl:when>
      <xsl:when test="@langcode = 'kir'">Kirghiz; Kyrgyz</xsl:when>
      <xsl:when test="@langcode = 'kmb'">Kimbundu</xsl:when>
      <xsl:when test="@langcode = 'kok'">Konkani</xsl:when>
      <xsl:when test="@langcode = 'kom'">Komi</xsl:when>
      <xsl:when test="@langcode = 'kon'">Kongo</xsl:when>
      <xsl:when test="@langcode = 'kor'">Korean</xsl:when>
      <xsl:when test="@langcode = 'kos'">Kosraean</xsl:when>
      <xsl:when test="@langcode = 'kpe'">Kpelle</xsl:when>
      <xsl:when test="@langcode = 'krc'">Karachay-Balkar</xsl:when>
      <xsl:when test="@langcode = 'krl'">Karelian</xsl:when>
      <xsl:when test="@langcode = 'kro'">Kru languages</xsl:when>
      <xsl:when test="@langcode = 'kru'">Kurukh</xsl:when>
      <xsl:when test="@langcode = 'kua'">Kuanyama; Kwanyama</xsl:when>
      <xsl:when test="@langcode = 'kum'">Kumyk</xsl:when>
      <xsl:when test="@langcode = 'kur'">Kurdish</xsl:when>
      <xsl:when test="@langcode = 'kut'">Kutenai</xsl:when>
      <xsl:when test="@langcode = 'lad'">Ladino</xsl:when>
      <xsl:when test="@langcode = 'lah'">Lahnda</xsl:when>
      <xsl:when test="@langcode = 'lam'">Lamba</xsl:when>
      <xsl:when test="@langcode = 'lao'">Lao</xsl:when>
      <xsl:when test="@langcode = 'lat'">Latin</xsl:when>
      <xsl:when test="@langcode = 'lav'">Latvian</xsl:when>
      <xsl:when test="@langcode = 'lez'">Lezghian</xsl:when>
      <xsl:when test="@langcode = 'lim'">Limburgan; Limburger; Limburgish</xsl:when>
      <xsl:when test="@langcode = 'lin'">Lingala</xsl:when>
      <xsl:when test="@langcode = 'lit'">Lithuanian</xsl:when>
      <xsl:when test="@langcode = 'lol'">Mongo</xsl:when>
      <xsl:when test="@langcode = 'loz'">Lozi</xsl:when>
      <xsl:when test="@langcode = 'ltz'">Luxembourgish; Letzeburgesch</xsl:when>
      <xsl:when test="@langcode = 'lua'">Luba-Lulua</xsl:when>
      <xsl:when test="@langcode = 'lub'">Luba-Katanga</xsl:when>
      <xsl:when test="@langcode = 'lug'">Ganda</xsl:when>
      <xsl:when test="@langcode = 'lui'">Luiseno</xsl:when>
      <xsl:when test="@langcode = 'lun'">Lunda</xsl:when>
      <xsl:when test="@langcode = 'luo'">Luo (Kenya and Tanzania)</xsl:when>
      <xsl:when test="@langcode = 'lus'">Lushai</xsl:when>
      <xsl:when test="@langcode = 'mac'">Macedonian</xsl:when>
      <xsl:when test="@langcode = 'mad'">Madurese</xsl:when>
      <xsl:when test="@langcode = 'mag'">Magahi</xsl:when>
      <xsl:when test="@langcode = 'mah'">Marshallese</xsl:when>
      <xsl:when test="@langcode = 'mai'">Maithili</xsl:when>
      <xsl:when test="@langcode = 'mak'">Makasar</xsl:when>
      <xsl:when test="@langcode = 'mal'">Malayalam</xsl:when>
      <xsl:when test="@langcode = 'man'">Mandingo</xsl:when>
      <xsl:when test="@langcode = 'mao'">Maori</xsl:when>
      <xsl:when test="@langcode = 'map'">Austronesian languages</xsl:when>
      <xsl:when test="@langcode = 'mar'">Marathi</xsl:when>
      <xsl:when test="@langcode = 'mas'">Masai</xsl:when>
      <xsl:when test="@langcode = 'may'">Malay</xsl:when>
      <xsl:when test="@langcode = 'mdf'">Moksha</xsl:when>
      <xsl:when test="@langcode = 'mdr'">Mandar</xsl:when>
      <xsl:when test="@langcode = 'men'">Mende</xsl:when>
      <xsl:when test="@langcode = 'mga'">Irish, Middle (900-1200)</xsl:when>
      <xsl:when test="@langcode = 'mic'">Mi'kmaq; Micmac</xsl:when>
      <xsl:when test="@langcode = 'min'">Minangkabau</xsl:when>
      <xsl:when test="@langcode = 'mis'">Uncoded languages</xsl:when>
      <xsl:when test="@langcode = 'mkh'">Mon-Khmer languages</xsl:when>
      <xsl:when test="@langcode = 'mlg'">Malagasy</xsl:when>
      <xsl:when test="@langcode = 'mlt'">Maltese</xsl:when>
      <xsl:when test="@langcode = 'mnc'">Manchu</xsl:when>
      <xsl:when test="@langcode = 'mni'">Manipuri</xsl:when>
      <xsl:when test="@langcode = 'mno'">Manobo languages</xsl:when>
      <xsl:when test="@langcode = 'moh'">Mohawk</xsl:when>
      <xsl:when test="@langcode = 'mon'">Mongolian</xsl:when>
      <xsl:when test="@langcode = 'mos'">Mossi</xsl:when>
      <xsl:when test="@langcode = 'mul'">Multiple languages</xsl:when>
      <xsl:when test="@langcode = 'mun'">Munda languages</xsl:when>
      <xsl:when test="@langcode = 'mus'">Creek</xsl:when>
      <xsl:when test="@langcode = 'mwl'">Mirandese</xsl:when>
      <xsl:when test="@langcode = 'mwr'">Marwari</xsl:when>
      <xsl:when test="@langcode = 'myn'">Mayan languages</xsl:when>
      <xsl:when test="@langcode = 'myv'">Erzya</xsl:when>
      <xsl:when test="@langcode = 'nah'">Nahuatl languages</xsl:when>
      <xsl:when test="@langcode = 'nai'">North American Indian languages</xsl:when>
      <xsl:when test="@langcode = 'nap'">Neapolitan</xsl:when>
      <xsl:when test="@langcode = 'nau'">Nauru</xsl:when>
      <xsl:when test="@langcode = 'nav'">Navajo; Navaho</xsl:when>
      <xsl:when test="@langcode = 'nbl'">Ndebele, South; South Ndebele</xsl:when>
      <xsl:when test="@langcode = 'nde'">Ndebele, North; North Ndebele</xsl:when>
      <xsl:when test="@langcode = 'ndo'">Ndonga</xsl:when>
      <xsl:when test="@langcode = 'nds'">Low German; Low Saxon; German, Low; Saxon, Low</xsl:when>
      <xsl:when test="@langcode = 'nep'">Nepali</xsl:when>
      <xsl:when test="@langcode = 'new'">Nepal Bhasa; Newari</xsl:when>
      <xsl:when test="@langcode = 'nia'">Nias</xsl:when>
      <xsl:when test="@langcode = 'nic'">Niger-Kordofanian languages</xsl:when>
      <xsl:when test="@langcode = 'niu'">Niuean</xsl:when>
      <xsl:when test="@langcode = 'nno'">Norwegian Nynorsk; Nynorsk, Norwegian</xsl:when>
      <xsl:when test="@langcode = 'nob'">Bokmål, Norwegian; Norwegian Bokmål</xsl:when>
      <xsl:when test="@langcode = 'nog'">Nogai</xsl:when>
      <xsl:when test="@langcode = 'non'">Norse, Old</xsl:when>
      <xsl:when test="@langcode = 'nor'">Norwegian</xsl:when>
      <xsl:when test="@langcode = 'nqo'">N'Ko</xsl:when>
      <xsl:when test="@langcode = 'nso'">Pedi; Sepedi; Northern Sotho</xsl:when>
      <xsl:when test="@langcode = 'nub'">Nubian languages</xsl:when>
      <xsl:when test="@langcode = 'nwc'">Classical Newari; Old Newari; Classical Nepal
        Bhasa</xsl:when>
      <xsl:when test="@langcode = 'nya'">Chichewa; Chewa; Nyanja</xsl:when>
      <xsl:when test="@langcode = 'nym'">Nyamwezi</xsl:when>
      <xsl:when test="@langcode = 'nyn'">Nyankole</xsl:when>
      <xsl:when test="@langcode = 'nyo'">Nyoro</xsl:when>
      <xsl:when test="@langcode = 'nzi'">Nzima</xsl:when>
      <xsl:when test="@langcode = 'oci'">Occitan (post 1500); Provençal</xsl:when>
      <xsl:when test="@langcode = 'oji'">Ojibwa</xsl:when>
      <xsl:when test="@langcode = 'ori'">Oriya</xsl:when>
      <xsl:when test="@langcode = 'orm'">Oromo</xsl:when>
      <xsl:when test="@langcode = 'osa'">Osage</xsl:when>
      <xsl:when test="@langcode = 'oss'">Ossetian; Ossetic</xsl:when>
      <xsl:when test="@langcode = 'ota'">Turkish, Ottoman (1500-1928)</xsl:when>
      <xsl:when test="@langcode = 'oto'">Otomian languages</xsl:when>
      <xsl:when test="@langcode = 'paa'">Papuan languages</xsl:when>
      <xsl:when test="@langcode = 'pag'">Pangasinan</xsl:when>
      <xsl:when test="@langcode = 'pal'">Pahlavi</xsl:when>
      <xsl:when test="@langcode = 'pam'">Pampanga; Kapampangan</xsl:when>
      <xsl:when test="@langcode = 'pan'">Panjabi; Punjabi</xsl:when>
      <xsl:when test="@langcode = 'pap'">Papiamento</xsl:when>
      <xsl:when test="@langcode = 'pau'">Palauan</xsl:when>
      <xsl:when test="@langcode = 'peo'">Persian, Old (ca.600-400 B.C.)</xsl:when>
      <xsl:when test="@langcode = 'per'">Persian</xsl:when>
      <xsl:when test="@langcode = 'phi'">Philippine languages</xsl:when>
      <xsl:when test="@langcode = 'phn'">Phoenician</xsl:when>
      <xsl:when test="@langcode = 'pli'">Pali</xsl:when>
      <xsl:when test="@langcode = 'pol'">Polish</xsl:when>
      <xsl:when test="@langcode = 'pon'">Pohnpeian</xsl:when>
      <xsl:when test="@langcode = 'por'">Portuguese</xsl:when>
      <xsl:when test="@langcode = 'pra'">Prakrit languages</xsl:when>
      <xsl:when test="@langcode = 'pro'">Provençal, Old (to 1500)</xsl:when>
      <xsl:when test="@langcode = 'pus'">Pushto; Pashto</xsl:when>
      <xsl:when test="@langcode = 'qaa-qtz'">Reserved for local use</xsl:when>
      <xsl:when test="@langcode = 'que'">Quechua</xsl:when>
      <xsl:when test="@langcode = 'raj'">Rajasthani</xsl:when>
      <xsl:when test="@langcode = 'rap'">Rapanui</xsl:when>
      <xsl:when test="@langcode = 'rar'">Rarotongan; Cook Islands Maori</xsl:when>
      <xsl:when test="@langcode = 'roa'">Romance languages</xsl:when>
      <xsl:when test="@langcode = 'roh'">Romansh</xsl:when>
      <xsl:when test="@langcode = 'rom'">Romany</xsl:when>
      <xsl:when test="@langcode = 'rum'">Romanian; Moldavian; Moldovan</xsl:when>
      <xsl:when test="@langcode = 'run'">Rundi</xsl:when>
      <xsl:when test="@langcode = 'rup'">Aromanian; Arumanian; Macedo-Romanian</xsl:when>
      <xsl:when test="@langcode = 'rus'">Russian</xsl:when>
      <xsl:when test="@langcode = 'sad'">Sandawe</xsl:when>
      <xsl:when test="@langcode = 'sag'">Sango</xsl:when>
      <xsl:when test="@langcode = 'sah'">Yakut</xsl:when>
      <xsl:when test="@langcode = 'sai'">South American Indian (Other)</xsl:when>
      <xsl:when test="@langcode = 'sal'">Salishan languages</xsl:when>
      <xsl:when test="@langcode = 'sam'">Samaritan Aramaic</xsl:when>
      <xsl:when test="@langcode = 'san'">Sanskrit</xsl:when>
      <xsl:when test="@langcode = 'sas'">Sasak</xsl:when>
      <xsl:when test="@langcode = 'sat'">Santali</xsl:when>
      <xsl:when test="@langcode = 'scn'">Sicilian</xsl:when>
      <xsl:when test="@langcode = 'sco'">Scots</xsl:when>
      <xsl:when test="@langcode = 'sel'">Selkup</xsl:when>
      <xsl:when test="@langcode = 'sem'">Semitic languages</xsl:when>
      <xsl:when test="@langcode = 'sga'">Irish, Old (to 900)</xsl:when>
      <xsl:when test="@langcode = 'sgn'">Sign Languages</xsl:when>
      <xsl:when test="@langcode = 'shn'">Shan</xsl:when>
      <xsl:when test="@langcode = 'sid'">Sidamo</xsl:when>
      <xsl:when test="@langcode = 'sin'">Sinhala; Sinhalese</xsl:when>
      <xsl:when test="@langcode = 'sio'">Siouan languages</xsl:when>
      <xsl:when test="@langcode = 'sit'">Sino-Tibetan languages</xsl:when>
      <xsl:when test="@langcode = 'sla'">Slavic languages</xsl:when>
      <xsl:when test="@langcode = 'slo'">Slovak</xsl:when>
      <xsl:when test="@langcode = 'slv'">Slovenian</xsl:when>
      <xsl:when test="@langcode = 'sma'">Southern Sami</xsl:when>
      <xsl:when test="@langcode = 'sme'">Northern Sami</xsl:when>
      <xsl:when test="@langcode = 'smi'">Sami languages</xsl:when>
      <xsl:when test="@langcode = 'smj'">Lule Sami</xsl:when>
      <xsl:when test="@langcode = 'smn'">Inari Sami</xsl:when>
      <xsl:when test="@langcode = 'smo'">Samoan</xsl:when>
      <xsl:when test="@langcode = 'sms'">Skolt Sami</xsl:when>
      <xsl:when test="@langcode = 'sna'">Shona</xsl:when>
      <xsl:when test="@langcode = 'snd'">Sindhi</xsl:when>
      <xsl:when test="@langcode = 'snk'">Soninke</xsl:when>
      <xsl:when test="@langcode = 'sog'">Sogdian</xsl:when>
      <xsl:when test="@langcode = 'som'">Somali</xsl:when>
      <xsl:when test="@langcode = 'son'">Songhai languages</xsl:when>
      <xsl:when test="@langcode = 'sot'">Sotho, Southern</xsl:when>
      <xsl:when test="@langcode = 'spa'">Spanish; Castilian</xsl:when>
      <xsl:when test="@langcode = 'srd'">Sardinian</xsl:when>
      <xsl:when test="@langcode = 'srn'">Sranan Tongo</xsl:when>
      <xsl:when test="@langcode = 'srp'">Serbian</xsl:when>
      <xsl:when test="@langcode = 'srr'">Serer</xsl:when>
      <xsl:when test="@langcode = 'ssa'">Nilo-Saharan languages</xsl:when>
      <xsl:when test="@langcode = 'ssw'">Swati</xsl:when>
      <xsl:when test="@langcode = 'suk'">Sukuma</xsl:when>
      <xsl:when test="@langcode = 'sun'">Sundanese</xsl:when>
      <xsl:when test="@langcode = 'sus'">Susu</xsl:when>
      <xsl:when test="@langcode = 'sux'">Sumerian</xsl:when>
      <xsl:when test="@langcode = 'swa'">Swahili</xsl:when>
      <xsl:when test="@langcode = 'swe'">Swedish</xsl:when>
      <xsl:when test="@langcode = 'syc'">Classical Syriac</xsl:when>
      <xsl:when test="@langcode = 'syr'">Syriac</xsl:when>
      <xsl:when test="@langcode = 'tah'">Tahitian</xsl:when>
      <xsl:when test="@langcode = 'tai'">Tai languages</xsl:when>
      <xsl:when test="@langcode = 'tam'">Tamil</xsl:when>
      <xsl:when test="@langcode = 'tat'">Tatar</xsl:when>
      <xsl:when test="@langcode = 'tel'">Telugu</xsl:when>
      <xsl:when test="@langcode = 'tem'">Timne</xsl:when>
      <xsl:when test="@langcode = 'ter'">Tereno</xsl:when>
      <xsl:when test="@langcode = 'tet'">Tetum</xsl:when>
      <xsl:when test="@langcode = 'tgk'">Tajik</xsl:when>
      <xsl:when test="@langcode = 'tgl'">Tagalog</xsl:when>
      <xsl:when test="@langcode = 'tha'">Thai</xsl:when>
      <xsl:when test="@langcode = 'tib'">Tibetan</xsl:when>
      <xsl:when test="@langcode = 'tig'">Tigre</xsl:when>
      <xsl:when test="@langcode = 'tir'">Tigrinya</xsl:when>
      <xsl:when test="@langcode = 'tiv'">Tiv</xsl:when>
      <xsl:when test="@langcode = 'tkl'">Tokelau</xsl:when>
      <xsl:when test="@langcode = 'tlh'">Klingon; tlhIngan-Hol</xsl:when>
      <xsl:when test="@langcode = 'tli'">Tlingit</xsl:when>
      <xsl:when test="@langcode = 'tmh'">Tamashek</xsl:when>
      <xsl:when test="@langcode = 'tog'">Tonga (Nyasa)</xsl:when>
      <xsl:when test="@langcode = 'ton'">Tonga (Tonga Islands)</xsl:when>
      <xsl:when test="@langcode = 'tpi'">Tok Pisin</xsl:when>
      <xsl:when test="@langcode = 'tsi'">Tsimshian</xsl:when>
      <xsl:when test="@langcode = 'tsn'">Tswana</xsl:when>
      <xsl:when test="@langcode = 'tso'">Tsonga</xsl:when>
      <xsl:when test="@langcode = 'tuk'">Turkmen</xsl:when>
      <xsl:when test="@langcode = 'tum'">Tumbuka</xsl:when>
      <xsl:when test="@langcode = 'tup'">Tupi languages</xsl:when>
      <xsl:when test="@langcode = 'tur'">Turkish</xsl:when>
      <xsl:when test="@langcode = 'tut'">Altaic languages</xsl:when>
      <xsl:when test="@langcode = 'tvl'">Tuvalu</xsl:when>
      <xsl:when test="@langcode = 'twi'">Twi</xsl:when>
      <xsl:when test="@langcode = 'tyv'">Tuvinian</xsl:when>
      <xsl:when test="@langcode = 'udm'">Udmurt</xsl:when>
      <xsl:when test="@langcode = 'uga'">Ugaritic</xsl:when>
      <xsl:when test="@langcode = 'uig'">Uighur; Uyghur</xsl:when>
      <xsl:when test="@langcode = 'ukr'">Ukrainian</xsl:when>
      <xsl:when test="@langcode = 'umb'">Umbundu</xsl:when>
      <xsl:when test="@langcode = 'und'">Undetermined</xsl:when>
      <xsl:when test="@langcode = 'urd'">Urdu</xsl:when>
      <xsl:when test="@langcode = 'uzb'">Uzbek</xsl:when>
      <xsl:when test="@langcode = 'vai'">Vai</xsl:when>
      <xsl:when test="@langcode = 'ven'">Venda</xsl:when>
      <xsl:when test="@langcode = 'vie'">Vietnamese</xsl:when>
      <xsl:when test="@langcode = 'vol'">Volapük</xsl:when>
      <xsl:when test="@langcode = 'vot'">Votic</xsl:when>
      <xsl:when test="@langcode = 'wak'">Wakashan languages</xsl:when>
      <xsl:when test="@langcode = 'wal'">Walamo</xsl:when>
      <xsl:when test="@langcode = 'war'">Waray</xsl:when>
      <xsl:when test="@langcode = 'was'">Washo</xsl:when>
      <xsl:when test="@langcode = 'wel'">Welsh</xsl:when>
      <xsl:when test="@langcode = 'wen'">Sorbian languages</xsl:when>
      <xsl:when test="@langcode = 'wln'">Walloon</xsl:when>
      <xsl:when test="@langcode = 'wol'">Wolof</xsl:when>
      <xsl:when test="@langcode = 'xal'">Kalmyk; Oirat</xsl:when>
      <xsl:when test="@langcode = 'xho'">Xhosa</xsl:when>
      <xsl:when test="@langcode = 'yao'">Yao</xsl:when>
      <xsl:when test="@langcode = 'yap'">Yapese</xsl:when>
      <xsl:when test="@langcode = 'yid'">Yiddish</xsl:when>
      <xsl:when test="@langcode = 'yor'">Yoruba</xsl:when>
      <xsl:when test="@langcode = 'ypk'">Yupik languages</xsl:when>
      <xsl:when test="@langcode = 'zap'">Zapotec</xsl:when>
      <xsl:when test="@langcode = 'zbl'">Blissymbols; Blissymbolics; Bliss</xsl:when>
      <xsl:when test="@langcode = 'zen'">Zenaga</xsl:when>
      <xsl:when test="@langcode = 'zha'">Zhuang; Chuang</xsl:when>
      <xsl:when test="@langcode = 'znd'">Zande languages</xsl:when>
      <xsl:when test="@langcode = 'zul'">Zulu</xsl:when>
      <xsl:when test="@langcode = 'zun'">Zuni</xsl:when>
      <xsl:when test="@langcode = 'zxx'">No linguistic content; Not applicable</xsl:when>
      <xsl:when test="@langcode = 'zza'">Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- reverse language lookup -->
  <xsl:template name="languages">
    <xsl:choose>
      <xsl:when test="contains(.,'Afar')">
        <xsl:attribute name="langcode">aar</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Abkhazian')">
        <xsl:attribute name="langcode">abk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Achinese')">
        <xsl:attribute name="langcode">ace</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Acoli')">
        <xsl:attribute name="langcode">ach</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Adangme')">
        <xsl:attribute name="langcode">ada</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Adyghe; Adygei')">
        <xsl:attribute name="langcode">ady</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Afro-Asiatic languages')">
        <xsl:attribute name="langcode">afa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Afrihili')">
        <xsl:attribute name="langcode">afh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Afrikaans')">
        <xsl:attribute name="langcode">afr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ainu')">
        <xsl:attribute name="langcode">ain</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Akan')">
        <xsl:attribute name="langcode">aka</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Akkadian')">
        <xsl:attribute name="langcode">akk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Albanian')">
        <xsl:attribute name="langcode">alb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Aleut')">
        <xsl:attribute name="langcode">ale</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Algonquian languages')">
        <xsl:attribute name="langcode">alg</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Southern Altai')">
        <xsl:attribute name="langcode">alt</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Amharic')">
        <xsl:attribute name="langcode">amh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'English, Old (ca.450-1100)')">
        <xsl:attribute name="langcode">ang</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Angika')">
        <xsl:attribute name="langcode">anp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Apache languages')">
        <xsl:attribute name="langcode">apa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Arabic')">
        <xsl:attribute name="langcode">ara</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE)')">
        <xsl:attribute name="langcode">arc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Aragonese')">
        <xsl:attribute name="langcode">arg</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Armenian')">
        <xsl:attribute name="langcode">arm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mapudungun; Mapuche')">
        <xsl:attribute name="langcode">arn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Arapaho')">
        <xsl:attribute name="langcode">arp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Artificial languages')">
        <xsl:attribute name="langcode">art</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Arawak')">
        <xsl:attribute name="langcode">arw</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Assamese')">
        <xsl:attribute name="langcode">asm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Asturian; Bable; Leonese; Asturleonese')">
        <xsl:attribute name="langcode">ast</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Athapascan languages')">
        <xsl:attribute name="langcode">ath</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Australian languages')">
        <xsl:attribute name="langcode">aus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Avaric')">
        <xsl:attribute name="langcode">ava</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Avestan')">
        <xsl:attribute name="langcode">ave</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Awadhi')">
        <xsl:attribute name="langcode">awa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Aymara')">
        <xsl:attribute name="langcode">aym</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Azerbaijani')">
        <xsl:attribute name="langcode">aze</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Banda languages')">
        <xsl:attribute name="langcode">bad</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bamileke languages')">
        <xsl:attribute name="langcode">bai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bashkir')">
        <xsl:attribute name="langcode">bak</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Baluchi')">
        <xsl:attribute name="langcode">bal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bambara')">
        <xsl:attribute name="langcode">bam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Balinese')">
        <xsl:attribute name="langcode">ban</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Basque')">
        <xsl:attribute name="langcode">baq</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Basa')">
        <xsl:attribute name="langcode">bas</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Baltic languages')">
        <xsl:attribute name="langcode">bat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Beja; Bedawiyet')">
        <xsl:attribute name="langcode">bej</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Belarusian')">
        <xsl:attribute name="langcode">bel</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bemba')">
        <xsl:attribute name="langcode">bem</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bengali')">
        <xsl:attribute name="langcode">ben</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Berber languages')">
        <xsl:attribute name="langcode">ber</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bhojpuri')">
        <xsl:attribute name="langcode">bho</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bihari languages')">
        <xsl:attribute name="langcode">bih</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bikol')">
        <xsl:attribute name="langcode">bik</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bini; Edo')">
        <xsl:attribute name="langcode">bin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bislama')">
        <xsl:attribute name="langcode">bis</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Siksika')">
        <xsl:attribute name="langcode">bla</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bantu (Other)')">
        <xsl:attribute name="langcode">bnt</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bosnian')">
        <xsl:attribute name="langcode">bos</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Braj')">
        <xsl:attribute name="langcode">bra</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Breton')">
        <xsl:attribute name="langcode">bre</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Batak languages')">
        <xsl:attribute name="langcode">btk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Buriat')">
        <xsl:attribute name="langcode">bua</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Buginese')">
        <xsl:attribute name="langcode">bug</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bulgarian')">
        <xsl:attribute name="langcode">bul</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Burmese')">
        <xsl:attribute name="langcode">bur</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Blin; Bilin')">
        <xsl:attribute name="langcode">byn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Caddo')">
        <xsl:attribute name="langcode">cad</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Central American Indian languages')">
        <xsl:attribute name="langcode">cai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Galibi Carib')">
        <xsl:attribute name="langcode">car</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Catalan; Valencian')">
        <xsl:attribute name="langcode">cat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Caucasian languages')">
        <xsl:attribute name="langcode">cau</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cebuano')">
        <xsl:attribute name="langcode">ceb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Celtic languages')">
        <xsl:attribute name="langcode">cel</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chamorro')">
        <xsl:attribute name="langcode">cha</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chibcha')">
        <xsl:attribute name="langcode">chb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chechen')">
        <xsl:attribute name="langcode">che</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chagatai')">
        <xsl:attribute name="langcode">chg</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chinese')">
        <xsl:attribute name="langcode">chi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chuukese')">
        <xsl:attribute name="langcode">chk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mari')">
        <xsl:attribute name="langcode">chm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chinook jargon')">
        <xsl:attribute name="langcode">chn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Choctaw')">
        <xsl:attribute name="langcode">cho</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chipewyan; Dene Suline')">
        <xsl:attribute name="langcode">chp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cherokee')">
        <xsl:attribute name="langcode">chr</xsl:attribute>
      </xsl:when>
      <xsl:when
        test="contains(.,'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic')">
        <xsl:attribute name="langcode">chu</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chuvash')">
        <xsl:attribute name="langcode">chv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cheyenne')">
        <xsl:attribute name="langcode">chy</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chamic languages')">
        <xsl:attribute name="langcode">cmc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Coptic')">
        <xsl:attribute name="langcode">cop</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cornish')">
        <xsl:attribute name="langcode">cor</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Corsican')">
        <xsl:attribute name="langcode">cos</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Creoles and pidgins, English based')">
        <xsl:attribute name="langcode">cpe</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Creoles and pidgins, French-based')">
        <xsl:attribute name="langcode">cpf</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Creoles and pidgins, Portuguese-based')">
        <xsl:attribute name="langcode">cpp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cree')">
        <xsl:attribute name="langcode">cre</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Crimean Tatar; Crimean Turkish')">
        <xsl:attribute name="langcode">crh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Creoles and pidgins')">
        <xsl:attribute name="langcode">crp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kashubian')">
        <xsl:attribute name="langcode">csb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Cushitic languages')">
        <xsl:attribute name="langcode">cus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Czech')">
        <xsl:attribute name="langcode">cze</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dakota')">
        <xsl:attribute name="langcode">dak</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Danish')">
        <xsl:attribute name="langcode">dan</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dargwa')">
        <xsl:attribute name="langcode">dar</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Land Dayak languages')">
        <xsl:attribute name="langcode">day</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Delaware')">
        <xsl:attribute name="langcode">del</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Slave (Athapascan)')">
        <xsl:attribute name="langcode">den</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dogrib')">
        <xsl:attribute name="langcode">dgr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dinka')">
        <xsl:attribute name="langcode">din</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Divehi; Dhivehi; Maldivian')">
        <xsl:attribute name="langcode">div</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dogri')">
        <xsl:attribute name="langcode">doi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dravidian languages')">
        <xsl:attribute name="langcode">dra</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lower Sorbian')">
        <xsl:attribute name="langcode">dsb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Duala')">
        <xsl:attribute name="langcode">dua</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dutch, Middle (ca.1050-1350)')">
        <xsl:attribute name="langcode">dum</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dutch; Flemish')">
        <xsl:attribute name="langcode">dut</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dyula')">
        <xsl:attribute name="langcode">dyu</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Dzongkha')">
        <xsl:attribute name="langcode">dzo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Efik')">
        <xsl:attribute name="langcode">efi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Egyptian (Ancient)')">
        <xsl:attribute name="langcode">egy</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ekajuk')">
        <xsl:attribute name="langcode">eka</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Elamite')">
        <xsl:attribute name="langcode">elx</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'English, Middle (1100-1500)')">
        <xsl:attribute name="langcode">enm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Esperanto')">
        <xsl:attribute name="langcode">epo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Estonian')">
        <xsl:attribute name="langcode">est</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ewe')">
        <xsl:attribute name="langcode">ewe</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ewondo')">
        <xsl:attribute name="langcode">ewo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Fang')">
        <xsl:attribute name="langcode">fan</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Faroese')">
        <xsl:attribute name="langcode">fao</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Fanti')">
        <xsl:attribute name="langcode">fat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Fijian')">
        <xsl:attribute name="langcode">fij</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Filipino; Pilipino')">
        <xsl:attribute name="langcode">fil</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Finnish')">
        <xsl:attribute name="langcode">fin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Finno-Ugrian languages')">
        <xsl:attribute name="langcode">fiu</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Fon')">
        <xsl:attribute name="langcode">fon</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'French')">
        <xsl:attribute name="langcode">fre</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'French, Middle (ca.1400-1600)')">
        <xsl:attribute name="langcode">frm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'French, Old (842-ca.1400)')">
        <xsl:attribute name="langcode">fro</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Northern Frisian')">
        <xsl:attribute name="langcode">frr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Eastern Frisian')">
        <xsl:attribute name="langcode">frs</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Western Frisian')">
        <xsl:attribute name="langcode">fry</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Fulah')">
        <xsl:attribute name="langcode">ful</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Friulian')">
        <xsl:attribute name="langcode">fur</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ga')">
        <xsl:attribute name="langcode">gaa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gayo')">
        <xsl:attribute name="langcode">gay</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gbaya')">
        <xsl:attribute name="langcode">gba</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Germanic languages')">
        <xsl:attribute name="langcode">gem</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Georgian')">
        <xsl:attribute name="langcode">geo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Geez')">
        <xsl:attribute name="langcode">gez</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gilbertese')">
        <xsl:attribute name="langcode">gil</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gaelic; Scottish Gaelic')">
        <xsl:attribute name="langcode">gla</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Irish')">
        <xsl:attribute name="langcode">gle</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Galician')">
        <xsl:attribute name="langcode">glg</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Manx')">
        <xsl:attribute name="langcode">glv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'German, Middle High (ca.1050-1500)')">
        <xsl:attribute name="langcode">gmh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'German, Old High (ca.750-1050)')">
        <xsl:attribute name="langcode">goh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gondi')">
        <xsl:attribute name="langcode">gon</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gorontalo')">
        <xsl:attribute name="langcode">gor</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gothic')">
        <xsl:attribute name="langcode">got</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Grebo')">
        <xsl:attribute name="langcode">grb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Greek, Ancient (to 1453)')">
        <xsl:attribute name="langcode">grc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Greek, Modern (1453-)')">
        <xsl:attribute name="langcode">gre</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Guarani')">
        <xsl:attribute name="langcode">grn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Swiss German; Alemannic; Alsatian')">
        <xsl:attribute name="langcode">gsw</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gujarati')">
        <xsl:attribute name="langcode">guj</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Gwich&quot;in')">
        <xsl:attribute name="langcode">gwi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Haida')">
        <xsl:attribute name="langcode">hai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Haitian; Haitian Creole')">
        <xsl:attribute name="langcode">hat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hausa')">
        <xsl:attribute name="langcode">hau</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hawaiian')">
        <xsl:attribute name="langcode">haw</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hebrew')">
        <xsl:attribute name="langcode">heb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Herero')">
        <xsl:attribute name="langcode">her</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hiligaynon')">
        <xsl:attribute name="langcode">hil</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Himachali languages; Western Pahari languages')">
        <xsl:attribute name="langcode">him</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hindi')">
        <xsl:attribute name="langcode">hin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hittite')">
        <xsl:attribute name="langcode">hit</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hmong; Mong')">
        <xsl:attribute name="langcode">hmn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hiri Motu')">
        <xsl:attribute name="langcode">hmo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Croatian')">
        <xsl:attribute name="langcode">hrv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Upper Sorbian')">
        <xsl:attribute name="langcode">hsb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hungarian')">
        <xsl:attribute name="langcode">hun</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Hupa')">
        <xsl:attribute name="langcode">hup</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Iban')">
        <xsl:attribute name="langcode">iba</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Igbo')">
        <xsl:attribute name="langcode">ibo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Icelandic')">
        <xsl:attribute name="langcode">ice</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ido')">
        <xsl:attribute name="langcode">ido</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sichuan Yi; Nuosu')">
        <xsl:attribute name="langcode">iii</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ijo languages')">
        <xsl:attribute name="langcode">ijo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Inuktitut')">
        <xsl:attribute name="langcode">iku</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Interlingue; Occidental')">
        <xsl:attribute name="langcode">ile</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Iloko')">
        <xsl:attribute name="langcode">ilo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Interlingua (International Auxiliary Language Association)')">
        <xsl:attribute name="langcode">ina</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Indic languages')">
        <xsl:attribute name="langcode">inc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Indonesian')">
        <xsl:attribute name="langcode">ind</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Indo-European languages')">
        <xsl:attribute name="langcode">ine</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ingush')">
        <xsl:attribute name="langcode">inh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Inupiaq')">
        <xsl:attribute name="langcode">ipk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Iranian languages')">
        <xsl:attribute name="langcode">ira</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Iroquoian languages')">
        <xsl:attribute name="langcode">iro</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Italian')">
        <xsl:attribute name="langcode">ita</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Javanese')">
        <xsl:attribute name="langcode">jav</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lojban')">
        <xsl:attribute name="langcode">jbo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Japanese')">
        <xsl:attribute name="langcode">jpn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Judeo-Persian')">
        <xsl:attribute name="langcode">jpr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Judeo-Arabic')">
        <xsl:attribute name="langcode">jrb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kara-Kalpak')">
        <xsl:attribute name="langcode">kaa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kabyle')">
        <xsl:attribute name="langcode">kab</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kachin; Jingpho')">
        <xsl:attribute name="langcode">kac</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kalaallisut; Greenlandic')">
        <xsl:attribute name="langcode">kal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kamba')">
        <xsl:attribute name="langcode">kam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kannada')">
        <xsl:attribute name="langcode">kan</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Karen languages')">
        <xsl:attribute name="langcode">kar</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kashmiri')">
        <xsl:attribute name="langcode">kas</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kanuri')">
        <xsl:attribute name="langcode">kau</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kawi')">
        <xsl:attribute name="langcode">kaw</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kazakh')">
        <xsl:attribute name="langcode">kaz</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kabardian')">
        <xsl:attribute name="langcode">kbd</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Khasi')">
        <xsl:attribute name="langcode">kha</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Khoisan languages')">
        <xsl:attribute name="langcode">khi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Central Khmer')">
        <xsl:attribute name="langcode">khm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Khotanese; Sakan')">
        <xsl:attribute name="langcode">kho</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kikuyu; Gikuyu')">
        <xsl:attribute name="langcode">kik</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kinyarwanda')">
        <xsl:attribute name="langcode">kin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kirghiz; Kyrgyz')">
        <xsl:attribute name="langcode">kir</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kimbundu')">
        <xsl:attribute name="langcode">kmb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Konkani')">
        <xsl:attribute name="langcode">kok</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Komi')">
        <xsl:attribute name="langcode">kom</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kongo')">
        <xsl:attribute name="langcode">kon</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Korean')">
        <xsl:attribute name="langcode">kor</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kosraean')">
        <xsl:attribute name="langcode">kos</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kpelle')">
        <xsl:attribute name="langcode">kpe</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Karachay-Balkar')">
        <xsl:attribute name="langcode">krc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Karelian')">
        <xsl:attribute name="langcode">krl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kru languages')">
        <xsl:attribute name="langcode">kro</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kurukh')">
        <xsl:attribute name="langcode">kru</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kuanyama; Kwanyama')">
        <xsl:attribute name="langcode">kua</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kumyk')">
        <xsl:attribute name="langcode">kum</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kurdish')">
        <xsl:attribute name="langcode">kur</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kutenai')">
        <xsl:attribute name="langcode">kut</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ladino')">
        <xsl:attribute name="langcode">lad</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lahnda')">
        <xsl:attribute name="langcode">lah</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lamba')">
        <xsl:attribute name="langcode">lam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lao')">
        <xsl:attribute name="langcode">lao</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Latin')">
        <xsl:attribute name="langcode">lat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Latvian')">
        <xsl:attribute name="langcode">lav</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lezghian')">
        <xsl:attribute name="langcode">lez</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Limburgan; Limburger; Limburgish')">
        <xsl:attribute name="langcode">lim</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lingala')">
        <xsl:attribute name="langcode">lin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lithuanian')">
        <xsl:attribute name="langcode">lit</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mongo')">
        <xsl:attribute name="langcode">lol</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lozi')">
        <xsl:attribute name="langcode">loz</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Luxembourgish; Letzeburgesch')">
        <xsl:attribute name="langcode">ltz</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Luba-Lulua')">
        <xsl:attribute name="langcode">lua</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Luba-Katanga')">
        <xsl:attribute name="langcode">lub</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ganda')">
        <xsl:attribute name="langcode">lug</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Luiseno')">
        <xsl:attribute name="langcode">lui</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lunda')">
        <xsl:attribute name="langcode">lun</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Luo (Kenya and Tanzania)')">
        <xsl:attribute name="langcode">luo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lushai')">
        <xsl:attribute name="langcode">lus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Macedonian')">
        <xsl:attribute name="langcode">mac</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Madurese')">
        <xsl:attribute name="langcode">mad</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Magahi')">
        <xsl:attribute name="langcode">mag</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Marshallese')">
        <xsl:attribute name="langcode">mah</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Maithili')">
        <xsl:attribute name="langcode">mai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Makasar')">
        <xsl:attribute name="langcode">mak</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Malayalam')">
        <xsl:attribute name="langcode">mal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mandingo')">
        <xsl:attribute name="langcode">man</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Maori')">
        <xsl:attribute name="langcode">mao</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Austronesian languages')">
        <xsl:attribute name="langcode">map</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Marathi')">
        <xsl:attribute name="langcode">mar</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Masai')">
        <xsl:attribute name="langcode">mas</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Malay')">
        <xsl:attribute name="langcode">may</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Moksha')">
        <xsl:attribute name="langcode">mdf</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mandar')">
        <xsl:attribute name="langcode">mdr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mende')">
        <xsl:attribute name="langcode">men</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Irish, Middle (900-1200)')">
        <xsl:attribute name="langcode">mga</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mi&quot;kmaq; Micmac')">
        <xsl:attribute name="langcode">mic</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Minangkabau')">
        <xsl:attribute name="langcode">min</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Uncoded languages')">
        <xsl:attribute name="langcode">mis</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mon-Khmer languages')">
        <xsl:attribute name="langcode">mkh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Malagasy')">
        <xsl:attribute name="langcode">mlg</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Maltese')">
        <xsl:attribute name="langcode">mlt</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Manchu')">
        <xsl:attribute name="langcode">mnc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Manipuri')">
        <xsl:attribute name="langcode">mni</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Manobo languages')">
        <xsl:attribute name="langcode">mno</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mohawk')">
        <xsl:attribute name="langcode">moh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mongolian')">
        <xsl:attribute name="langcode">mon</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mossi')">
        <xsl:attribute name="langcode">mos</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Multiple languages')">
        <xsl:attribute name="langcode">mul</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Munda languages')">
        <xsl:attribute name="langcode">mun</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Creek')">
        <xsl:attribute name="langcode">mus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mirandese')">
        <xsl:attribute name="langcode">mwl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Marwari')">
        <xsl:attribute name="langcode">mwr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Mayan languages')">
        <xsl:attribute name="langcode">myn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Erzya')">
        <xsl:attribute name="langcode">myv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nahuatl languages')">
        <xsl:attribute name="langcode">nah</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'North American Indian languages')">
        <xsl:attribute name="langcode">nai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Neapolitan')">
        <xsl:attribute name="langcode">nap</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nauru')">
        <xsl:attribute name="langcode">nau</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Navajo; Navaho')">
        <xsl:attribute name="langcode">nav</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ndebele, South; South Ndebele')">
        <xsl:attribute name="langcode">nbl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ndebele, North; North Ndebele')">
        <xsl:attribute name="langcode">nde</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ndonga')">
        <xsl:attribute name="langcode">ndo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Low German; Low Saxon; German, Low; Saxon, Low')">
        <xsl:attribute name="langcode">nds</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nepali')">
        <xsl:attribute name="langcode">nep</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nepal Bhasa; Newari')">
        <xsl:attribute name="langcode">new</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nias')">
        <xsl:attribute name="langcode">nia</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Niger-Kordofanian languages')">
        <xsl:attribute name="langcode">nic</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Niuean')">
        <xsl:attribute name="langcode">niu</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Norwegian Nynorsk; Nynorsk, Norwegian')">
        <xsl:attribute name="langcode">nno</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Bokmål, Norwegian; Norwegian Bokmål')">
        <xsl:attribute name="langcode">nob</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nogai')">
        <xsl:attribute name="langcode">nog</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Norse, Old')">
        <xsl:attribute name="langcode">non</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Norwegian')">
        <xsl:attribute name="langcode">nor</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'N&quot;Ko')">
        <xsl:attribute name="langcode">nqo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pedi; Sepedi; Northern Sotho')">
        <xsl:attribute name="langcode">nso</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nubian languages')">
        <xsl:attribute name="langcode">nub</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Classical Newari; Old Newari; Classical Nepal Bhasa')">
        <xsl:attribute name="langcode">nwc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Chichewa; Chewa; Nyanja')">
        <xsl:attribute name="langcode">nya</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nyamwezi')">
        <xsl:attribute name="langcode">nym</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nyankole')">
        <xsl:attribute name="langcode">nyn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nyoro')">
        <xsl:attribute name="langcode">nyo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nzima')">
        <xsl:attribute name="langcode">nzi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Occitan (post 1500); Provençal')">
        <xsl:attribute name="langcode">oci</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ojibwa')">
        <xsl:attribute name="langcode">oji</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Oriya')">
        <xsl:attribute name="langcode">ori</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Oromo')">
        <xsl:attribute name="langcode">orm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Osage')">
        <xsl:attribute name="langcode">osa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ossetian; Ossetic')">
        <xsl:attribute name="langcode">oss</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Turkish, Ottoman (1500-1928)')">
        <xsl:attribute name="langcode">ota</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Otomian languages')">
        <xsl:attribute name="langcode">oto</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Papuan languages')">
        <xsl:attribute name="langcode">paa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pangasinan')">
        <xsl:attribute name="langcode">pag</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pahlavi')">
        <xsl:attribute name="langcode">pal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pampanga; Kapampangan')">
        <xsl:attribute name="langcode">pam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Panjabi; Punjabi')">
        <xsl:attribute name="langcode">pan</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Papiamento')">
        <xsl:attribute name="langcode">pap</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Palauan')">
        <xsl:attribute name="langcode">pau</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Persian, Old (ca.600-400 B.C.)')">
        <xsl:attribute name="langcode">peo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Persian')">
        <xsl:attribute name="langcode">per</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Philippine languages')">
        <xsl:attribute name="langcode">phi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Phoenician')">
        <xsl:attribute name="langcode">phn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pali')">
        <xsl:attribute name="langcode">pli</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Polish')">
        <xsl:attribute name="langcode">pol</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pohnpeian')">
        <xsl:attribute name="langcode">pon</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Portuguese')">
        <xsl:attribute name="langcode">por</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Prakrit languages')">
        <xsl:attribute name="langcode">pra</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Provençal, Old (to 1500)')">
        <xsl:attribute name="langcode">pro</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Pushto; Pashto')">
        <xsl:attribute name="langcode">pus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Reserved for local use')">
        <xsl:attribute name="langcode">qaa-qtz</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Quechua')">
        <xsl:attribute name="langcode">que</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Rajasthani')">
        <xsl:attribute name="langcode">raj</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Rapanui')">
        <xsl:attribute name="langcode">rap</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Rarotongan; Cook Islands Maori')">
        <xsl:attribute name="langcode">rar</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Romance languages')">
        <xsl:attribute name="langcode">roa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Romansh')">
        <xsl:attribute name="langcode">roh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Romany')">
        <xsl:attribute name="langcode">rom</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Romanian; Moldavian; Moldovan')">
        <xsl:attribute name="langcode">rum</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Rundi')">
        <xsl:attribute name="langcode">run</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Aromanian; Arumanian; Macedo-Romanian')">
        <xsl:attribute name="langcode">rup</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Russian')">
        <xsl:attribute name="langcode">rus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sandawe')">
        <xsl:attribute name="langcode">sad</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sango')">
        <xsl:attribute name="langcode">sag</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yakut')">
        <xsl:attribute name="langcode">sah</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'South American Indian (Other)')">
        <xsl:attribute name="langcode">sai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Salishan languages')">
        <xsl:attribute name="langcode">sal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Samaritan Aramaic')">
        <xsl:attribute name="langcode">sam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sanskrit')">
        <xsl:attribute name="langcode">san</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sasak')">
        <xsl:attribute name="langcode">sas</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Santali')">
        <xsl:attribute name="langcode">sat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sicilian')">
        <xsl:attribute name="langcode">scn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Scots')">
        <xsl:attribute name="langcode">sco</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Selkup')">
        <xsl:attribute name="langcode">sel</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Semitic languages')">
        <xsl:attribute name="langcode">sem</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Irish, Old (to 900)')">
        <xsl:attribute name="langcode">sga</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sign Languages')">
        <xsl:attribute name="langcode">sgn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Shan')">
        <xsl:attribute name="langcode">shn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sidamo')">
        <xsl:attribute name="langcode">sid</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sinhala; Sinhalese')">
        <xsl:attribute name="langcode">sin</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Siouan languages')">
        <xsl:attribute name="langcode">sio</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sino-Tibetan languages')">
        <xsl:attribute name="langcode">sit</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Slavic languages')">
        <xsl:attribute name="langcode">sla</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Slovak')">
        <xsl:attribute name="langcode">slo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Slovenian')">
        <xsl:attribute name="langcode">slv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Southern Sami')">
        <xsl:attribute name="langcode">sma</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Northern Sami')">
        <xsl:attribute name="langcode">sme</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sami languages')">
        <xsl:attribute name="langcode">smi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Lule Sami')">
        <xsl:attribute name="langcode">smj</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Inari Sami')">
        <xsl:attribute name="langcode">smn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Samoan')">
        <xsl:attribute name="langcode">smo</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Skolt Sami')">
        <xsl:attribute name="langcode">sms</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Shona')">
        <xsl:attribute name="langcode">sna</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sindhi')">
        <xsl:attribute name="langcode">snd</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Soninke')">
        <xsl:attribute name="langcode">snk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sogdian')">
        <xsl:attribute name="langcode">sog</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Somali')">
        <xsl:attribute name="langcode">som</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Songhai languages')">
        <xsl:attribute name="langcode">son</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sotho, Southern')">
        <xsl:attribute name="langcode">sot</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Spanish; Castilian')">
        <xsl:attribute name="langcode">spa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sardinian')">
        <xsl:attribute name="langcode">srd</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sranan Tongo')">
        <xsl:attribute name="langcode">srn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Serbian')">
        <xsl:attribute name="langcode">srp</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Serer')">
        <xsl:attribute name="langcode">srr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Nilo-Saharan languages')">
        <xsl:attribute name="langcode">ssa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Swati')">
        <xsl:attribute name="langcode">ssw</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sukuma')">
        <xsl:attribute name="langcode">suk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sundanese')">
        <xsl:attribute name="langcode">sun</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Susu')">
        <xsl:attribute name="langcode">sus</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sumerian')">
        <xsl:attribute name="langcode">sux</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Swahili')">
        <xsl:attribute name="langcode">swa</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Swedish')">
        <xsl:attribute name="langcode">swe</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Classical Syriac')">
        <xsl:attribute name="langcode">syc</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Syriac')">
        <xsl:attribute name="langcode">syr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tahitian')">
        <xsl:attribute name="langcode">tah</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tai languages')">
        <xsl:attribute name="langcode">tai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tamil')">
        <xsl:attribute name="langcode">tam</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tatar')">
        <xsl:attribute name="langcode">tat</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Telugu')">
        <xsl:attribute name="langcode">tel</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Timne')">
        <xsl:attribute name="langcode">tem</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tereno')">
        <xsl:attribute name="langcode">ter</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tetum')">
        <xsl:attribute name="langcode">tet</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tajik')">
        <xsl:attribute name="langcode">tgk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tagalog')">
        <xsl:attribute name="langcode">tgl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Thai')">
        <xsl:attribute name="langcode">tha</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tibetan')">
        <xsl:attribute name="langcode">tib</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tigre')">
        <xsl:attribute name="langcode">tig</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tigrinya')">
        <xsl:attribute name="langcode">tir</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tiv')">
        <xsl:attribute name="langcode">tiv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tokelau')">
        <xsl:attribute name="langcode">tkl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Klingon; tlhIngan-Hol')">
        <xsl:attribute name="langcode">tlh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tlingit')">
        <xsl:attribute name="langcode">tli</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tamashek')">
        <xsl:attribute name="langcode">tmh</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tonga (Nyasa)')">
        <xsl:attribute name="langcode">tog</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tonga (Tonga Islands)')">
        <xsl:attribute name="langcode">ton</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tok Pisin')">
        <xsl:attribute name="langcode">tpi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tsimshian')">
        <xsl:attribute name="langcode">tsi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tswana')">
        <xsl:attribute name="langcode">tsn</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tsonga')">
        <xsl:attribute name="langcode">tso</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Turkmen')">
        <xsl:attribute name="langcode">tuk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tumbuka')">
        <xsl:attribute name="langcode">tum</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tupi languages')">
        <xsl:attribute name="langcode">tup</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Turkish')">
        <xsl:attribute name="langcode">tur</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Altaic languages')">
        <xsl:attribute name="langcode">tut</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tuvalu')">
        <xsl:attribute name="langcode">tvl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Twi')">
        <xsl:attribute name="langcode">twi</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Tuvinian')">
        <xsl:attribute name="langcode">tyv</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Udmurt')">
        <xsl:attribute name="langcode">udm</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ugaritic')">
        <xsl:attribute name="langcode">uga</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Uighur; Uyghur')">
        <xsl:attribute name="langcode">uig</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Ukrainian')">
        <xsl:attribute name="langcode">ukr</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Umbundu')">
        <xsl:attribute name="langcode">umb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Undetermined')">
        <xsl:attribute name="langcode">und</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Urdu')">
        <xsl:attribute name="langcode">urd</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Uzbek')">
        <xsl:attribute name="langcode">uzb</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Vai')">
        <xsl:attribute name="langcode">vai</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Venda')">
        <xsl:attribute name="langcode">ven</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Vietnamese')">
        <xsl:attribute name="langcode">vie</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Volapük')">
        <xsl:attribute name="langcode">vol</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Votic')">
        <xsl:attribute name="langcode">vot</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Wakashan languages')">
        <xsl:attribute name="langcode">wak</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Walamo')">
        <xsl:attribute name="langcode">wal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Waray')">
        <xsl:attribute name="langcode">war</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Washo')">
        <xsl:attribute name="langcode">was</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Welsh')">
        <xsl:attribute name="langcode">wel</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Sorbian languages')">
        <xsl:attribute name="langcode">wen</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Walloon')">
        <xsl:attribute name="langcode">wln</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Wolof')">
        <xsl:attribute name="langcode">wol</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Kalmyk; Oirat')">
        <xsl:attribute name="langcode">xal</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Xhosa')">
        <xsl:attribute name="langcode">xho</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yao')">
        <xsl:attribute name="langcode">yao</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yapese')">
        <xsl:attribute name="langcode">yap</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yiddish')">
        <xsl:attribute name="langcode">yid</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yoruba')">
        <xsl:attribute name="langcode">yor</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Yupik languages')">
        <xsl:attribute name="langcode">ypk</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zapotec')">
        <xsl:attribute name="langcode">zap</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Blissymbols; Blissymbolics; Bliss')">
        <xsl:attribute name="langcode">zbl</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zenaga')">
        <xsl:attribute name="langcode">zen</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zhuang; Chuang')">
        <xsl:attribute name="langcode">zha</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zande languages')">
        <xsl:attribute name="langcode">znd</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zulu')">
        <xsl:attribute name="langcode">zul</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zuni')">
        <xsl:attribute name="langcode">zun</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'No linguistic content; Not applicable')">
        <xsl:attribute name="langcode">zxx</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki')">
        <xsl:attribute name="langcode">zza</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'English')">
        <xsl:attribute name="langcode">eng</xsl:attribute>
      </xsl:when>
      <xsl:when test="contains(.,'German')">
        <xsl:attribute name="langcode">ger</xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
