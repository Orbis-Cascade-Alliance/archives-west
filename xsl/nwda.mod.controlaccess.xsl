<?xml version="1.0" encoding="UTF-8"?>
<!--
Original code by stephen.yearl@yale.edu, 2003-04-25
Modifications and Revisions by Mark Carlson, 2004
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo ead">
	<!-- ********************* <CONTROLACCESS> *********************** -->
  
  <!-- Match on controlaccess and display all terms -->
  <xsl:template match="controlaccess">
		<div id="{$controlaccess_id}">
			<h2>
				<xsl:value-of select="$controlaccess_head"/>
        <button type="button" class="glyphicon glyphicon-triangle-bottom" id="toggle-controlaccess" aria-controls="controlaccess-content" aria-expanded="true">
          <xsl:attribute name="title">
            <xsl:text>Close </xsl:text>
            <xsl:value-of select="$controlaccess_head"/>
          </xsl:attribute>
        </button>
				<small>
					<a href="#top"><span class="glyphicon glyphicon-arrow-up"> </span>Return to Top</a>
				</small>
			</h2>

			<div class="controlaccess" id="controlaccess-content">

				<!-- handle controlled access terms -->
				<xsl:call-template name="display-term">
          <xsl:with-param name="name">subject</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">persname</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template> 
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">corpname</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template> 
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">famname</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">name</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template> 
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">geogname</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">genreform</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template> 
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">occupation</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">function</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="display-term">
          <xsl:with-param name="name">title</xsl:with-param>
          <xsl:with-param name="encodinganalog">not700</xsl:with-param>
        </xsl:call-template>

				<!-- handle other creator names which start 700+ @encodinganalogs -->
        <xsl:if test="descendant::*[not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')][not(processing-instruction())]">
					<h3>Other Creators</h3>
					<ul class="ca_list">	
						<li>
							<xsl:call-template name="display-term">
                <xsl:with-param name="name">persname</xsl:with-param>
                <xsl:with-param name="encodinganalog">is700</xsl:with-param>
              </xsl:call-template> 
              <xsl:call-template name="display-term">
                <xsl:with-param name="name">corpname</xsl:with-param>
                <xsl:with-param name="encodinganalog">is700</xsl:with-param>
              </xsl:call-template> 
              <xsl:call-template name="display-term">
                <xsl:with-param name="name">famname</xsl:with-param>
                <xsl:with-param name="encodinganalog">is700</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="display-term">
                <xsl:with-param name="name">name</xsl:with-param>
                <xsl:with-param name="encodinganalog">is700</xsl:with-param>
              </xsl:call-template> 
						</li>
					</ul>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
  
  <!-- Check if descendent with a given name that does not have encodinganalog 7** should be displayed -->
  <xsl:template name="check-descendant">
    <xsl:param name="name" />
    <xsl:choose>
      <xsl:when test="descendant::*[name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))][not(processing-instruction())]">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Check if descendent with a given name that does have encodinganalog 7** should be displayed -->
  <xsl:template name="check-descendant-700">
    <xsl:param name="name" />
    <xsl:choose>
      <xsl:when test="descendant::*[name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')][not(processing-instruction())]">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Check and display a given type of term -->
  <xsl:template name="display-term">
    <xsl:param name="name" />
    <xsl:param name="encodinganalog" />
    <xsl:choose>
      <xsl:when test="$encodinganalog='not700'">
        <xsl:variable name="display">
          <xsl:call-template name="check-descendant">
            <xsl:with-param name="name" select="$name" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$display='true'">
          <xsl:call-template name="generate-list">
            <xsl:with-param name="name" select="$name" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="display">
          <xsl:call-template name="check-descendant-700">
            <xsl:with-param name="name" select="$name" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$display='true'">
          <xsl:call-template name="generate-list">
            <xsl:with-param name="name" select="$name" />
            <xsl:with-param name="other">true</xsl:with-param>
            <xsl:with-param name="level">h4</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

	<xsl:template name="generate-list">
		<xsl:param name="name"/>
		<xsl:param name="other"/>
		<xsl:param name="level">
			<xsl:text>h3</xsl:text>
		</xsl:param>
		
		<xsl:choose>
			<xsl:when test="$level='h3'">
				<h3>
					<xsl:call-template name="controlaccess_heads">
						<xsl:with-param name="name">
							<xsl:value-of select="$name"/>
						</xsl:with-param>
					</xsl:call-template>
				</h3>
			</xsl:when>
			<xsl:when test="$level='h4'">
				<h4>
					<xsl:call-template name="controlaccess_heads">
						<xsl:with-param name="name">
							<xsl:value-of select="$name"/>
						</xsl:with-param>
					</xsl:call-template>
				</h4>
			</xsl:when>
		</xsl:choose>
		<ul class="ca_list">
		<xsl:choose>
			<xsl:when test="$other='true'">
				<xsl:apply-templates select="descendant::*[name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][starts-with(@encodinganalog, '7')][not(processing-instruction())]" mode="controlaccess">
					<xsl:sort/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="descendant::*[name()=$name][not(@audience='internal')][not(@altrender='nodisplay')][string-length(text()|*)!=0][not(starts-with(@encodinganalog, '7'))][not(processing-instruction())]" mode="controlaccess">
					<xsl:sort/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
		</ul>
	</xsl:template>

	<xsl:template match="*" mode="controlaccess">
		<li>
			<xsl:apply-templates select="."/>
			<xsl:if test="@role and not(@role='subject')">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@role"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template name="controlaccess_heads">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name='corpname'"> Corporate Names </xsl:when>
			<xsl:when test="$name='famname'"> Family Names </xsl:when>
			<xsl:when test="$name='function'"> Functions </xsl:when>
			<xsl:when test="$name='geogname'"> Geographical Names </xsl:when>
			<xsl:when test="$name='genreform'"> Form or Genre Terms </xsl:when>
			<xsl:when test="$name='name'"> Other Names </xsl:when>
			<xsl:when test="$name='occupation'"> Occupations </xsl:when>
			<xsl:when test="$name='persname'"> Personal Names </xsl:when>
			<xsl:when test="$name='subject'"> Subject Terms </xsl:when>
			<xsl:when test="$name='title'"> Titles within the Collection </xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<!-- ********************* </CONTROLACCESS HEADINGS> *********************** -->
	<!-- ********************* </CONTROLACCESS> *********************** -->
</xsl:stylesheet>
