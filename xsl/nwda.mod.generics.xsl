<?xml version="1.0" encoding="UTF-8"?>
<!--
Original coding by stephen.yearl@yale.edu 2003-04-25
Revisions and modifications by Mark Carlson 2004
Major or significant revision history:
2004-07-14 fix daoloc display
2004-07-14 treat <chronitem> separately
2004-07-14 code to treat chronlist differently
2004-09-27 adding test to remove excess space if <p> is in <dsc> 
2004-11-30 add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd>
2004-12-07 put chronlist into a table format instead of a def list
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="ead xs xlink fo" version="1.0">
	
	<!--links-->
	<xsl:template match="ref">
		<xsl:element name="a">
      <xsl:attribute name="class">xref</xsl:attribute>
			<xsl:attribute name="href">#<xsl:value-of select="@target"/>
			</xsl:attribute>
			<xsl:value-of select="parent::p/text()"/>
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:if test="following-sibling::ref">
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="extref">
		<xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="@href">
            <xsl:value-of select="@href"/>
          </xsl:when>
          <xsl:when test="@xlink:href">
            <xsl:value-of select="@xlink:href"/>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
	  <xsl:if test="@id">
	    <xsl:attribute name="id">
		  <xsl:value-of select="@id"/>
		</xsl:attribute>
	  </xsl:if>
      <xsl:attribute name="target">_blank</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!--<xsl:template match="daogrp">
		<xsl:apply-templates select="daoloc"/>
	</xsl:template>-->
	<xsl:template match="dao">
		<a target="new">
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>. <xsl:value-of select="@content-role"/>
			</xsl:attribute>
			<xsl:value-of select="daodesc"/>
		</a>
	</xsl:template>

	<xsl:template match="abbr">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="./@expan"/>&#160;( <xsl:value-of select="."/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="expan">
		<xsl:choose>
			<xsl:when test="$expandAbbr='true'">
				<xsl:value-of select="."/>&#160;( <xsl:value-of select="./@abbr"/>) </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="item | indexentry">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template match="bibref">
		<span>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="eventgrp" mode="chronlist">
		<xsl:for-each select="event">
			<xsl:apply-templates/>
			<br/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="defitem">
		<li>
			<xsl:if test="./label">
				<b>
					<xsl:value-of select="label"/>
				</b>: </xsl:if>
			<xsl:value-of select="item"/>
		</li>
	</xsl:template>
	<!-- 2004-07-14 carlsonm mod to treat chronlist differently -->
	<!-- 2004-12-07 carlsonm: put chronlist into a table format instead of a def list -->
	<!-- 2015-06-15 Ethan Gruber: put chronlist back into a bootstrap 3 horizontal def list -->

	<xsl:template match="chronlist">
		<xsl:if test="head">
			<h5>
				<xsl:apply-templates select="head"/>
			</h5>
		</xsl:if>

		<dl class="dl-horizontal">
			<xsl:apply-templates select="./*[not(self::head)]"/>
		</dl>

	</xsl:template>

	<xsl:template match="chronitem">
		<dt>
			<xsl:apply-templates select="date"/>
		</dt>
		<!-- 2004-11-30 Carlson mod add code to process <eventgrp>.  See OSU SC "Pauling" in <bioghist> or OSU Archives "Board of Regents" in <odd> -->
		<dd>
			<xsl:choose>
				<xsl:when test="event">
					<xsl:apply-templates select="event"/>
				</xsl:when>
				<xsl:when test="eventgrp">
					<xsl:apply-templates select="eventgrp" mode="chronlist"/>
				</xsl:when>
			</xsl:choose>
		</dd>
	</xsl:template>

	<xsl:template match="list | index">
		<xsl:if test="head">
			<h5>
				<xsl:apply-templates select="head"/>
			</h5>
		</xsl:if>
		<xsl:if test="item or defitem or indexentry">
			<ul>			
				<xsl:apply-templates select="item|defitem|indexentry"/>
			</ul>
		</xsl:if>		
	</xsl:template>

	<xsl:template match="fileplan | bibliography">
		<xsl:if test="head">
			<h5>
				<xsl:apply-templates select="head"/>
			</h5>
		</xsl:if>
		<xsl:apply-templates select="./*[not(self::head)]"/>
	</xsl:template>

	<!-- where would an archivist be without... "misc"-->
	<xsl:template match="change">
		<xsl:apply-templates select="./item"/>&#160;( <xsl:apply-templates select="./date"/>) </xsl:template>
	<xsl:template match="*[@altrender='nodisplay']"/>

	<!--ultra generics-->
	<xsl:template match="emph[not(@render)]">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>

	<xsl:template match="lb">
		<br/>
	</xsl:template>
	
	<xsl:template match="unittitle">
		<xsl:for-each select=".//text()">
			<xsl:text> </xsl:text>
			<xsl:value-of select="normalize-space()"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="unitdate">
		<xsl:apply-templates/>
		<xsl:text> </xsl:text>
		<!-- 2004-07-16 carlsonm mod Do not display @type if c02+ -->
		<xsl:if test="@type and not(ancestor::c01)">&#160; <xsl:text/>( <xsl:value-of select="@type"/>) </xsl:if>
	</xsl:template>

	<xsl:template match="unitid" mode="archdesc">
		<span property="dcterms:identifier" content="{.}">
			<xsl:value-of select="."/>
			<xsl:if test="@type">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@type"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:if test="not(position() = last())">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</span>
	</xsl:template>

	<xsl:template match="unitdate" mode="archdesc">
		<xsl:value-of select="."/>
		<xsl:if test="@type">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="@type"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:if test="@normal">
			<div class="hidden">
				<xsl:choose>
					<xsl:when test="contains(@normal, '/')">
						<xsl:variable name="start" select="substring-before(@normal, '/')"/>
						<xsl:variable name="end" select="substring-after(@normal, '/')"/>


						<xsl:choose>
							<xsl:when test="@type='bulk'">
								<span content="{$start}" property="arch:bulkStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$start"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$start"/>
								</span>
								<span content="{$end}" property="arch:bulkEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$end"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$end"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span content="{$start}" property="arch:inclusiveStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$start"/>
										</xsl:call-template>
									</xsl:attribute>

									<xsl:value-of select="$start"/>
								</span>
								<span content="{$end}" property="arch:inclusiveEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="$end"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="$end"/>
								</span>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="@type='bulk'">
								<span content="{@normal}" property="arch:bulkStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
								<span content="{@normal}" property="arch:bulkEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<span content="{@normal}" property="arch:inclusiveStart">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
								<span content="{@normal}" property="arch:inclusiveEnd">
									<xsl:attribute name="datatype">
										<xsl:call-template name="unitdate-datatype">
											<xsl:with-param name="date" select="@normal"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="@normal"/>
								</span>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:otherwise>
				</xsl:choose>
			</div>

		</xsl:if>
		<xsl:if test="not(position() = last())">
			<br/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="unitdate-datatype">
		<xsl:param name="date"/>
		<xsl:attribute name="datatype">xsd:gYear</xsl:attribute>
	</xsl:template>

	<!-- March 2015: For displaying the container within c01/did. Revision specification 7.1.2 -->
	<xsl:template match="container" mode="c01">
		<xsl:if test="@type">
			<xsl:value-of select="concat(translate(substring(@type, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring(@type, 2))"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="."/>
		<xsl:if test="not(position()=last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="extent">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<span property="dcterms:extent">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, </xsl:text>
				<span property="dcterms:extent" content="{.}">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="."/>
					<xsl:text>)</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
	</xsl:template>
	<xsl:template match="controlaccess[@type='lower']">
		<xsl:value-of select="name()"/>
		<xsl:apply-templates>
			<xsl:sort order="ascending" data-type="text"/>
		</xsl:apply-templates>
		<br/>
	</xsl:template>
	<xsl:template match="address">
		<p class="address">
			<!-- the following code distinguishes between a text-only address line and a url or email address -->
			<xsl:for-each select="addressline">
				<xsl:choose>
					<!-- if the addressline contains http://, a href is created -->
					<xsl:when test="contains(normalize-space(.), 'http://')">
						<xsl:choose>
							<xsl:when test="substring-before(normalize-space(.), 'http://')">
								<xsl:value-of select="substring-before(normalize-space(.), 'http://')"/>
								<a href="http://{substring-after(normalize-space(.), 'http://')}" target="_blank">
									<xsl:text>http://</xsl:text>
									<xsl:value-of select="substring-after(normalize-space(.), 'http://')"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="{normalize-space(.)}" target="_blank">
									<xsl:value-of select="normalize-space(.)"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="not(position() = last())">
							<br/>
						</xsl:if>
					</xsl:when>
					<!-- if the @ symbol is contained, it is assumed to be an email address -->
					<xsl:when test="contains(normalize-space(.), '@')">
						<xsl:choose>
							<!-- if email address is preceded by a space, i. e. "Email: foo@bar.com", only the foo@bar.com is made a mailto link -->
							<xsl:when test="contains(normalize-space(.), ' ')">
								<xsl:value-of select="substring-before(normalize-space(.), ' ')"/>
								<xsl:text> </xsl:text>
								<a href="mailto:{substring-after(normalize-space(.), ' ')}">
									<xsl:value-of select="substring-after(normalize-space(.), ' ')"/>
								</a>
								<!-- insert break only if it's not the last line.  this will cut back on unnecessary whitespace -->
								<xsl:if test="not(position() = last())">
									<br/>
								</xsl:if>
							</xsl:when>
							<!-- otherwise, the whole line is.  this is assuming these are the only two options seen.  standards in email and http 
								address lines should be further developed -->
							<xsl:otherwise>
								<a href="mailto:{normalize-space(.)}">
									<xsl:value-of select="normalize-space(.)"/>
								</a>
								<xsl:if test="not(position() = last())">
									<br/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:if test="not(position() = last())">
							<br/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:for-each>
		</p>
	</xsl:template>
	<xsl:template match="div">
		<p class="div">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="title">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="*[@type='restricted']">
		<span class="restricted">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>
	<!-- ********************* <* @render> *********************** -->
	<xsl:template match="*[@render]">
		<xsl:choose>
			<xsl:when test="@render='bold'">
				<b>
					<xsl:apply-templates/>
				</b>
			</xsl:when>
			<xsl:when test="@render='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@render='bolditalic'">
				<b>
					<i>
						<xsl:apply-templates/>
					</i>
				</b>
			</xsl:when>
			<xsl:when test="@render='underline'">
				<u>
					<xsl:apply-templates/>
				</u>
			</xsl:when>
			<xsl:when test="@render='boldunderline'">
				<b>
					<u>
						<xsl:apply-templates/>
					</u>
				</b>
			</xsl:when>
			<xsl:when test="@render='quoted'">&quot; <xsl:apply-templates/>&quot; </xsl:when>
			<xsl:when test="@render='doublequote'">&quot; <xsl:apply-templates/>&quot; </xsl:when>
			<xsl:when test="@render='bolddoublequote'">
				<b>&quot; <xsl:apply-templates/>&quot; </b>
			</xsl:when>
			<xsl:when test="@render='nonproport'">
				<font style="font-family: 'Courier New', Cumberland ">
					<xsl:apply-templates/>
				</font>
			</xsl:when>
			<xsl:when test="@render='singlequote'">&apos; <xsl:apply-templates/>&apos; </xsl:when>
			<xsl:when test="@render='boldsinglequote'">
				<b>&quot; <xsl:apply-templates/>&apos; </b>
			</xsl:when>
			<xsl:when test="@render='sub'">
				<sub>
					<xsl:apply-templates/>
				</sub>
			</xsl:when>
			<xsl:when test="@render='super'">
				<sup>
					<xsl:apply-templates/>
				</sup>
			</xsl:when>
			<xsl:when test="@render='smcaps'">
				<font style="font-variant: small-caps">
					<xsl:apply-templates/>
				</font>
			</xsl:when>
			<xsl:when test="@render='boldsmcaps'">
				<b>
					<font style="font-variant: small-caps">
						<xsl:apply-templates/>
					</font>
				</b>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ********************* </* @render> *********************** -->
</xsl:stylesheet>
