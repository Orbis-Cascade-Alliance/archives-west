<?xml version="1.0" encoding="UTF-8"?>

<!-- This stylesheet is for generating the table of contents sidebar	
	Edited September 2007 by Ethan Gruber, 
	Rewritten into HTML5/Bootstrap in 2015 by Ethan Gruber -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="fo ead">
	<!-- ********************* <TABLE OF CONTENTS> *********************** -->
	<!-- TOC TEMPLATE - creates Table of Contents -->
	<xsl:template name="toc">

		<h2>Table of Contents <button type="button" id="toc-toggle" class="glyphicon glyphicon-triangle-bottom" aria-controls="toc-ul" aria-expanded="true">Close Table of Contents</button>
    </h2>
		<ul id="toc-ul" class="list-unstyled">
			<xsl:if test="did">
				<li>
					<a href="#overview" id="showoverview">
						<xsl:value-of select="$overview_head"/>
					</a>
				</li>
			</xsl:if>
			<xsl:if test="string(bioghist)">
				<li>
					<xsl:for-each select="bioghist">
						<xsl:choose>
							<xsl:when test="./head/text()='Biographical Note'">
								<a href="#{$bioghist_id}" class="showbioghist">
									<xsl:value-of select="$bioghist_head"/>
								</a>
							</xsl:when>
							<!--carlsonm mod 2004-07-09 only use bio head when encodinganalog is 5450 as opposed to 5451 -->
							<xsl:when test="starts-with(@encodinganalog, '5450')">
								<a href="#{$bioghist_id}" class="showbioghist">
									<xsl:value-of select="$bioghist_head"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="#{$historical_id}" class="showbioghist">
									<xsl:value-of select="$historical_head"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
						<br/>
					</xsl:for-each>
				</li>
			</xsl:if>
			<xsl:if test="string(odd/*)">
				<xsl:for-each select="odd[not(@audience='internal')]">
					<li>
						<a href="#{$odd_id}" class="ltoc1">
							<xsl:choose>
								<xsl:when test="@type='hist'">
									<xsl:value-of select="$odd_head_histbck"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$odd_label"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</li>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="string(scopecontent)">
				<li>
					<a href="#{$scopecontent_id}" class="showscopecontent">
						<xsl:value-of select="$scopecontent_head"/>
					</a>
				</li>
			</xsl:if>
			<xsl:if test="(string(userestrict)) or (string(altformavail))">
				<li>
					<button type="button" class="glyphicon glyphicon-triangle-right" id="toggle-use" aria-controls="use-content" aria-expanded="false">
            <xsl:text>Open </xsl:text>
            <xsl:value-of select="$useinfo_head"/>
            <xsl:text> Contents</xsl:text>
          </button>
					<a href="#{$useinfo_id}" class="showuseinfo">
						<xsl:value-of select="$useinfo_head"/>
					</a>
					<ul style="display:none" class="list-unstyled use-content" id="use-content">
						<xsl:if test="string(altformavail)">
							<li>
								<a href="#{$altformavail_id}" class="showuseinfo">
									<xsl:value-of select="$altformavail_label"/>
								</a>
							</li>
						</xsl:if>						
						<xsl:if test="string(userestrict)">
							<li>
								<a href="#{$userestrict_id}" class="showuseinfo">
									<xsl:value-of select="$userestrict_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(prefercite)">
							<li>
								<a href="#{$prefercite_id}" class="showuseinfo">
									<xsl:value-of select="$prefercite_label"/>
								</a>
							</li>
						</xsl:if>
					</ul>
				</li>
			</xsl:if>

			<!-- ADMINISTRATIVE INFO -->
			<xsl:if test="string(arrangement) or string(custodhist) or string(acqinfo)       or string(processinfo) or
				string(accruals) or      string(separatedmaterial) or string(originalsloc)     or string(bibliography) or
				string(otherfindaid) or string(relatedmaterial) or      string(index) or string(did/physloc)">
				<li>
					<button type="button" class="glyphicon glyphicon-triangle-right" id="toggle-admin" aria-controls="admin-content" aria-expanded="false">Open Administrative Information Contents</button>
					<a href="#administrative_info">
						<xsl:text>Administrative Information</xsl:text>
					</a>
					<ul style="display:none" class="list-unstyled" id="admin-content">
						<xsl:if test="string(arrangement)">
							<li>
								<a href="#{$arrangement_id}" class="showai">
									<xsl:value-of select="$arrangement_head"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(custodhist)">
							<li>
								<a href="#{$custodhist_id}" class="showai">
									<xsl:value-of select="$custodhist_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(acqinfo)">
							<li>
								<a href="#{$acqinfo_id}" class="showai">
									<xsl:value-of select="$acqinfo_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(accruals)">
							<li>
								<a href="#{$accruals_id}" class="showai">
									<xsl:value-of select="$accruals_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(processinfo)">
							<li>
								<a href="#{$processinfo_id}" class="showai">
									<xsl:value-of select="$processinfo_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(separatedmaterial)">
							<li>
								<a href="#{$separatedmaterial_id}" class="showai">
									<xsl:value-of select="$separatedmaterial_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(bibliography)">
							<li>
								<a href="#{$bibliography_id}" class="showai">
									<xsl:value-of select="$bibliography_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(otherfindaid)">
							<li>
								<a href="#{$otherfindaid_id}" class="showai">
									<xsl:value-of select="$otherfindaid_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(relatedmaterial)">
							<li>
								<a href="#{$relatedmaterial_id}" class="showai">
									<xsl:value-of select="$relatedmaterial_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(appraisal)">
							<li>
								<a href="#{$appraisal_id}" class="showai">
									<xsl:value-of select="$appraisal_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(did/physloc)">
							<li>
								<a href="#{$physloc_id}" class="showai">
									<xsl:value-of select="$physloc_label"/>
								</a>
							</li>
						</xsl:if>
						<xsl:if test="string(originalsloc)">
							<li>
								<a href="#{$originalsloc_id}" class="showai">
									<xsl:value-of select="$originalsloc_label"/>
								</a>
							</li>
						</xsl:if>
					</ul>
				</li>
			</xsl:if>
			<xsl:if test="string(dsc)">
				<li>
					<xsl:if test="//c02">
						<button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-dsc" aria-controls="dsc-content" aria-expanded="true">
              <xsl:text>Close </xsl:text>
              <xsl:value-of select="$dsc_head"/>
              <xsl:text> Contents</xsl:text>
            </button>
					</xsl:if>
					<a href="#{$dsc_id}" class="showdsc">
						<xsl:value-of select="$dsc_head"/>
					</a>
					<xsl:if test="//dsc[not(@type='in-depth')]">
						<xsl:call-template name="dsc_links"/>
					</xsl:if>
				</li>
			</xsl:if>
			<xsl:if test="string(controlaccess/*/subject) or string(controlaccess/subject)">
				<li>
					<a href="#{$controlaccess_id}" class="showcontrolaccess">
						<xsl:value-of select="$controlaccess_head"/>
					</a>
				</li>
			</xsl:if>
		</ul>

	</xsl:template>
	<xsl:template name="dsc_links">
    <ul class="list-unstyled" id="dsc-content">
      <xsl:for-each select="dsc/c01">
        <li>
          <xsl:if test="c02">
            <xsl:attribute name="class">expandable</xsl:attribute>
            <button type="button" class="glyphicon glyphicon-triangle-right" id="toggle-admin" aria-controls="admin-content" aria-expanded="false">
              <xsl:attribute name="aria-controls">
                <xsl:text>toc_</xsl:text>
                <xsl:value-of select="generate-id(.)"/>
              </xsl:attribute>
              <xsl:text>Open contents of </xsl:text>
              <xsl:call-template name="c0x_heading_text" />
            </button>
          </xsl:if>
          <xsl:call-template name="c0x_heading_link"/>
          <xsl:if test="c02">
            <ul>
            <xsl:attribute name="id">
              <xsl:text>toc_</xsl:text>
              <xsl:value-of select="generate-id(.)"/>
            </xsl:attribute>
            <xsl:for-each select="c02">
              <li>
                <xsl:call-template name="c0x_heading_link"/>
              </li>
            </xsl:for-each>
            </ul>
          </xsl:if>
        </li>
      </xsl:for-each>
    </ul>
	</xsl:template>
	<!-- ********************* </TABLE OF CONTENTS> *********************** -->
</xsl:stylesheet>
