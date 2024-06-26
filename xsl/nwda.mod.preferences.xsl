<?xml version="1.0" encoding="UTF-8"?>
<!--

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="ead fo rdf" version="1.0">
	<!-- ********************* <PREFERENCES.USAGE> *********************** -->
	<!--USER definided-->

	<xsl:variable name="serverURL">https://archiveswest.orbiscascade.org</xsl:variable>
  <xsl:variable name="homepage">https://archiveswest.orbiscascade.org</xsl:variable>

	<!-- if 'true', will expand abbr/expan elements and attributes: Autograph Letter Signed (ALS)-->
	<xsl:variable name="expandAbbr">true</xsl:variable>
	
  <!-- if 'true', will display profiledesc/creation with $creation_label-->
	<xsl:variable name="showCreation">false</xsl:variable>
	
  <!-- if 'true', will display revisiondesc/creation with $revision_label-->
	<xsl:variable name="showRevision">false</xsl:variable>
	
  <!-- if 'true', will group controlled access points: all persnames together, for example-->
	<xsl:variable name="groupControlaccess">false</xsl:variable>
	<xsl:variable name="file" select="translate(//*[local-name()='ead']/@id, ' ', '')"/>
	<xsl:variable name="dscOrder">bfu</xsl:variable>
	
	<!-- ********************* </PREFERENCES.USAGE> *********************** -->

	<!-- ********************* <SECTION HEADS> *********************** -->
	<!--virtual-->
	<xsl:param name="admininfo_head">Administrative Information</xsl:param>
	<xsl:param name="admininfo_id">admininfoID</xsl:param>
	<xsl:param name="overview_head">Overview of the Collection</xsl:param>
	<xsl:param name="overview_id">overvireID</xsl:param>
	<xsl:param name="relatedinfo_head">Related Information</xsl:param>
	<xsl:param name="relatedinfo_id">relatedinfoID</xsl:param>
	<xsl:param name="useinfo_head">Use of the Collection</xsl:param>
	<xsl:param name="useinfo_id">useinfoID</xsl:param>
	<!--actual-->
	<xsl:param name="arrangement_head">Arrangement</xsl:param>
	<xsl:param name="arrangement_label">Arrangement</xsl:param>
	<xsl:param name="arrangement_id">arrangementID</xsl:param>
	<xsl:param name="bioghist_id">bioghistID</xsl:param>
	<xsl:param name="bioghist_head">Biographical Note</xsl:param>
	<xsl:param name="historical_id">historicalID</xsl:param>
	<xsl:param name="historical_head">Historical Note</xsl:param>
	<xsl:param name="dsc_head">Detailed Description of the Collection</xsl:param>
	<xsl:param name="dsc_id">dscID</xsl:param>
	<xsl:param name="odd_head">Other Descriptive Information</xsl:param>
	<!-- carlsonm mod 2004-07-09 adding a param for the 'Historical Background' heading -->
	<xsl:param name="odd_head_histbck">Historical Background</xsl:param>
	<!-- end carlsonm mod -->
	<xsl:param name="scopecontent_head">Content Description</xsl:param>
	<xsl:param name="scopecontent_label">Content Description</xsl:param>
	<xsl:param name="scopecontent_id">scopecontentID</xsl:param>
	<xsl:param name="controlaccess_head">Names and Subjects</xsl:param>
	<xsl:param name="controlaccess_id">caID</xsl:param>
	<xsl:param name="othercreators_head">Other Creators</xsl:param>
	<xsl:param name="othercreators_id">ocID</xsl:param>
	<xsl:param name="index_head">Index</xsl:param>
	<xsl:template name="section_head">
		<xsl:param name="structhead"/>
		<h3>
			<xsl:value-of select="$structhead"/>
		</h3>
	</xsl:template>
	<!-- ********************* </SECTION HEADS> *********************** -->

	<!-- ********************* <LABELS> *********************** -->
	<!-- March 2015 note: if NWDA migrates to an XSLT 2.0 processor, recommending normalization based on local-name() in an XSL function -->
	<!--Section heads and other labels will default to these values if there is no head or labal present in the EAD original-->
	<xsl:param name="label_style">asis</xsl:param>
	<!-- refers to css sheet. current valid values are caps, smcaps, titlecase, asis-->
	<!--misc-->
	<xsl:param name="sponsor_label">Sponsor</xsl:param>
	<xsl:param name="creation_label">Created</xsl:param>
	<xsl:param name="revision_label">Revisions</xsl:param>
	<!--did children-->
	<xsl:param name="abstract_label">Summary</xsl:param>
	<xsl:param name="abstract_id">abstractID</xsl:param>
	<xsl:param name="dates_label">Dates</xsl:param>
	<xsl:param name="dates_id">datesID</xsl:param>
	<xsl:param name="contactinformation_label">Repository</xsl:param>
	<xsl:param name="contactinformation_id">contactinformationID</xsl:param>
	<xsl:param name="collectionNumber_label">Collection Number</xsl:param>
	<xsl:param name="collectionNumber_id">collectionNumberID</xsl:param>
	<xsl:param name="origination_label">Creator</xsl:param>
	<xsl:param name="origination_id">originationID</xsl:param>
	<xsl:param name="rightsstatement_label">Rights Statement</xsl:param>
	<xsl:param name="copyright_label">Copyright</xsl:param>
	<!--"Collector" is also allowed-->
	<xsl:param name="physdesc_label">Quantity</xsl:param>
	<xsl:param name="physdesc_id">physdescID</xsl:param>
	<xsl:param name="physloc_label">Location of Collection</xsl:param>
	<xsl:param name="physloc_id">physlocID</xsl:param>
	<xsl:param name="phystech_label">Preservation Note</xsl:param>
	<xsl:param name="phystech_id">phystechID</xsl:param>
	<xsl:param name="unittitle_label">Title</xsl:param>
	<xsl:param name="unittitle_id">unittitleID</xsl:param>
	<xsl:param name="unitdate_label">Dates</xsl:param>
	<xsl:param name="unitdate_id">unitdateID</xsl:param>
	<xsl:param name="unitid_label">Unit ID</xsl:param>
	<xsl:param name="unitid_id">unitidID</xsl:param>
	<!--did siblings-->
	<xsl:param name="accessrestrict_label">Access Restrictions</xsl:param>
	<xsl:param name="accessrestrict_id">accessrestrictID</xsl:param>
	<xsl:param name="accruals_label">Future Additions</xsl:param>
	<xsl:param name="accruals_id">accrualsID</xsl:param>
	<xsl:param name="acqinfo_label">Acquisition Information</xsl:param>
	<xsl:param name="acqinfo_id">acqinfoID</xsl:param>
	<xsl:param name="altformavail_label">Alternative Forms Available</xsl:param>
	<xsl:param name="altformavail_id">altformavailID</xsl:param>
	<xsl:param name="appraisal_label">Appraisal Notes</xsl:param>
	<xsl:param name="appraisal_id">appraisalID</xsl:param>
	<xsl:param name="bibliography_label">Bibliography</xsl:param>
	<xsl:param name="bibliography_id">bibliographyID</xsl:param>
	<xsl:param name="custodhist_label">Custodial History</xsl:param>
	<xsl:param name="custodhist_id">custodhistID</xsl:param>
	<xsl:param name="fileplan_label">Fileplan</xsl:param>
	<xsl:param name="fileplan_id">fileplanID</xsl:param>
	<xsl:param name="index_label">Index</xsl:param>
	<xsl:param name="index_id">indexID</xsl:param>
	<xsl:param name="langmaterial_label">Languages</xsl:param>
	<xsl:param name="langmaterial_id">languagesID</xsl:param>
	<xsl:param name="odd_label">Other Descriptive Information</xsl:param>
	<xsl:param name="odd_id">oddID</xsl:param>
	<xsl:param name="originalsloc_label">Location of Originals</xsl:param>
	<xsl:param name="originalsloc_id">originalslocID</xsl:param>
	<xsl:param name="otherfindaid_label">Additional Reference Guides</xsl:param>
	<xsl:param name="otherfindaid_id">otherfindaidID</xsl:param>
	<xsl:param name="prefercite_label">Preferred Citation</xsl:param>
	<xsl:param name="prefercite_id">preferciteID</xsl:param>
	<xsl:param name="processinfo_label">Processing Note</xsl:param>
	<xsl:param name="processinfo_id">processinfoID</xsl:param>
	<xsl:param name="relatedmaterial_label">Related Materials</xsl:param>
	<xsl:param name="relatedmaterial_id">relatedmaterialID</xsl:param>
	<xsl:param name="separatedmaterial_label">Separated Materials</xsl:param>
	<xsl:param name="separatedmaterial_id">separatedmaterialID</xsl:param>
	<xsl:param name="userestrict_label">Restrictions on Use</xsl:param>
	<xsl:param name="userestrict_id">userestrictID</xsl:param>
	<xsl:param name="generalnote_label">General note</xsl:param>
	<xsl:param name="generalnote_id">generalnoteID</xsl:param>
	<xsl:param name="localnote_label">Local note</xsl:param>
	<xsl:param name="localnote_id">localnoteID</xsl:param>
	<xsl:param name="languagenote_label">Language note</xsl:param>
	<xsl:param name="languagenote_id">languagenoteID</xsl:param>
	<xsl:param name="acknowledgement_label">Acknowledgements</xsl:param>
	<xsl:param name="acknowledgement_id">acknowledgementID</xsl:param>
	<!-- ********************* </LABELS> *********************** -->
</xsl:stylesheet>
