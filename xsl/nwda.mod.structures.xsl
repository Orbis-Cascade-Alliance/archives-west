<?xml version="1.0" encoding="UTF-8"?>
<!--
Original encoding by
Stephen Yearl
stephen.yearl@yale.edu
2003-04-25/
version 0.0.1
Revisions and enhancements by
Mark Carlson
2004-06, 2004-10, 2004-11, 2004-12
Revised by Tamara Marnell 2021-04 to uncollapse Administrative Information by default
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:res="http://www.w3.org/2005/sparql-results#" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#"
	xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="nwda xsd vcard xsl msxsl exsl ead foaf dcterms">

	<xsl:template match="profiledesc | revisiondesc | filedesc | eadheader | frontmatter"/>

	<!-- ********************* <FOOTER> *********************** -->

	<xsl:template match="publicationstmt">
		<p class="author">
			<xsl:value-of select="//ead/eadheader/filedesc/titlestmt/author"/>
			<br/>
			<!-- revision 2017: remove copyright symbol -->
			<xsl:value-of select="translate(./date,'&#169;','')"/>
		</p>	
			<!-- revisions 2017: display rights statement -->
			<xsl:choose> <!-- if rights statement or copyright exists in finding aid, override the institution-wide rights statement -->
				<xsl:when test="//ead/eadheader/filedesc/publicationstmt/p[@id='copyright'] | //ead/eadheader/filedesc/publicationstmt/p[@id='rightsstatement']">
					
					<xsl:if test="//ead/eadheader/filedesc/publicationstmt/p[@id='rightsstatement']">
						<p>
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="//ead/eadheader/filedesc/publicationstmt/p[@id='rightsstatement']/extref/@href"/>								
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="//ead/eadheader/filedesc/publicationstmt/p[@id='rightsstatement']/extref/extptr/@title"/>
							</xsl:attribute>
							<xsl:value-of select="//ead/eadheader/filedesc/publicationstmt/p[@id='rightsstatement']/extref/@href"/>
						</xsl:element>
							<p><xsl:value-of select="p[@id='rightsstatement']"/></p>
						</p>
					</xsl:if>
					
					<xsl:if test="//ead/eadheader/filedesc/publicationstmt/p[@id='copyright']">
						<p>
							<xsl:value-of select="$copyright_label"/>
						</p>
						<p>
						<xsl:value-of select="//ead/eadheader/filedesc/publicationstmt/p[@id='copyright']/text()"/>
						</p>
					</xsl:if>
				</xsl:when>
        <xsl:otherwise> <!-- if local rights statement doesn't exist, show institution-wide rights statement -->
          <xsl:apply-templates select="//ead/aw-additions/rights" />
        </xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	<!-- ********************* <END FOOTER> *********************** -->
	<!-- ********************* <OVERVIEW> *********************** -->
	
	<xsl:template match="archdesc" mode="flag">
    <h1 id="top">
      <xsl:value-of select="$titleproper"/>
    </h1>
    <div id="toc" role="complementary">
      <xsl:call-template name="toc"/>
    </div>
    <div id="main">
      <div class="archdesc" id="docBody">
        <xsl:call-template name="collection_overview"/>
        <xsl:apply-templates select="bioghist | scopecontent | odd"/>
        <xsl:call-template name="useinfo"/>
        <xsl:call-template name="administrative_info"/>
        <xsl:apply-templates select="dsc"/>
        <xsl:apply-templates select="controlaccess"/>
      </div>
      <div class="footer">
        <xsl:apply-templates select="//ead/eadheader/filedesc/publicationstmt"/>
      </div>
    </div>
	</xsl:template>

	<!-- ********************* COLLECTION OVERVIEW *********************** -->
	<xsl:template name="collection_overview">
		<h2 id="overview">
			<xsl:value-of select="$overview_head"/>
      <button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-overview" aria-controls="overview-content" aria-expanded="true">
        <xsl:attribute name="title">
          <xsl:text>Close </xsl:text>
          <xsl:value-of select="$overview_head"/>
        </xsl:attribute>
      </button>
		</h2>
		<div class="overview" id="overview-content">
			<dl class="dl-horizontal">
				<!--origination-->
				<xsl:if test="string(did/origination)">
					<dt>
						<xsl:choose>
							<xsl:when test="did/origination/*/@role">
								<xsl:variable name="orig1" select="substring(did/origination/*/@role, 1, 1)"/>
								<xsl:value-of select="translate($orig1, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
								<xsl:value-of select="substring(did/origination/*/@role, 2)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$origination_label"/>
							</xsl:otherwise>
						</xsl:choose>
					</dt>
					<dd property="dcterms:creator">
						<xsl:call-template name="join">
						  <xsl:with-param name="valueList" select="did/origination/*"/>
						  <xsl:with-param name="separator" select="'; '"/>
						</xsl:call-template>
					</dd>
				</xsl:if>
				<!--collection title-->
				<xsl:if test="did/unittitle">
					<dt>
						<xsl:value-of select="$unittitle_label"/>
					</dt>
					<dd property="dcterms:title">
						<xsl:apply-templates select="did/unittitle" mode="highlights" />
					</dd>
				</xsl:if>
				<!--collection dates-->
				<xsl:if test="did/unitdate">
					<dt>
						<xsl:value-of select="$dates_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="did/unitdate" mode="archdesc"/>
					</dd>
				</xsl:if>
				<!--collection physdesc-->
				<xsl:if test="did/physdesc">
					<dt>
						<xsl:value-of select="$physdesc_label"/>
					</dt>
					<dd>
						<xsl:for-each select="did/physdesc">
							<xsl:apply-templates select="extent"/>
							<!-- multiple extents contained in parantheses -->
							<xsl:if test="string(physfacet) and string(extent)"> &#160;:&#160; </xsl:if>
							<xsl:apply-templates select="physfacet"/>
							<xsl:if test="string(dimensions) and string(physfacet)"> &#160;;&#160; </xsl:if>
							<xsl:apply-templates select="dimensions"/>
							<xsl:if test="not(position()=last())">
								<br/>
							</xsl:if>
						</xsl:for-each>
					</dd>
				</xsl:if>
				<!--collection #-->
				<xsl:if test="did/unitid">
					<dt>
						<xsl:value-of select="$collectionNumber_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="did/unitid" mode="archdesc"/>
					</dd>
				</xsl:if>
				<!--collection abstract/summary-->
				<xsl:if test="did/abstract">
					<dt>
						<xsl:value-of select="$abstract_label"/>
					</dt>
					<dd property="dcterms:abstract">
						<xsl:apply-templates select="did/abstract"/>
					</dd>
				</xsl:if>
				
				<!--contact information-->
				<xsl:choose>
					<xsl:when test="../aw-additions">
						<dt>
							<xsl:value-of select="$contactinformation_label"/>
						</dt>
						<dd>
							<xsl:apply-templates select="../aw-additions/repository" />
						</dd>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="did/repository">
							<dt>
								<xsl:value-of select="$contactinformation_label"/>
							</dt>
							<dd>
								<xsl:for-each select="did/repository">
									<xsl:variable name="selfRepos">
										<xsl:value-of select="normalize-space(text())"/>
									</xsl:variable>
									<xsl:if test="string-length($selfRepos)&gt;0">
										<span property="arch:heldBy">
											<xsl:value-of select="$selfRepos"/>
										</span>
										<br/>
									</xsl:if>
									<xsl:if test="string(corpname)">
										<xsl:for-each select="corpname">
											<xsl:if test="string-length(.)&gt;string-length(subarea)">
												<span property="arch:heldBy">
													<xsl:apply-templates select="text()|*[not(self::subarea)]"/>
												</span>
												<br/>
											</xsl:if>
										</xsl:for-each>
										<xsl:if test="string(corpname/subarea)">
											<xsl:for-each select="corpname/subarea">
												<xsl:apply-templates/>
												<br/>
											</xsl:for-each>
										</xsl:if>
									</xsl:if>
									<xsl:if test="string(subarea)">
										<xsl:apply-templates select="subarea"/>
										<br/>
									</xsl:if>
									<xsl:if test="string(address)">
										<xsl:apply-templates select="address"/>
									</xsl:if>
								</xsl:for-each>
							</dd>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

				<!-- inserted accessrestrict as per March 2015 revision specifications -->
				<xsl:if test="accessrestrict">
					<dt>
						<xsl:value-of select="$accessrestrict_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="accessrestrict"/>						
					</dd>
				</xsl:if>

				<!-- inserted accessrestrict as per March 2015 revision specifications -->
				<xsl:if test="otherfindaid">
					<dt>
						<xsl:value-of select="$otherfindaid_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="otherfindaid"/>						
					</dd>
				</xsl:if>

				<!--finding aid creation information-->
				<xsl:if test="//ead/eadheader/profiledesc/creation and $showCreation='true'">
					<dt>
						<xsl:value-of select="$creation_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="//ead/eadheader/profiledesc/creation"/>
					</dd>
				</xsl:if>

				<!--finding aid revision information-->
				<xsl:if test="//ead/eadheader/profiledesc/creation and $showRevision='true'">
					<dt>
						<xsl:value-of select="$revision_label"/>
					</dt>
					<dd>
						<xsl:apply-templates select="//ead/eadheader/revisiondesc/change"/>
					</dd>
				</xsl:if>

				<!--language note-->
				<xsl:if test="did/langmaterial">
					<dt>
						<xsl:value-of select="$langmaterial_label"/>
					</dt>
					<dd>
						<xsl:choose>
							<xsl:when test="not(did/langmaterial/language)">
								<span property="dcterms:language">
									<xsl:apply-templates select="did/langmaterial"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="did/langmaterial/language">
									<span property="dcterms:language">
										<xsl:apply-templates select="."/>
									</span>
									<xsl:if test="not(position()=last())">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</dd>
				</xsl:if>
						
				<!--sponsor; March 2017, moved back to Overview Section (Mark Carlson) -->
				<xsl:if test="//ead/eadheader/filedesc/titlestmt/sponsor">
          <dt>
            <xsl:value-of select="$sponsor_label"/>
          </dt>
          <dd>
            <xsl:apply-templates select="//ead/eadheader/filedesc/titlestmt/sponsor"/>
          </dd>
        </xsl:if>
			</dl>
		</div>
	</xsl:template>

	<!-- ********************* </OVERVIEW> *********************** -->
	<xsl:template name="sect_separator">
		<p class="top">
			<a href="#top" title="Top of finding aid">^ Return to Top</a>
		</p>
	</xsl:template>
  
	<!-- ********************* <ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!--this template generically called by arbitrary groupings: see per eg. relatedinfo template -->
	<xsl:template name="archdesc_minor_children">
		<xsl:param name="withLabel"/>
		<xsl:if test="$withLabel='true'">
			<h3>
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="local-name()='altformavail'">
              <xsl:value-of select="$altformavail_id"/>
            </xsl:when>
            <xsl:when test="local-name()='arrangement'">
              <xsl:value-of select="$arrangement_id"/>
            </xsl:when>
            <xsl:when test="local-name()='bibliography'">
              <xsl:value-of select="$bibliography_id"/>
            </xsl:when>
            <xsl:when test="local-name()='accessrestrict'">
              <xsl:value-of select="$accessrestrict_id"/>
            </xsl:when>
            <xsl:when test="local-name()='userestrict'">
              <xsl:value-of select="$userestrict_id"/>
            </xsl:when>
            <xsl:when test="local-name()='prefercite'">
              <xsl:value-of select="$prefercite_id"/>
            </xsl:when>
            <xsl:when test="local-name()='accruals'">
              <xsl:value-of select="$accruals_id"/>
            </xsl:when>
            <xsl:when test="local-name()='acqinfo'">
              <xsl:value-of select="$acqinfo_id"/>
            </xsl:when>
            <xsl:when test="local-name()='appraisal'">
              <xsl:value-of select="$appraisal_id"/>
            </xsl:when>
            <xsl:when test="local-name()='custodhist'">
              <xsl:value-of select="$custodhist_id"/>
            </xsl:when>
            <xsl:when test="local-name()='scopecontent'">
              <xsl:value-of select="$scopecontent_id"/>
            </xsl:when>
            <xsl:when test="local-name()='separatedmaterial'">
              <xsl:value-of select="$separatedmaterial_id"/>
            </xsl:when>
            <xsl:when test="local-name()='relatedmaterial'">
              <xsl:value-of select="$relatedmaterial_id"/>
            </xsl:when>
            <xsl:when test="local-name()='originalsloc'">
              <xsl:value-of select="$originalsloc_id"/>
            </xsl:when>
            <xsl:when test="local-name()='origination'">
              <xsl:value-of select="$origination_id"/>
            </xsl:when>
            <xsl:when test="local-name()='otherfindaid'">
              <xsl:value-of select="$otherfindaid_id"/>
            </xsl:when>
            <xsl:when test="local-name()='processinfo'">
              <xsl:value-of select="$processinfo_id"/>
            </xsl:when>
            <xsl:when test="local-name()='odd'">
              <xsl:value-of select="$odd_id"/>
            </xsl:when>
            <xsl:when test="local-name()='physdesc'">
              <xsl:value-of select="$physdesc_id"/>
            </xsl:when>
            <xsl:when test="local-name()='physloc'">
              <xsl:value-of select="$physloc_id"/>
            </xsl:when>
            <xsl:when test="local-name()='phystech'">
              <xsl:value-of select="$phystech_id"/>
            </xsl:when>
            <xsl:when test="local-name()='fileplan'">
              <xsl:value-of select="$fileplan_id"/>
            </xsl:when>
            <xsl:when test="local-name()='index'">
              <xsl:value-of select="$index_id"/>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </xsl:attribute>
        <span>
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id" />
            </xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <!--pull in correct label, depending on what is actually matched-->
            <xsl:when test="local-name()='altformavail'">
              <xsl:value-of select="$altformavail_label"/>
            </xsl:when>
            <xsl:when test="local-name()='arrangement'">
              <xsl:value-of select="$arrangement_label"/>
            </xsl:when>
            <xsl:when test="local-name()='bibliography'">
              <xsl:value-of select="$bibliography_label"/>
            </xsl:when>
            <xsl:when test="local-name()='accessrestrict'">
              <xsl:value-of select="$accessrestrict_label"/>
            </xsl:when>
            <xsl:when test="local-name()='userestrict'">
              <xsl:value-of select="$userestrict_label"/>
            </xsl:when>
            <xsl:when test="local-name()='prefercite'">
              <xsl:value-of select="$prefercite_label"/>
            </xsl:when>
            <xsl:when test="local-name()='accruals'">
              <xsl:value-of select="$accruals_label"/>
            </xsl:when>
            <xsl:when test="local-name()='acqinfo'">
              <xsl:value-of select="$acqinfo_label"/>
            </xsl:when>
            <xsl:when test="local-name()='appraisal'">
              <xsl:value-of select="$appraisal_label"/>
            </xsl:when>
            <xsl:when test="local-name()='custodhist'">
              <xsl:value-of select="$custodhist_label"/>
            </xsl:when>
            <xsl:when test="local-name()='scopecontent'">
              <xsl:value-of select="$scopecontent_label"/>
            </xsl:when>
            <xsl:when test="local-name()='separatedmaterial'">
              <xsl:value-of select="$separatedmaterial_label"/>
            </xsl:when>
            <xsl:when test="local-name()='relatedmaterial'">
              <xsl:value-of select="$relatedmaterial_label"/>
            </xsl:when>
            <xsl:when test="local-name()='originalsloc'">
              <xsl:value-of select="$originalsloc_label"/>
            </xsl:when>
            <xsl:when test="local-name()='origination'">
              <xsl:value-of select="$origination_label"/>
            </xsl:when>
            <xsl:when test="local-name()='otherfindaid'">
              <xsl:value-of select="$otherfindaid_label"/>
            </xsl:when>
            <xsl:when test="local-name()='processinfo'">
              <xsl:value-of select="$processinfo_label"/>
            </xsl:when>
            <xsl:when test="local-name()='odd'">
              <xsl:value-of select="$odd_label"/>
            </xsl:when>
            <xsl:when test="local-name()='physdesc'">
              <xsl:value-of select="$physdesc_label"/>
            </xsl:when>
            <xsl:when test="local-name()='physloc'">
              <xsl:value-of select="$physloc_label"/>
            </xsl:when>
            <xsl:when test="local-name()='phystech'">
              <xsl:value-of select="$phystech_label"/>
            </xsl:when>
            <xsl:when test="local-name()='fileplan'">
              <xsl:value-of select="$fileplan_label"/>
            </xsl:when>
            <xsl:when test="local-name()='index'">
              <xsl:value-of select="$index_label"/>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </span>
			</h3>
		</xsl:if>
		<!-- 2004-11-30 Suppress the display of all <head> elements (with exceptions).  Example, Pauling finding aid of OSU SC -->
		<!-- 2004-12-06 Process physdesc separately -->
		<xsl:choose>
			<xsl:when test="self::physdesc">
				<div class="{name()}">
					<xsl:apply-templates select="extent"/>
					<xsl:if test="string(physfacet) and string(extent)">
						<xsl:text> : </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="physfacet"/>
					<xsl:if test="string(dimensions) and string(physfacet)">
						<xsl:text> ; </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="dimensions"/>
				</div>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates select="self::node()"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="self::origination and child::*/@role"> &#160;( <xsl:value-of select="child::*/@role"/>) </xsl:if>

	</xsl:template>
	<!-- ********************* </ARCHDESC_MINOR_CHILDREN> *********************** -->
	<!-- ********************* <BIOGHIST> *********************** -->
	<xsl:template name="bioghist" match="//bioghist">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::archdesc">
					<xsl:text>top_bioghist</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>bioghist</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>

		<xsl:choose>
			<xsl:when test="head/text()='Biographical Note' and not(ancestor::dsc)">
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				<h2 id="{$bioghist_id}">
					<xsl:value-of select="$bioghist_head"/>
          <button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-{$class}" aria-controls="{$class}-content" aria-expanded="true">
            <xsl:attribute name="title">
              <xsl:text>Close </xsl:text>
              <xsl:value-of select="$bioghist_head"/>
            </xsl:attribute>
          </button>
				</h2>
			</xsl:when>
			<!-- carlson mod 2004-07-09 only use Bioghist head if encodinganalog starts with 5450 as opposed to 5451 -->
			<xsl:when test="starts-with(@encodinganalog, '5450') and not(ancestor::dsc)">
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				<h2 id="{$bioghist_id}">
					<xsl:value-of select="$bioghist_head"/>
					<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-{$class}" aria-controls="{$class}-content" aria-expanded="true">
            <xsl:attribute name="title">
              <xsl:text>Close </xsl:text>
              <xsl:value-of select="$bioghist_head"/>
            </xsl:attribute>
          </button>
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(ancestor::dsc)">
          <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					<h2 id="{$historical_id}">
						<xsl:value-of select="$historical_head"/>
						<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-{$class}" aria-controls="{$class}-content" aria-expanded="true">
              <xsl:attribute name="title">
                <xsl:text>Close </xsl:text>
                <xsl:value-of select="$historical_head"/>
              </xsl:attribute>
            </button>
					</h2>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<div>
			<xsl:attribute name="class">
        <xsl:value-of select="$class"/>
			</xsl:attribute>
      <xsl:if test="name(..) = 'archdesc'">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($class, '-content')"/>
        </xsl:attribute>
      </xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </BIOGHIST> *********************** -->
	<!-- ********************* <SCOPECONTENT> *********************** -->
	<xsl:template name="scopecontent" match="scopecontent[1]">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::archdesc">
					<xsl:text>top_scopecontent</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>scopecontent</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="not(ancestor::dsc)">
      <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
			<h2 id="{$scopecontent_id}">
				<xsl:value-of select="$scopecontent_head"/>
				<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-{$class}" aria-controls="{$class}-content" aria-expanded="true">
          <xsl:attribute name="title">
              <xsl:text>Close </xsl:text>
              <xsl:value-of select="$scopecontent_head"/>
            </xsl:attribute>
        </button>
			</h2>
      
		</xsl:if>

		<div>
			<xsl:attribute name="class">
        <xsl:value-of select="$class"/>
			</xsl:attribute>
      <xsl:if test="name(..) = 'archdesc'">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($class, '-content')"/>
        </xsl:attribute>
      </xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </SCOPECONTENT> *********************** -->
	<!-- ********************* <ODD> *********************** -->
	<xsl:template name="odd" match="//odd">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::archdesc">
					<xsl:text>top_odd</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>odd</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="not(ancestor::dsc)">
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				<h2 id="{$odd_id}">
          <xsl:choose>
            <xsl:when test="@type='hist'">
              <xsl:value-of select="$odd_head_histbck"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$odd_head"/>
            </xsl:otherwise>
          </xsl:choose>
					<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-{$class}" aria-controls="{$class}-content" aria-expanded="true">
            <xsl:attribute name="title">
              <xsl:text>Close </xsl:text>
              <xsl:choose>
                <xsl:when test="@type='hist'">
                  <xsl:value-of select="$odd_head_histbck"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$odd_head"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </button>
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<h5 id="{$odd_id}">
					<xsl:value-of select="$odd_head"/>
				</h5>
			</xsl:otherwise>
		</xsl:choose>

		<div>
			<xsl:attribute name="class">
        <xsl:value-of select="$class"/>
			</xsl:attribute>
      <xsl:if test="name(..) = 'archdesc'">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($class, '-content')"/>
        </xsl:attribute>
      </xsl:if>
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- ********************* </ODD> *********************** -->
	<!-- ********************* <USEINFO> *********************** -->
	<xsl:template name="useinfo">
		<!-- removed accessrestrict from this section, moved to Collection Overview, as per March 2015 spec -->
		<xsl:if test="altformavail | userestrict | prefercite">
			<a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
      <h2 id="{$useinfo_id}">
        <span>
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id" />
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="$useinfo_head"/>
        </span>
				<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-usediv" aria-controls="usediv-content" aria-expanded="true">
          <xsl:attribute name="title">
            <xsl:text>Close </xsl:text>
            <xsl:value-of select="$useinfo_head"/>
          </xsl:attribute>
        </button>
			</h2>
      
			<div class="use" id="usediv-content">
				<xsl:for-each select="altformavail | userestrict | prefercite">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- ********************* </USEINFO> *********************** -->
	<!-- ************************* ADMINISTRATIVE INFO ******************** -->
	<xsl:template name="administrative_info">
    <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
		<h2 id="administrative_info">
      <span>
        <xsl:if test="@id">
          <xsl:attribute name="id">
            <xsl:value-of select="@id" />
          </xsl:attribute>
        </xsl:if>
        <xsl:text>Administrative Information</xsl:text>
      </span>
			<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-ai" aria-controls="ai-content" aria-expanded="true" title="Close Administrative Information"></button>
		</h2>
    
		<div class="ai" id="ai-content">
			<xsl:apply-templates select="arrangement"/>
			<xsl:call-template name="admininfo"/>
			<xsl:if test="string(index[not(ancestor::dsc)])">
				<xsl:apply-templates select="index"/>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ******************** END ADMINISTRATIVE INFO ******************** -->
	<!-- ********************* <ARRANGEMENT> *********************** -->
	<xsl:template name="arrangement" match="//arrangement">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::archdesc">
					<xsl:text>top_arrangement</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>arrangement</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="not(ancestor::dsc)">
			<h3 id="{$arrangement_id}">
        <span>
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:text>Arrangement</xsl:text>
        </span>
      </h3>
		</xsl:if>
		<div class="{$class}">
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</div>
	</xsl:template>
	<!-- ********************* </ARRANGEMENT> *********************** -->
	<!-- ********************* <ADMININFO> *********************** -->
	<xsl:template name="admininfo">
		<xsl:if test="acqinfo | accruals | custodhist | processinfo | separatedmaterial |
			bibliography | relatedmaterial | did/physloc | originalsloc | appraisal | phystech">
			<div class="admininfo">
        <xsl:if test="not(ancestor::dsc)">
          <xsl:attribute name="id">
            <xsl:choose>
              <xsl:when test="@id">
                <xsl:value-of select="@id" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$admininfo_id" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:if>
				<xsl:for-each select="custodhist | acqinfo | accruals | processinfo | separatedmaterial |
					bibliography | relatedmaterial | appraisal | did/physloc | originalsloc | phystech">
					<xsl:call-template name="archdesc_minor_children">
						<xsl:with-param name="withLabel">true</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- ********************* </ADMININFO> *********************** -->
	<!-- ********************* <INDEX> *********************** -->
	<xsl:template match="index" name="index">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="parent::archdesc">
					<xsl:text>top_index</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>index</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="{$class}">
      <xsl:if test="not(ancestor::dsc)">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="@id">
              <xsl:value-of select="@id" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$index_id" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
			<xsl:apply-templates select="p"/>
			<xsl:if test="count(indexentry) &gt; 0">
				<table class="table table-striped">
					<xsl:apply-templates select="listhead" mode="index"/>
					<tbody>
						<xsl:apply-templates select="indexentry" mode="index"/>
					</tbody>
				</table>
			</xsl:if>
		</div>
		<xsl:call-template name="sect_separator"/>
	</xsl:template>

	<xsl:template match="listhead" mode="index">
		<thead>
			<tr>
				<th style="width:50%">
					<xsl:apply-templates select="head01"/>
				</th>
				<th>
					<xsl:apply-templates select="head02"/>
				</th>
			</tr>
		</thead>

	</xsl:template>

	<xsl:template match="indexentry" mode="index">
		<tr>
			<td>
				<xsl:apply-templates select="corpname | famname | function | genreform | geogname |
					name | occupation | persname | subject | title"/>
			</td>
			<td>
				<xsl:for-each select="ref | ptrgrp/ref">
					<xsl:choose>
						<xsl:when test="@target">
							<a href="#{@target}">
								<xsl:apply-templates/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
	</xsl:template>

	<!-- ********************* </INDEX> *********************** -->
	<!-- ********************* <physloc> ********************** -->
	<xsl:template match="c01/did/physloc">
		<div class="physdesc">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ********************* </physloc> ********************* -->
<xsl:template match="c01//accessrestrict | c01//userestrict | c01//note | c01//altformavail | c01//custodhist | c01//processinfo | c01//separatedmaterial | c01//acqinfo | c01//phystech">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="local-name()='accessrestrict'">
					<xsl:text>accessrestrict</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='userestrict'">
					<xsl:text>userestrict</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='note'">
					<xsl:text>note</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='altformavail'">
					<xsl:text>altformavail</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='custodhist'">
					<xsl:text>custodhist</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='processinfo'">
					<xsl:text>processinfo</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='separatedmaterial'">
					<xsl:text>separatedmaterial</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='acqinfo'">
					<xsl:text>acqinfo</xsl:text>
				</xsl:when>
				<xsl:when test="local-name()='phystech'">
					<xsl:text>phystech</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<div class="{$class}">
			<xsl:for-each select="p">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:for-each>
		</div>
	</xsl:template>

	<!-- May 2021: define template to concatenate values with a separator -->
	<xsl:template name="join" >
		<xsl:param name="valueList" select="''"/>
		<xsl:param name="separator" select="','"/>
		<xsl:for-each select="$valueList">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($separator, .) "/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
  
  <!-- August 2021: additions from MySQL -->
  <xsl:template name="aw_repository" match="aw-additions/repository">
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:value-of select="url" />
      </xsl:attribute>
      <xsl:attribute name="target">_blank</xsl:attribute>
      <xsl:value-of select="name" />
    </xsl:element>
    <br />
    <xsl:for-each select="address/*">
      <xsl:value-of select="text()" />
      <br />
    </xsl:for-each>
    <xsl:if test="phone != ''">
      Telephone: <xsl:value-of select="phone" />
      <br />
    </xsl:if>
    <xsl:if test="fax != ''">
      Fax: <xsl:value-of select="fax" />
      <br />
    </xsl:if>
    <xsl:if test="email != ''">
      <xsl:element name="a">
        <xsl:attribute name="href">
          mailto:<xsl:value-of select="email" />
        </xsl:attribute>
        <xsl:value-of select="email" />
      </xsl:element>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="aw_rights" match="aw-additions/rights">
    <xsl:choose>
      <xsl:when test=".='CC Zero'">
        <a rel="license" href="https://creativecommons.org/publicdomain/zero/1.0/" target="_blank">
          <img src="/layout/images/cc-zero.png" style="border-style: none;" alt="CC0" />
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a rel="license" href="https://creativecommons.org/licenses/by/4.0/" target="_blank">
          <img src="/layout/images/cc-attr.png" style="border-style: none;" alt="CC Attribution" />
        </a>
        <br />
        This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
      </xsl:otherwise>
    </xsl:choose>
    <p><a href="/creative-commons.php" target="_blank">About Creative Commons Licenses in Archives West</a></p>
  </xsl:template>

</xsl:stylesheet>
