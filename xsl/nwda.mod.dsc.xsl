<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modications and Revisions by Mark Carlson, 2004

and by Ethan Gruber, July/August 2007

Most of this stylesheet was rewritten in July/August 2007 to fix display issues, but more importantly, to 
reduce the post-transformation filesize to be comparable to the size of the XML file.

Changes:

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
		<h3>
			<xsl:value-of select="$dsc_head"/>
			<small>
				<a href="#" class="toggle-button" id="toggle-dscdiv">
					<span class="glyphicon glyphicon-triangle-bottom"> </span>
				</a>
			</small>
			<small>
				<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
			</small>
		</h3>

		<div class="dsc dscdiv-content">
			<xsl:choose>
				<!-- if there are c02's apply normal templates -->
				<xsl:when test="descendant::c02">
					<xsl:apply-templates select="*[not(self::head)]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="p"/>
					<!-- if there are no c02's then all of the c01s are displayed as rows in a table, like an in-depth finding aid -->
					<table class="table table-striped" summary="A listing of materials in {./did/unittitle}.">
						<xsl:call-template name="table_label"/>
						<xsl:call-template name="indepth"/>
					</table>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<!-- ********************* </DSC> *********************** -->
	<!-- ********************* <SERIES> *************************** -->
	<xsl:template match="c01">
		<xsl:if test="@id">
			<a id="{@id}"/>
		</xsl:if>
		<xsl:for-each select="*[@id] | did/*[@id]">
			<a id="{@id}"/>
		</xsl:for-each>
		<div class="c01">
			<xsl:call-template name="dsc_table"/>
		</div>
	</xsl:template>
	<!-- ********************* </SERIES> *************************** -->
	<!-- ********************* In-Depth DSC Type ********************* -->
	<xsl:template name="indepth">
		<tbody>
			<xsl:for-each select="c01">
				<xsl:if test="did/container">
					<xsl:call-template name="container_row"/>
				</xsl:if>
				<xsl:variable name="current_pos" select="position()"/>
				<tr>
					<!-- only display table cells for containers when they exist within the c01s -->
					<xsl:if test="parent::node()/descendant::container">
						<xsl:choose>
							<xsl:when test="not(parent::node()/descendant::did/container[2])">
								<td>
									<xsl:value-of select="did/container[1]"/>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td>
									<xsl:value-of select="did/container[1]"/>
								</td>
								<td>
									<xsl:value-of select="did/container[2]"/>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>

					<td class="c0x_content">
						<xsl:if test="string(did/unitid)">
							<xsl:value-of select="did/unitid"/>
							<xsl:if test="did/unittitle">
								<xsl:text>: </xsl:text>
							</xsl:if>
						</xsl:if>
						<xsl:apply-templates select="did/unittitle"/>
						<xsl:call-template name="c0x_children"/>
					</td>

					<xsl:if test="ancestor::dsc/descendant::did/unitdate">
						<td class="c0x_date">
							<xsl:for-each select="did/unitdate">
								<xsl:value-of select="."/>
								<xsl:if test="not(position() = last())">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</td>
					</xsl:if>
				</tr>
			</xsl:for-each>
		</tbody>
	</xsl:template>

	<!-- ********************* ANALYTICOVER/COMBINED DSC TYPE *************************** -->
	<!--columnar dates are the default-->
	<xsl:template name="dsc_table">
		<xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
		<xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
		<xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>
		<div id="id{$pppos}_{name(..)}_{$ppos}_{name()}_{$cpos}">
			<xsl:apply-templates select="did"/>
		</div>

		<xsl:if test="descendant::c02">
			<table class="table table-striped" summary="A listing of materials in {./did/unittitle}.">
				<!-- calls the labels for the table -->
				<xsl:call-template name="table_label"/>
				<tbody>
					<xsl:if test="(@level='item' or @level='file') and container">
						<tr>
							<td>
								<span class="containerLabel">
									<xsl:value-of select="did/container[1]/@type"/>
								</span>
							</td>
							<xsl:if test="did/container[2]">
								<td>
									<span class="containerLabel">
										<xsl:value-of select="did/container[2]/@type"/>
									</span>
								</td>
							</xsl:if>
							<td class="c0x_content"/>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="did/container[1]"/>
							</td>
							<xsl:if test="did/container[2]">
								<td>
									<xsl:value-of select="did/container[2]"/>
								</td>
							</xsl:if>
							<td class="c0x_content"/>
						</tr>
					</xsl:if>
					<xsl:apply-templates select="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12" />
				</tbody>
			</table>
		</xsl:if>


	</xsl:template>
	<!-- ********************* </DSC TABLE> *************************** -->
	<!-- ********************* LABELS FOR TABLE ********************* -->
	<xsl:template name="table_label">
		<thead>
			<tr>
				<xsl:if test="descendant::container">
					<xsl:choose>
						<xsl:when test="descendant::did[count(container) = 2]">
							<th class="c0x_container_small">
								<span class="c0x_header">Container(s)</span>
							</th>
							<th class="c0x_container_small"/>
						</xsl:when>
						<xsl:otherwise>
							<th class="c0x_container_small">
								<span class="c0x_header">Container(s)</span>
							</th>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>

				<th class="c0x_content">
					<span class="c0x_header">Description</span>
				</th>

				<xsl:if test="string(descendant::did/unitdate)">
					<th class="c0x_date">
						<span class="c0x_header">Dates</span>
					</th>
				</xsl:if>
			</tr>
		</thead>
	</xsl:template>
	<!-- ********************* END LABELS FOR TABLE ************************** -->
	<!-- ********************* START c0xs *************************** -->
	<xsl:template match="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12">

		<!-- ********* ROW FOR DISPLAYING CONTAINER TYPES ********* -->
		<xsl:if test="did/container">
			<xsl:call-template name="container_row"/>
		</xsl:if>

		<!-- *********** ROW FOR DISPLAYING CONTAINER, CONTENT, AND DATE DATA **************-->

		<!--all c0x level items are their own row; indentation created by css only-->

		<tr>
			<!-- if there is only one container, the td is 170 pixels wide, otherwise 85 for two containers -->

			<xsl:choose>
				<xsl:when test="count(did/container) = 1">
					<td>
						<xsl:value-of select="did/container[1]"/>
					</td>
					<xsl:if test="ancestor-or-self::c01/descendant::did/container[2]">
						<td/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="count(did/container) = 2">
					<td>
						<xsl:value-of select="did/container[1]"/>
					</td>
					<td>
						<xsl:value-of select="did/container[2]"/>
					</td>
				</xsl:when>
				<xsl:when test="ancestor-or-self::c01/descendant::did/container">
					<xsl:choose>
						<xsl:when test="ancestor-or-self::c01/descendant::did/container[2]">
							<td colspan="2"/>
						</xsl:when>
						<xsl:otherwise>
							<td/>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:when>
			</xsl:choose>

			<xsl:variable select="count(../../preceding-sibling::*)+1" name="pppos"/>
			<xsl:variable select="count(../preceding-sibling::*)+1" name="ppos"/>
			<xsl:variable select="count(preceding-sibling::*)+1" name="cpos"/>
			<td class="c0x_content" id="id{$pppos}_{name(..)}_{$ppos}_{name()}_{$cpos}">
				<div class="{name()}">
					<xsl:for-each select="*[@id] | did/*[@id]">
						<a id="{@id}"/>
					</xsl:for-each>
					<xsl:if test="did/unittitle">
						<xsl:choose>
							<!-- series, subseries, etc are bold -->
							<xsl:when test="(@level='series' or @level='subseries' or @otherlevel='sub-subseries' or @level='otherlevel') and child::node()/did">
								<b>
									<xsl:if test="string(did/unitid)">
										<xsl:apply-templates select="did/unitid"/>
										<xsl:text>: </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="did/unittitle"/>
								</b>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="string(did/unitid)">
									<xsl:value-of select="did/unitid"/>
									<xsl:text>: </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="did/unittitle"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:call-template name="c0x_children"/>

				</div>
			</td>
			<!-- if the date layout is columnar, then the column is displayed -->
			<xsl:if test="ancestor-or-self::c01/descendant::did/unitdate">
				<td class="c0x_date">
					<xsl:for-each select="did/unitdate">
						<xsl:choose>
							<xsl:when test="(parent::node()/parent::node()[@level='series'] or parent::node()/parent::node()[@level='subseries']         or
								parent::node()/parent::node()[@otherlevel='sub-subseries'] or parent::node()/parent::node()[@level='otherlevel'])">
								<b>
									<xsl:value-of select="."/>
								</b>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- place a semicolon and a space between dates -->
						<xsl:if test="not(position() = last())">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</td>
			</xsl:if>
		</tr>
		<xsl:apply-templates select="c02|c03|c04|c05|c06|c07|c08|c09|c10|c11|c12" />
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

	<!-- *** CONTAINER ROW ** -->

	<xsl:template name="container_row">
		<!-- variables are created to grab container type data.
		this logic basically only creates the row and its table cells if there is firstor second container
		data returned from the template call.  this logic cuts back on processing time for the server
		and download time for the user - Ethan Gruber 7/29/07 -->

		<xsl:variable name="first_container">
			<xsl:call-template name="container_type">
				<xsl:with-param name="container_number" select="1"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="second_container">
			<xsl:call-template name="container_type">
				<xsl:with-param name="container_number" select="2"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- if none of the container variables contains any data, the row will not be created -->		

		<xsl:if test="string($first_container) or string($second_container)">
			<tr>
				<xsl:choose>
					<!-- for two containers -->
					<xsl:when test="did/container[2]">
						<td>
							<span class="containerLabel">
								<xsl:value-of select="$first_container"/>
							</span>
						</td>
						<td>
							<span class="containerLabel">
								<xsl:value-of select="$second_container"/>
							</span>
						</td>
						<td/>
						<xsl:choose>
							<xsl:when test="count(//c02) &gt; 0">
								<xsl:if test="ancestor::c01/descendant::did/unitdate">
									<td class="c0x_date"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="ancestor::dsc/descendant::did/unitdate">
									<td class="c0x_date"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<!-- for one container -->
					<xsl:otherwise>
						<xsl:variable name="container_colspan">
							<xsl:choose>
								<xsl:when test="count(//c02) &gt; 0">
									<xsl:choose>
										<xsl:when test="ancestor::c01/descendant::did/container[2]">2</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="ancestor::dsc/descendant::did/container[2]">2</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<td colspan="{$container_colspan}">
							<span class="containerLabel">
								<xsl:value-of select="$first_container"/>
							</span>
						</td>
						<td/>
						<xsl:choose>
							<xsl:when test="count(//c02) &gt; 0">
								<xsl:if test="ancestor::c01/descendant::did/unitdate">
									<td class="c0x_date"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="ancestor::dsc/descendant::did/unitdate">
									<td class="c0x_date"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:if>
	</xsl:template>

	<!-- ******************** DISPLAYS TYPE OF CONTAINER ****************** -->
	
	<xsl:template name="container_type">
		<xsl:param name="container_number"/>
		<xsl:variable name="current_val">
			<xsl:value-of select="did/container[$container_number]/@type"/>
		</xsl:variable>
		<xsl:variable name="last_val">
			<xsl:value-of select="preceding-sibling::*[1]/did/container[$container_number]/@type"/>
		</xsl:variable>

		<!-- if the last value is not equal to the first value, then the regularize_container template is called.  -->
		<xsl:if test="$last_val != $current_val">
			<xsl:call-template name="regularize_container">
				<xsl:with-param name="current_val" select="$current_val"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- ******************** END TYPE OF CONTAINER ****************** -->

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
				<xsl:value-of select="$current_val"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- ******************** END CONVERT CONTAINER TYPE TO REGULAR TEXT ****************** -->

	<xsl:template name="c0x_children">
		<!-- for displaying extent, physloc, etc.  this is brought over from the original mod.dsc -->

		<!-- added note in addition to did/note for item 2F on revision specifications-->
		<xsl:if test="string(did/origination|did/physdesc|did/physloc|did/note|did/abstract|arrangement|odd|scopecontent|
			acqinfo|custodhist|processinfo|note|bioghist|accessrestrict|userestrict|index|altformavail)">


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
				altformavail">
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

	<xsl:template match="c01//did">
		<!-- c01 only -->
		<xsl:choose>
			<xsl:when test="parent::c01 and //c02">
				<xsl:if test="count(parent::c01/preceding-sibling::c01)!='0'"/>
				<xsl:variable select="count(../preceding-sibling::c01)+1" name="ppos"/>
				<h4>
					<xsl:attribute name="id">
						<xsl:choose>
							<xsl:when test="parent::node()/@id">
								<xsl:value-of select="parent::node()/@id"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="generate-id(parent::node())"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

					<!-- what if no unitititle-->
					<xsl:choose>
						<xsl:when test="./unittitle">
							<xsl:if test="string(unitid)">
								<xsl:if test="unitid/@label">
									<span class="containerLabel">
										<xsl:value-of select="unitid/@label"/>
										<xsl:text>&#160;</xsl:text>
										<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
									</span>
								</xsl:if>
								<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']"> Accession No.&#160; </xsl:if>
								<xsl:value-of select="unitid"/>: <xsl:text>&#160;</xsl:text>
							</xsl:if>
							<xsl:apply-templates select="unittitle"/>
							<xsl:if test="string(unitdate) and string(unittitle)">,&#160;</xsl:if>
							<xsl:if test="string(unitdate)">
								<xsl:for-each select="unitdate">
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
						<xsl:when test="./unitid/text() and not(./unittitle)">
							<xsl:if test="unitid/@label">
								<span class="containerLabel">
									<xsl:value-of select="unitid/@label"/>
									<xsl:text>&#160;</xsl:text>
									<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
								</span>
							</xsl:if>
							<xsl:if test="$repCode='wau-ar' and unitid[@type='accession']"> Accession No.&#160; </xsl:if>
							<xsl:value-of select="unitid"/>
						</xsl:when>
						<xsl:when test="./unitdate/text() and not(./unittitle)">
							<xsl:value-of select="./unitdate"/>
						</xsl:when>
						<xsl:otherwise>Subordinate Component # <xsl:value-of select="count(parent::c01/preceding-sibling::c01)+1"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END what if no unitititle-->
					<small>
						<a href="#top" title="Return to Top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
					</small>
				</h4>
				<!-- March 2015: Adding container display as per revision specification 7.1.2 -->
				<xsl:if test="count(container) &gt; 0">
					<p>
						<strong>Container(s): </strong>
						<xsl:apply-templates select="container" mode="c01"/>
					</p>
				</xsl:if>
				<!-- May 2015: Adding abstract, which had not previously been displayed -->
				<xsl:if test="count(abstract) &gt; 0">
					<p>
						<strong>Abstract: </strong>
						<xsl:apply-templates select="abstract"/>
					</p>
				</xsl:if>
			</xsl:when>
			<!-- carlsonm This is where the unittitle info is output when it is a c01 list only -->
			<xsl:otherwise>
				<xsl:if test="unittitle/@label">
					<xsl:value-of select="unittitle/@label"/>&#160; </xsl:if>
				<!-- what if no unitititle-->
				<xsl:choose>
					<xsl:when test="./unittitle">
						<xsl:if test="string(unitid)">
							<xsl:if test="unitid/@label">
								<span class="containerLabel">
									<xsl:value-of select="unitid/@label"/>
									<xsl:text>&#160;</xsl:text>
								</span>
							</xsl:if>
							<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
							<xsl:value-of select="unitid"/>: <xsl:text> &#160;</xsl:text>
						</xsl:if>
						<xsl:apply-templates select="./unittitle"/>
						<xsl:apply-templates select="daogrp"/>
					</xsl:when>
					<xsl:when test="./unitid/text() and not(./unittitle)">
						<xsl:if test="unitid/@label">
							<span class="containerLabel">
								<xsl:value-of select="unitid/@label"/>
								<xsl:text>&#160;</xsl:text>
							</span>
						</xsl:if>
						<xsl:if test="unitid/@type='counter' or unitid/@type='counternumber'"> Cassette Counter&#160; </xsl:if>
						<xsl:value-of select="unitid"/>
					</xsl:when>
					<xsl:when test="./unitdate/text() and not(./unittitle)">
						<xsl:value-of select="./unitdate"/>
					</xsl:when>
					<xsl:otherwise>Subordinate Component</xsl:otherwise>
				</xsl:choose>
				<!-- END what if no unitititle-->

				<!-- March 2015: Adding container display as per revision specification 7.1.2 -->
				<xsl:if test="count(container) &gt; 0">
					<p>
						<strong>Container(s): </strong>
						<xsl:apply-templates select="container" mode="c01"/>
					</p>
				</xsl:if>
				<!-- May 2015: Adding abstract, which had not previously been displayed -->
				<xsl:if test="count(abstract) &gt; 0">
					<p>
						<strong>Abstract: </strong>
						<xsl:apply-templates select="abstract"/>
					</p>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<!--non-unittitle,unitdate,unitid descriptive information-->
		<!-- This now only processes the following elements within <c01>.  The context at this
			point is <c01><did>.  Lower components are processed in a separate section -->
		<xsl:if test="string(following-sibling::acqinfo | following-sibling::accruals | following-sibling::custodhist | following-sibling::processinfo | following-sibling::separatedmaterial |
			physdesc | physloc | origination | note | following-sibling::odd |
			following-sibling::scopecontent | following-sibling::arrangement | following-sibling::bioghist  |
            following-sibling::accessrestrict | following-sibling::userestrict | following-sibling::note |
            following-sibling::altformavail) and parent::c01">

			<xsl:for-each select="following-sibling::acqinfo | following-sibling::accruals | following-sibling::custodhist | following-sibling::processinfo | following-sibling::separatedmaterial |
				physdesc | physloc | origination | note | following-sibling::odd |
				following-sibling::scopecontent | following-sibling::arrangement | following-sibling::bioghist  |
                following-sibling::accessrestrict | following-sibling::userestrict | following-sibling::note | 
                following-sibling::altformavail">
				<xsl:call-template name="archdesc_minor_children">
					<xsl:with-param name="withLabel">false</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
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
								<xsl:if test="following::arc[1]/@title">
									<xsl:attribute name="title">
										<xsl:value-of select="following::arc[1]/@title"/>
									</xsl:attribute>
									<xsl:attribute name="alt">
										<xsl:value-of select="following::arc[1]/@title"/>
									</xsl:attribute>
								</xsl:if>
							</img>
							<xsl:if test="string(daodesc)">
								<br/>
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
									<xsl:if test="following::arc[1]/@title">
										<xsl:attribute name="title">
											<xsl:value-of select="following::arc[1]/@title"/>
										</xsl:attribute>
										<xsl:attribute name="alt">
											<xsl:value-of select="following::arc[1]/@title"/>
										</xsl:attribute>
									</xsl:if>
								</img>
								<xsl:if test="string(daodesc)">
									<br/>
									<span class="daodesc">
										<xsl:apply-templates/>
									</span>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="arc[@show='replace' or @xlink:show='replace' or @show='new' or @xlink:show='new'] and
						arc[@actuate='onrequest' or @actuate='onRequest' or @xlink:actuate='onRequest']">
						&#160;
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
                            <xsl:value-of select="@title"/><br/>
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
