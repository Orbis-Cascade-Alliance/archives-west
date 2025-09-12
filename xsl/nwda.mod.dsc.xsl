<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modications and Revisions by Mark Carlson, 2004

and by Ethan Gruber, July/August 2007

Most of this stylesheet was rewritten in July/August 2007 to fix display issues, but more importantly, to 
reduce the post-transformation filesize to be comparable to the size of the XML file.

Changes:

11/16/2022  TKM     Print c0x/did/daogrp as generic links when unittitle is absent.
                    (Templates "indepth" and c02|c03|etc.) 
03/01/13    KEF     The "c01//did" template was counting <head /> and <p /> elements as
                    siblings when generating the "ppos" variable, leading to "off-by-one" errors
                    for "Detailed descripton" sidelinks to internal anchors.  I fixed this
                    as noted at the point of change.

01/27/14    KEF     The <extref/> element was being turned into a URL for elements with
                    a path of /ead/archdesc/dsc/c01/c02/did/unitid/extref.  Used a
                    "apply-templates" rather than "value-of" to resolve this.  (Migrated
                    from Utah pilot site XSLT with original note date of 08/18/11.)

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ead="urn:isbn:1-931666-22-9"
	xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="ead fo xlink">

	<xsl:variable name="lcChars">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="lcCharsHyphen">abcdefghijklmnopqrstuvwxyz-</xsl:variable>
	<xsl:variable name="lcCharsSlash">abcdefghijklmnopqrstuvwxyz/</xsl:variable>
	<xsl:variable name="ucChars">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="repCode" select="translate(//eadid/@mainagencycode,$ucChars,$lcChars)"/>

	<!-- ********************* <DSC> *********************** -->
	<xsl:template name="dsc" match="dsc[count(c01) &gt; 0]">
		<xsl:if test="@id">
			<a id="{@id}"/>
		</xsl:if>
		<a id="{$dsc_id}"/>
    <a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
		<h2>
			<xsl:value-of select="$dsc_head"/>
			<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-dscdiv" aria-controls="dscdiv-content" aria-expanded="true">
        <xsl:attribute name="title">
          <xsl:text>Close </xsl:text>
          <xsl:value-of select="$dsc_head"/>
        </xsl:attribute>
      </button>
		</h2>
		<div class="dsc" id="dscdiv-content">
      <xsl:apply-templates select="*[not(self::c01)]"/>
      <ul id="dscul">
        <xsl:apply-templates select="c01"/>
      </ul>
		</div>
	</xsl:template>
	<!-- ********************* </DSC> *********************** -->
	<!-- ********************* START c0xs *************************** -->
	<xsl:template match="c01|c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12">

      <!-- start list item -->
      <li class="{name()}">
        <xsl:for-each select="*[@id] | did/*[@id]">
          <a id="{@id}"/>
        </xsl:for-each>
        <xsl:choose>
          <!-- if next c0x child has did, print heading and start new list -->
          <xsl:when test="child::node()/did">
            <xsl:choose>
              <!-- h3 for series -->
              <xsl:when test="local-name(.)='c01'">
                <h3>
                  <xsl:call-template name="c0x_heading"/>
                </h3>
              </xsl:when>
              <!-- h4 unitid/title and date for subseries -->
              <xsl:when test="local-name(.)='c02'">
                <h4>
                  <xsl:call-template name="c0x_heading"/>
                </h4>
              </xsl:when>
              <!-- h5 unitid/title and date for sub-subseries -->
              <xsl:when test="local-name(.)='c03'">
                <h5>
                  <xsl:call-template name="c0x_heading"/>
                </h5>
              </xsl:when>
              <!-- h6 unitid/title and date for sub-sub-subseries -->
              <xsl:when test="local-name(.)='c04'">
                <h6>
                  <xsl:call-template name="c0x_heading"/>
                </h6>
              </xsl:when>
              <!-- Paragraphs for further headings -->
              <xsl:otherwise>
                <p class="c0x_heading">
                  <xsl:call-template name="c0x_heading" />
                </p>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="did"/>
            <ul>
              <xsl:apply-templates select="c01|c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12" />
            </ul>
          </xsl:when>
          <!-- if current c0x has container, print details -->
          <xsl:otherwise>
            <!-- unittitle or daogrp -->
            <xsl:call-template name="c0x_description"/>
            <!-- Containers -->
            <xsl:if test="did/container">
              <xsl:apply-templates select="did/container" />
            </xsl:if>
            <!-- Dates -->
            <xsl:choose>
              <xsl:when test="did/unitdate">
                <xsl:call-template name="c0x_dates"/>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </li>
	</xsl:template>
  
  <!-- c0x headings -->
  <xsl:template name="c0x_heading">
    <xsl:attribute name="id">
      <xsl:choose>
        <xsl:when test="@id">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="generate-id(.)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:choose>
      <!-- if unittitle -->
      <xsl:when test="did/unittitle">
        <xsl:if test="string(did/unitid)">
          <xsl:if test="did/unitid/@label">
            <xsl:value-of select="did/unitid/@label"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="did/unitid/@type='counter' or did/unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
          </xsl:if>
          <xsl:if test="did/unitid[@type='accession']"> Accession No.&#160; </xsl:if>
          <xsl:value-of select="did/unitid"/>: <xsl:text>&#160;</xsl:text>
        </xsl:if>
        <xsl:apply-templates select="did/unittitle"/>
        <xsl:if test="string(did/unitdate) and string(did/unittitle)">,&#160;</xsl:if>
        <xsl:if test="string(did/unitdate)">
          <xsl:for-each select="did/unitdate">
            <xsl:choose>
              <xsl:when test="@type='bulk'"> &#160;(bulk <xsl:apply-templates/>) </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:if test="not(position()=last())">,&#160;</xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:if>
      </xsl:when>
      <!-- if unitid only -->
      <xsl:when test="did/unitid/text() and not(did/unittitle)">
        <xsl:if test="did/unitid/@label">
          <xsl:value-of select="did/unitid/@label"/>
          <xsl:text>&#160;</xsl:text>
          <xsl:if test="did/unitid/@type='counter' or did/unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
        </xsl:if>
        <xsl:if test="did/unitid[@type='accession']"> Accession No.&#160; </xsl:if>
        <xsl:value-of select="did/unitid"/>
      </xsl:when>
      <!-- if date only -->
      <xsl:when test="did/unitdate/text() and not(did/unittitle)">
        <xsl:value-of select="did/unitdate"/>
      </xsl:when>
      <xsl:otherwise>Subordinate Component # <xsl:value-of select="count(preceding-sibling)+1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- c0x_description -->
  <!-- print unittitle or daogrp -->
  <xsl:template name="c0x_description">
    <xsl:choose>
      <xsl:when test="did/unittitle">
        <div class="c0x_description">
          <span class="c0x_label">Description</span>
          <xsl:text> </xsl:text>
          <xsl:if test="string(did/unitid)">
            <xsl:value-of select="did/unitid"/>
            <xsl:text>: </xsl:text>
          </xsl:if>
          <xsl:apply-templates select="did/unittitle" />
          <xsl:call-template name="c0x_children"/>
        </div>
      </xsl:when>
      <xsl:when test="did/daogrp">
        <div class="c0x_description">
          <span class="c0x_label">Description</span>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="did/daogrp"/>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- c0x_date -->
  <xsl:template name="c0x_dates">
    <xsl:if test="did/unitdate">
      <div class="c0x_date">
        <span class="c0x_label">Dates</span>
        <xsl:text> </xsl:text>
        <xsl:for-each select="did/unitdate">
          <xsl:value-of select="."/>
          <!-- place a semicolon and a space between dates -->
          <xsl:if test="not(position() = last())">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>
  
	<!-- APPLY TEMPLATES FOR UNITTITLE -->
	<xsl:template match="unittitle">
		<xsl:choose>
      <xsl:when test="parent::node()/daogrp">
        <xsl:apply-templates select="parent::node()/daogrp"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
  

	<!-- ********************* END c0xs *************************** -->

	<!-- *** CONTAINERS ** -->
  <xsl:template match="container">
    <div class="c0x_container">
      <span class="c0x_label">
        <xsl:call-template name="regularize_container">
          <xsl:with-param name="current_val" select="@type"/>
        </xsl:call-template>
      </span>
      <xsl:text> </xsl:text>
      <xsl:value-of select="." />
    </div>
  </xsl:template>
  
  <!-- compare container types and print "false" if they don't match -->
  <xsl:template name="compare_containers">
    <xsl:param name="previous_containers"/>
    <xsl:param name="container_pos"/>
    <xsl:param name="current_type"/>
    <xsl:if test="$previous_containers[$container_pos]/@type != $current_type">
      <xsl:text>false</xsl:text>
    </xsl:if>
  </xsl:template>
  

	<!-- ******************** CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** -->

	<xsl:template name="regularize_container">

		<!-- this is for converting container/@type to a regularized phrase.  The list can be expanded as needed.  The otherwise
			statement outputs the @type if no matches are found (it is capitalized by the CSS file) -->

		<xsl:param name="current_val"/>

		<xsl:choose>
			<xsl:when test="$current_val = 'box'">
				<xsl:text>Box</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'folder'">
				<xsl:text>Folder</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'box-folder'">
				<xsl:text>Box/Folder</xsl:text>
			</xsl:when>
      <xsl:when test="$current_val = 'item'">
        <xsl:text>Item</xsl:text>
      </xsl:when>
			<xsl:when test="$current_val = 'volume'">
				<xsl:text>Volume</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'microfilm-reel' or $current_val = 'microfilm'">
				<xsl:text>Microfilm Reel</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'microfiche'">
				<xsl:text>Microfiche</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'oversize-folder'">
				<xsl:text>Oversize Folder</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'audiocassette'">
				<xsl:text>Cassette</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'audiocassette-side'">
				<xsl:text>Cassette/Side</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'counter' or $current_val = 'counternumber'">
				<xsl:text>Cassette Counter</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'accession'">
				<xsl:text>Accession No.</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'carton'">
				<xsl:text>Carton</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'reel'">
				<xsl:text>Reel</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'frame'">
				<xsl:text>Frame</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'oversize'">
				<xsl:text>Oversize</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'reel-frame'">
				<xsl:text>Reel/Frame</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'album'">
				<xsl:text>Album</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'page'">
				<xsl:text>Page</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'map-case'">
				<xsl:text>Map Case</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'folio'">
				<xsl:text>Folio</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'verticalfile'">
				<xsl:text>Vertical File</xsl:text>
			</xsl:when>
			<xsl:when test="$current_val = 'rolled-document'">
				<xsl:text>Rolled Document</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate(concat(translate(substring($current_val, 1, 1), $lcChars, $ucChars), substring($current_val, 2)), '-_', '  ')"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- ******************** END CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** -->

	<xsl:template name="c0x_children">
		<!-- for displaying extent, physloc, etc.  this is brought over from the original mod.dsc -->

		<!-- added note in addition to did/note for item 2F on revision specifications-->
		<xsl:if test="string(did/origination|did/physdesc|did/physloc|did/note|did/abstract|arrangement|odd|scopecontent|
			acqinfo|custodhist|processinfo|note|bioghist|accessrestrict|userestrict|index|altformavail|phystech)">


			<xsl:for-each select="did">
				<xsl:for-each select="origination | physdesc | physloc | note | abstract">

					<xsl:choose>
						<xsl:when test="self::physdesc">
							<div class="{name()}">
								<xsl:apply-templates select="extent[1]"/>
								<!-- multiple extents contained in parantheses -->
								<xsl:if test="string(extent[2])">
									<xsl:text> </xsl:text>
									<xsl:for-each select="extent[position() &gt; 1]">
										<xsl:text>(</xsl:text>
										<xsl:value-of select="."/>
										<xsl:text>)</xsl:text>
										<xsl:if test="not(position() = last())">
											<xsl:text> </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="string(physfacet) and string(extent)">
									<xsl:text> : </xsl:text>
								</xsl:if>
								<xsl:for-each select="physfacet">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
								<xsl:if test="string(dimensions) and string(physfacet)">
									<xsl:text>;</xsl:text>
								</xsl:if>
								<xsl:for-each select="dimensions">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
								<!-- if genreform exists, insert a line break and then display genreforms separated by semicolons -->
								<xsl:if test="genreform">
									<br/>
								</xsl:if>
								<xsl:for-each select="genreform">
									<xsl:apply-templates select="."/>
									<xsl:if test="not(position() = last())">
										<xsl:text>.  </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="{name()}">
								<xsl:apply-templates/>
								<xsl:if test="self::origination and child::*/@role"> (<xsl:value-of select="child::*/@role"/>) </xsl:if>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="arrangement | odd | acqinfo | accruals | custodhist |
				processinfo | separatedmaterial | scopecontent | note | origination |
				physdesc | physloc | bioghist |     accessrestrict | userestrict |
				altformavail | phystech">
				<div class="{name()}">
					<xsl:apply-templates/>
				</div>
			</xsl:for-each>
			<xsl:if test="index">
				<xsl:apply-templates select="index"/>
			</xsl:if>
		</xsl:if>

	</xsl:template>
	<!-- kept from original mod.dsc -->

	<xsl:template match="did">
    <!-- March 2015: Adding container display as per revision specification 7.1.2 -->
    <xsl:if test="count(container) &gt; 0">
      <p>
        <span class="c0x_label">Container(s)</span>
        <xsl:for-each select="container">
          <xsl:call-template name="regularize_container">
            <xsl:with-param name="current_val" select="@type"/>
          </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:value-of select="."/>
          <xsl:if test="position()!=last()">, </xsl:if>
        </xsl:for-each>
      </p>
    </xsl:if>
    <!-- May 2015: Adding abstract, which had not previously been displayed -->
    <xsl:if test="count(abstract) &gt; 0">
      <p>
        <span class="c0x_label">Abstract</span>
        <xsl:apply-templates select="abstract"/>
      </p>
    </xsl:if>
		<!--non-unittitle,unitdate,unitid descriptive information-->
    <xsl:for-each select="following-sibling::acqinfo | following-sibling::accruals | following-sibling::custodhist | following-sibling::processinfo | following-sibling::separatedmaterial |
      physdesc | physloc | origination | note | following-sibling::odd |
      following-sibling::scopecontent | following-sibling::arrangement | following-sibling::bioghist  |
              following-sibling::accessrestrict | following-sibling::userestrict | following-sibling::note | 
              following-sibling::altformavail | following-sibling::phystech">
      <xsl:call-template name="archdesc_minor_children">
        <xsl:with-param name="withLabel">false</xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
	</xsl:template>

	<xsl:template match="daogrp">

		<xsl:choose>
			<!-- First, check whether we are dealing with one or two <arc> elements -->
			<xsl:when test="arc[2]">
				<a>
					<xsl:if test="arc[2]/@show='new'">
						<xsl:attribute name="target">_blank</xsl:attribute>
					</xsl:if>

					<xsl:for-each select="daoloc">
						<!-- This selects the <daoloc> element that matches the @label attribute from <daoloc> and the @to attribute
							from the second <arc> element -->
						<xsl:if test="@label = following::arc[2]/@to">
							<xsl:attribute name="href">
								<xsl:value-of select="@href"/>
							</xsl:attribute>
						</xsl:if>
					</xsl:for-each>

					<xsl:for-each select="daoloc">
						<xsl:if test="@label = following::arc[1]/@to">
							<img src="{@href}" class="daoimage" bolder="0">
								<xsl:if test="@title">
									<xsl:attribute name="title">
										<xsl:value-of select="@title"/>
									</xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:value-of select="@title"/>
									</xsl:attribute>
								</xsl:if>
							</img>
							<xsl:if test="string(daodesc)">
								<span class="daodesc">
									<xsl:apply-templates/>
								</span>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</a>

			</xsl:when>
			<!-- i.e. no second <arc> element -->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="arc[1][@show='embed' or @xlink:show='embed'] and arc[1][@actuate='onload' or @actuate='onLoad' or @xlink:actuate='onLoad']">
						<xsl:for-each select="daoloc">
							<xsl:if test="@label = following-sibling::arc[1]/@to">
								<img src="{@href}" class="daoimage" border="0">
									<xsl:if test="@title">
										<xsl:attribute name="title">
											<xsl:value-of select="@title"/>
										</xsl:attribute>
										<xsl:attribute name="alt">
											<xsl:value-of select="@title"/>
										</xsl:attribute>
									</xsl:if>
								</img>
								<xsl:if test="string(daodesc)">
									<span class="daodesc">
										<xsl:apply-templates/>
									</span>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="arc[@show='replace' or @xlink:show='replace' or @show='new' or @xlink:show='new'] and
						arc[@actuate='onrequest' or @actuate='onRequest' or @xlink:actuate='onRequest']">
            <a>
							<xsl:if test="daoloc[1]/@title">
								<xsl:attribute name="title">
									<xsl:value-of select="daoloc[1]/@title"/>
								</xsl:attribute>
							</xsl:if>
							
							<!-- revisions 2017: check that <resource> element has no text other than whitespace;
              <resource> value will override <unittitle> -->
							<xsl:choose>
								<xsl:when test="(normalize-space(resource))">
									<xsl:for-each select="daoloc">
										<xsl:if test="@label = following::arc[1]/@to">
											<xsl:attribute name="href">
												<xsl:value-of select="@href"/>
											</xsl:attribute>
											<xsl:if test="following::arc[1]/@show='new'">
												<xsl:attribute name="target">_blank</xsl:attribute>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
									<xsl:apply-templates/>
								</xsl:when>
								
								<xsl:otherwise>
									<!-- if <resource> element is empty, produce a link using <unittitle> -->
									<xsl:for-each select="daoloc">
										<xsl:if test="@label = following::arc[1]/@to">
											<xsl:attribute name="href">
												<xsl:value-of select="@href|@xlink:href"/>
											</xsl:attribute>
											
											<!-- add link title attribute, if it exists -->
											<xsl:attribute name="title">
												<xsl:choose>
													<xsl:when test="@title">
														<xsl:value-of select="(normalize-space(@title))"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>Link to digital object</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>							
											<xsl:if test="following::arc[1][@show='new' or @xlink:show='new']">
												<xsl:attribute name="target">_blank</xsl:attribute>
											</xsl:if>
										</xsl:if>
										<!-- check if <unittitle> exists -->
										<xsl:choose>
                      <xsl:when test="parent::node()/parent::node()/unittitle">
                        <!-- if more than one <daogrp> exists for this <did>, use the <daoloc> title attribute to generate link text -->
                        <xsl:choose>
                          <xsl:when test="count(parent::node()/parent::node()/daogrp) &gt; 1">
                            <xsl:value-of select="@title"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="parent::node()/parent::node()/unittitle"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <!-- if <unittitle> doesn't exist and <resource> is empty, use generic link text -->
                      <xsl:otherwise>
                        <xsl:text>Link</xsl:text>
                      </xsl:otherwise>
										</xsl:choose>
										
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template> <!-- end daogrp -->

</xsl:stylesheet>
