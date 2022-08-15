<?xml version="1.0" encoding="UTF-8"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <axsl:import href="verbid.xsl"/>
   <axsl:output method="html"/><!--
	This stylesheet was generated automatically from 'creatstyles.xsl'.
	Last modified unknown.
Copyright (C) 2004 Aziza Technology Associates, LLC Pittsburgh, PA 
 http://www.azizatech.com
 This program is free software; you can redistribute it and/or modify 
 it under the terms of the Mozilla Public License available at 
http://www.mozilla.org/MPL/

 This program is distributed in the hope that it will be useful, 
 but WITHOUT ANY WARRANTY; without even the implied warranty of 
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
 

	This stylesheet produces a version that can be used in a dynamic implementation. 
You can specify the values of the parameters at the commandline or through a parameter fed through a form to the XSLT processor.
$all = yes By default this will test against all guidelines (M, MA, Req, Opt, Rec). If  switched to 'no' only  those elements and attributes codified as M, MA and Req will be processed.

$sourcedoc is ignored in the dynamic version

This stylesheet was generated automatically from 'createbpgstyles.xsl' by  URL -->
   <axsl:param name="all">yes</axsl:param>
   <axsl:param name="doctitle">//eadheader//titleproper</axsl:param>
   <axsl:template match="/">
            <h1>Report for <axsl:value-of select="//eadheader//titleproper"/>
            </h1>
            <axsl:choose>
               <axsl:when test="$all='yes'">
                  <p>Reporting both Mandatory and Optional Guidelines</p>
               </axsl:when>
               <axsl:otherwise>
                  <p>Reporting Only Mandatory Guidelines</p>
               </axsl:otherwise>
            </axsl:choose>
   EAD Best Practices (version 3.8)
   <h2>Table 1 &lt;ead&gt;, &lt;eadheader&gt;</h2>
            <table border="1" width="100%" rules="all">
               <tbody>
                  <tr>
                     <th width="20%">Element Location</th>
                     <th width="15%">Attributes or Child Elements</th>
                     <th width="5%">Status</th>
                     <th width="40%">Comments/Application Notes</th>
                     <th width="20%">Possible Values</th>
                  </tr>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader">
                        <axsl:for-each select="ead/eadheader">
                           <axsl:choose>
                              <axsl:when test="@langencoding">
                                 <axsl:choose>
                                    <axsl:when test="@langencoding='iso639-2b'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>langencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@langencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e21">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Refers to the standard being used for language codes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e21')">View Comments/Application Notes</a>

				 </td>
                                          <td>'iso639-2b' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>langencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @langencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e21">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Refers to the standard being used for language codes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e21')">View Comments/Application Notes</a>

				 </td>
                                    <td>'iso639-2b' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@scriptencoding">
                                 <axsl:choose>
                                    <axsl:when test="@scriptencoding='iso15924'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>scriptencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@scriptencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e33">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Refers to the standard being used for script codes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e33')">View Comments/Application Notes</a>

				 </td>
                                          <td>'iso15924' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>scriptencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @scriptencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e33">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Refers to the standard being used for script codes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e33')">View Comments/Application Notes</a>

				 </td>
                                    <td>'iso15924' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@relatedencoding">
                                 <axsl:choose>
                                    <axsl:when test="@relatedencoding='dc'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>relatedencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@relatedencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e45">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Indicates a descriptive metadata system to which &lt;eadheader&gt;elements can be mapped. The intention of the &lt;eadheader&gt; elements is to provide more robust and uniform discovery metadata about the finding aid. The 
            <a href="http://dublincore.org/index.shtml">Dublin Core</a>

            (“dc”) metadata standard is an appropriate system for providing such access to EAD header information; therefore, the EAD Best Practices provides encoding analogs (mappings) to appropriate Dublin Core elements in the EAD header. To indicate that the Dublin Core is used, set the attribute value to “dc”. (Note that MARC 21 is the encoding system to which &lt;archdesc&gt; elements -- those describing the collection itself -- are mapped.)</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e45')">View Comments/Application Notes</a>

				 </td>
                                          <td>'dc' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>relatedencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @relatedencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e45">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Indicates a descriptive metadata system to which &lt;eadheader&gt;elements can be mapped. The intention of the &lt;eadheader&gt; elements is to provide more robust and uniform discovery metadata about the finding aid. The 
            <a href="http://dublincore.org/index.shtml">Dublin Core</a>

            (“dc”) metadata standard is an appropriate system for providing such access to EAD header information; therefore, the EAD Best Practices provides encoding analogs (mappings) to appropriate Dublin Core elements in the EAD header. To indicate that the Dublin Core is used, set the attribute value to “dc”. (Note that MARC 21 is the encoding system to which &lt;archdesc&gt; elements -- those describing the collection itself -- are mapped.)</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e45')">View Comments/Application Notes</a>

				 </td>
                                    <td>'dc' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@repositoryencoding">
                                 <axsl:choose>
                                    <axsl:when test="@repositoryencoding='iso15511'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>repositoryencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@repositoryencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e60">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Refers to the standard being used for authoritative repository codes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e60')">View Comments/Application Notes</a>

				 </td>
                                          <td>'iso15511' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>repositoryencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @repositoryencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e60">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Refers to the standard being used for authoritative repository codes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e60')">View Comments/Application Notes</a>

				 </td>
                                    <td>'iso15511' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@countryencoding">
                                 <axsl:choose>
                                    <axsl:when test="@countryencoding='iso3166-1'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>countryencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@countryencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e72">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Refers to the standard being used for authoritative country codes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e72')">View Comments/Application Notes</a>

				 </td>
                                          <td>'iso3166-1' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>countryencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @countryencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e72">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Refers to the standard being used for authoritative country codes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e72')">View Comments/Application Notes</a>

				 </td>
                                    <td>'iso3166-1' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@dateencoding">
                                 <axsl:choose>
                                    <axsl:when test="@dateencoding='iso8601'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader
				 </td>
                                          <td>dateencoding
= </td>
                                          <td>Req
				 </td>
                                          <td>@dateencoding is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e84">
                                                <h4>Comments/Application Notes for ead/eadheader</h4>
                                                <p>
                                                   <appnotes>Refers to the standard being used for authoritative date formats.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e84')">View Comments/Application Notes</a>

				 </td>
                                          <td>'iso8601' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader
				 </td>
                                    <td>dateencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @dateencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e84">
                                          <h4>Comments/Application Notes for ead/eadheader</h4>
                                          <p>
                                             <appnotes>Refers to the standard being used for authoritative date formats.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e84')">View Comments/Application Notes</a>

				 </td>
                                    <td>'iso8601' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader
&gt; does not appear in this document.<div class="appnotes" id="app.d0e15">
                                 <h4>Comments/Application Notes for ead/eadheader</h4>
                                 <p>
                                    <appnotes>Wrapper element for information about the finding aid document, rather than the archival materials being described in the bulk of the finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e15')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/eadid">
                        <axsl:for-each select="ead/eadheader/eadid">
                           <axsl:choose>
                              <axsl:when test="@countrycode">
                                 <axsl:choose>
                                    <axsl:when test="@countrycode[string-length()='2']"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/eadid
				 </td>
                                          <td>countrycode= </td>
                                          <td>Req
				 </td>
                                          <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e102">
                                                <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                                <p>
                                                   <appnotes>State in ISO 3166-1 format. Usually “us” (United States) for program participants.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e102')">View Comments/Application Notes</a>

				 </td>
                                          <td>Use  "iso3166-1" to format the attribute value.
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/eadid
				 </td>
                                    <td>countrycode=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @countrycode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e102">
                                          <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                          <p>
                                             <appnotes>State in ISO 3166-1 format. Usually “us” (United States) for program participants.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e102')">View Comments/Application Notes</a>

				 </td>
                                    <td> Use "iso3166-1" to format attribute value.
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@mainagencycode"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/eadid
				 </td>
                                    <td>mainagencycode=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @mainagencycode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e111">
                                          <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                          <p>
                                             <appnotes>Use the repository code supplied by the Library of Congress for your institution. The code should be formulated according to ISO 15511. Repository codes and instructions for requesting a new code may be found on the Library of Congress 
            <a href="http://www.loc.gov/marc/organizations/">MARC Code List for Organizations</a>

            Web page. Organizations that have different branches or divisions within them should request a separate repository code for each.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e111')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@identifier"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/eadid
				 </td>
                                    <td>identifier=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @identifier<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e124">
                                          <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                          <p>
                                             <appnotes>The &lt;eadid&gt; element must include a unique ARK (Archival Resource Key) in the IDENTIFIER attribute. An ARK is a machine-readable, persistent, and unique identifier.
<br/>

                                                <br/>
ARKs may be obtained either individually or in batches from the Utility Site; an ARK may not be formulated locally. Direct your browser to:
<br/>
               
                                                <a href="https://archiveswest.orbiscascade.org/tools" target="_blank">https://archiveswest.orbiscascade.org/tools</a>

                                                <br/>

                                                <br/>
               Provide your user name and password, and click on the login button. If you do not have an institutional user name and password, or if you cannot successfully access the ARK website, please contact Alliance staff (https://www.orbiscascade.org/alliance-staff/). In the next screen, enter the number of ARKs you would like to receive and submit the request.
<br/>

                                                <br/>
The resulting screen will present a table containing the number of ARKs requested in your query. For each ARK, the ARK itself is displayed in the “ARK ID” column; copy this value into the IDENTIFIER attribute in &lt;eadid&gt;.
<br/>

                                                <br/>
               The complete URL for the finding is displayed in the “URL” column. This URL may be copied to the URL attribute in the &lt;eadid&gt; element (although this is not required). The URL may also be used in EAD linking elements, such as linking from one finding aid to another in the database and in the 856 field of a MARC catalog record, for linking from the catalog record to the finding aid. See the <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">EAD Best Practices</a> for further guidance on linking.
<br/>

                                                <br/>
Note: If your institution requests ARKs in batches, make sure to keep track of your ARKs as they are assigned to your institution’s finding aids. Do not assign any one ARK to more than one finding aid. You may request ARKs from the utility site as often as needed.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e124')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@url"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/eadid
				 </td>
                                       <td>url=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @url<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e164">
                                             <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                             <p>
                                                <appnotes>If desired, enter here the URL of the finding aid obtained from the utility site. The format is:
               https://archiveswest.orbiscascade.org/ark:[fill in the assigned ARK, like 80444/xv06841/]
<br/>
Example:
<br/>

                                                   <br/>
https://archiveswest.orbiscascade.org/ark:80444/xv06841/</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e164')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='identifier'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/eadid
				 </td>
                                          <td>encodinganalog
= </td>
                                          <td>MA
				 </td>
                                          <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e178">
                                                <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                                <p>
                                                   <appnotes>Maps to URL.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e178')">View Comments/Application Notes</a>

				 </td>
                                          <td>'identifier' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/eadid
				 </td>
                                    <td>encodinganalog=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e178">
                                          <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                          <p>
                                             <appnotes>Maps to URL.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e178')">View Comments/Application Notes</a>

				 </td>
                                    <td>'identifier' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/eadid
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/eadid
&gt; does not appear in this document.<div class="appnotes" id="app.d0e100">
                                 <h4>Comments/Application Notes for ead/eadheader/eadid</h4>
                                 <p>
                                    <appnotes>EAD identifier. The content of this element, together with its attributes, uniquely identifies the EAD finding aid document. In the &lt;eadid&gt; element, recommended practice is to enter the filename of the finding aid. For details on naming finding aid files, see Naming and Saving a Document in the <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">EAD Best Practices</a>.<br/>
         
                                       <br/>
Format of the &lt;eadid&gt; element, if all attributes are used, is:<br/>

                                       <br/>
&lt;eadid countrycode=”us” mainagencycode=”[enter your institution’s MARC repository code]” identifier=”[enter assigned ARK]” url=”https://archiveswest.orbiscascade.org/ark:[fill in the finding aid’s assigned ARK, like 80444/xv06841/]”&gt;[fill in filename of finding aid, like WaPSMss065.xml]&lt;/eadid&gt;<br/>

                                       <br/>
Example:<br/>

                                       <br/>
&lt;eadid countrycode=”us” mainagencycode=”WaPS” identifier=”80444/xv60194” url=”https://archiveswest.orbiscascade.org/ark:80444/xv06841/”&gt;WaPSMss065.xml&lt;/eadid&gt;</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e100')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc">
                        <axsl:for-each select="ead/eadheader/filedesc"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e213">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc</h4>
                                 <p>
                                    <appnotes>Wrapper for bibliographic information about the finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e213')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/titlestmt
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/titlestmt
&gt; does not appear in this document.<div class="appnotes" id="app.d0e219">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt</h4>
                                 <p>
                                    <appnotes>Wrapper for finding aid title information.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e219')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/titleproper">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/titleproper">
                           <axsl:choose>
                              <axsl:when test="not(@type)">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog">
                                       <axsl:choose>
                                          <axsl:when test="@encodinganalog='title'"/>
                                          <axsl:otherwise>
                                             <tr>
                                                <td>ead/eadheader/filedesc/titlestmt/titleproper
				 </td>
                                                <td>encodinganalog
= </td>
                                                <td>Req
				 </td>
                                                <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                   <div class="appnotes" id="app.d0e227">
                                                      <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper</h4>
                                                      <p>
                                                         <appnotes>Mapped Dublin Core element.</appnotes>
                                                      </p>
                                                   </div>
                                                   <br/>
                                                   <a class="appnotes-link" onclick="getAppNotes('app.d0e227')">View Comments/Application Notes</a>

				 </td>
                                                <td>'title' 
				 </td>
                                             </tr>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/titlestmt/titleproper
				 </td>
                                          <td>encodinganalog=
					 </td>
                                          <td>Req
				 </td>
                                          <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e227">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper</h4>
                                                <p>
                                                   <appnotes>Mapped Dublin Core element.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e227')">View Comments/Application Notes</a>

				 </td>
                                          <td>'title' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise/>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/titlestmt/titleproper
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/titlestmt/titleproper
&gt; does not appear in this document.<div class="appnotes" id="app.d0e225">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper</h4>
                                 <p>
                                    <appnotes>Use for the formal title of the finding aid itself and not the title of the fonds or record group being described.(e.g., Guide to the Mike Mansfield Papers).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e225')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/titleproper/date">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/titleproper/date">
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                             <td>era
= </td>
                                             <td>Rec
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                       <td>era=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                             <td>calendar
= </td>
                                             <td>Rec
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                             <td>normal= </td>
                                             <td>Rec
				 </td>
                                             <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e263">
                                                   <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper/date</h4>
                                                   <p>
                                                      <appnotes>Enter normalized span dates in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

format (e.g., 1923/1996). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.

           </appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e263')">View Comments/Application Notes</a>

				 </td>
                                             <td>Use  "iso8601" to format the attribute value. 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                       <td>normal=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @normal<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e263">
                                             <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper/date</h4>
                                             <p>
                                                <appnotes>Enter normalized span dates in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

format (e.g., 1923/1996). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.

           </appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e263')">View Comments/Application Notes</a>

				 </td>
                                       <td> Use "iso8601" to format attribute value. 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='date'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e278">
                                                   <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper/date</h4>
                                                   <p>
                                                      <appnotes>Mapped Dublin Core element.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e278')">View Comments/Application Notes</a>

				 </td>
                                             <td>'date'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e278">
                                             <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper/date</h4>
                                             <p>
                                                <appnotes>Mapped Dublin Core element.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e278')">View Comments/Application Notes</a>

				 </td>
                                       <td>'date'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/titlestmt/titleproper/date
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/titlestmt/titleproper/date
&gt; does not appear in this document.<div class="appnotes" id="app.d0e243">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper/date</h4>
                                 <p>
                                    <appnotes>Use &lt;date&gt; element within the &lt;titleproper&gt; element. Used to encode span dates of described materials (e.g., 
         <b>1923-1996</b>

         ).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e243')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/subtitle">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/subtitle"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/filedesc/titlestmt/subtitle
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/eadheader/filedesc/titlestmt/subtitle
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e297">
                                    <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/subtitle</h4>
                                    <p>
                                       <appnotes>Used if finding aid has a subtitle.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e297')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']">
                           <axsl:choose>
                              <axsl:when test="@type">
                                 <axsl:choose>
                                    <axsl:when test="@type='filing'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
				 </td>
                                          <td>type
= </td>
                                          <td>Req
				 </td>
                                          <td>@type is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e305">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']</h4>
                                                <p>
                                                   <appnotes>Indicates that this instance of &lt;titleproper&gt; is intended for filing purposes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e305')">View Comments/Application Notes</a>

				 </td>
                                          <td>'filing' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
				 </td>
                                    <td>type=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @type<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e305">
                                          <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']</h4>
                                          <p>
                                             <appnotes>Indicates that this instance of &lt;titleproper&gt; is intended for filing purposes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e305')">View Comments/Application Notes</a>

				 </td>
                                    <td>'filing' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@altrender">
                                 <axsl:choose>
                                    <axsl:when test="@altrender='nodisplay'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
				 </td>
                                          <td>altrender
= </td>
                                          <td>Req
				 </td>
                                          <td>@altrender is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e317">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']</h4>
                                                <p>
                                                   <appnotes>Indicates that this element is not intended for Web or print display of the finding aid; rather, it is used for retrieval sort and display purposes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e317')">View Comments/Application Notes</a>

				 </td>
                                          <td>'nodisplay' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
				 </td>
                                    <td>altrender=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @altrender<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e317">
                                          <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']</h4>
                                          <p>
                                             <appnotes>Indicates that this element is not intended for Web or print display of the finding aid; rather, it is used for retrieval sort and display purposes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e317')">View Comments/Application Notes</a>

				 </td>
                                    <td>'nodisplay' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']
&gt; does not appear in this document.<div class="appnotes" id="app.d0e303">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/titleproper[@type='filing']</h4>
                                 <p>
                                    <appnotes>Encode the filing title of the collection being described. Note that the filing title is a modified form of the title used for sorting lists of collection titles. 
         <br/>

         
                                       <br/>

         For papers created by, collected around, or associated with an individual, the filing title should begin with that person's last name, followed by the first name and optional middle initial surrounded by parentheses: 
         <br/>

         
                                       <br/>

         Adams (Glen R.) Papers Chambrun (Rene; de) Papers 
         <br/>

         
                                       <br/>

         McNulty (Flora McKay) Correspondence 
         <br/>

         
                                       <br/>

         When the collection is named for two individuals who share the same last name, place the last name at the beginning of the filing title, and list both names and, optionally, a middle initial in parentheses: 
         <br/>

         
                                       <br/>

         Adams (Glen R. and Helen E.) Papers 
         <br/>

         
                                       <br/>

         For individuals who do not share a last name, list the most appropriate name first, with corresponding first name following in parentheses, and then the second last name with its corresponding first name in another set of parentheses: 
         <br/>

         
                                       <br/>

         Adams (Glen R.) and Abel-Henderson (Annie) Collection 
         <br/>

         
                                       <br/>

         Corporate names and family names should generally be listed just as they are. Encoders are urged to use appropriate abbreviations such as Corp., Co., Inc., Misc., Dept., etc., to maintain brevity: 
         <br/>

         
                                       <br/>

         Great Northern Railway Co., Seattle General Agent Records 
         <br/>

         
                                       <br/>

         Haller Family Diaries 
         <br/>

         
                                       <br/>

         Boise Photograph and Ephemera Collection 
         <br/>

         
                                       <br/>

         Portland Fire Dept. Records</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e303')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/author">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/author">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='creator'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/titlestmt/author
				 </td>
                                          <td>encodinganalog
= </td>
                                          <td>MA
				 </td>
                                          <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e383">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/author</h4>
                                                <p>
                                                   <appnotes>Mapped Dublin Core element.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e383')">View Comments/Application Notes</a>

				 </td>
                                          <td>'creator' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/filedesc/titlestmt/author
				 </td>
                                    <td>encodinganalog=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e383">
                                          <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/author</h4>
                                          <p>
                                             <appnotes>Mapped Dublin Core element.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e383')">View Comments/Application Notes</a>

				 </td>
                                    <td>'creator' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/titlestmt/author
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/titlestmt/author
&gt; does not appear in this document.<div class="appnotes" id="app.d0e381">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/author</h4>
                                 <p>
                                    <appnotes>Name of the person(s) or institution(s) responsible for the intellectual content of the encoded finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e381')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/titlestmt/sponsor">
                        <axsl:for-each select="ead/eadheader/filedesc/titlestmt/sponsor">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='contributor'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/titlestmt/sponsor
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Opt
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e401">
                                                   <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/sponsor</h4>
                                                   <p>
                                                      <appnotes>Mapped Dublin Core element.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e401')">View Comments/Application Notes</a>

				 </td>
                                             <td>'contributor'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/titlestmt/sponsor
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e401">
                                             <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/sponsor</h4>
                                             <p>
                                                <appnotes>Mapped Dublin Core element.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e401')">View Comments/Application Notes</a>

				 </td>
                                       <td>'contributor'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/filedesc/titlestmt/sponsor
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/eadheader/filedesc/titlestmt/sponsor
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e399">
                                    <h4>Comments/Application Notes for ead/eadheader/filedesc/titlestmt/sponsor</h4>
                                    <p>
                                       <appnotes>If creation or encoding of a finding aid is supported by a grant, acknowledge the funding agency (e.g., 
         <b>Funding for encoding this finding aid was provided through a grant awarded by the National Endowment for the Humanities.</b>

         ).
         <br/>

         
                                          <br/>
         
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e399')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/editionstmt">
                        <axsl:for-each select="ead/eadheader/filedesc/editionstmt"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/filedesc/editionstmt
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/eadheader/filedesc/editionstmt
&gt; does not appear in this document.<div class="appnotes" id="app.d0e424">
                                    <h4>Comments/Application Notes for ead/eadheader/filedesc/editionstmt</h4>
                                    <p>
                                       <appnotes>Holds information about the edition of the finding aid; see EAD Tag Library for details.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e424')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/publicationstmt">
                        <axsl:for-each select="ead/eadheader/filedesc/publicationstmt"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/publicationstmt
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/filedesc/publicationstmt
&gt; does not appear in this document.<div class="appnotes" id="app.d0e430">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt</h4>
                                 <p>
                                    <appnotes>Wrapper for information about publication or distribution of finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e430')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/publicationstmt/publisher">
                        <axsl:for-each select="ead/eadheader/filedesc/publicationstmt/publisher">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='publisher'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/publicationstmt/publisher
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Opt
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'publisher'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/publicationstmt/publisher
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'publisher'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/publicationstmt/publisher
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/eadheader/filedesc/publicationstmt/publisher
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e436">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/publisher</h4>
                                 <p>
                                    <appnotes>Name of publisher or distributor of finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e436')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/publicationstmt/date">
                        <axsl:for-each select="ead/eadheader/filedesc/publicationstmt/date">
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                             <td>era
= </td>
                                             <td>Rec
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                       <td>era=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                             <td>calendar
= </td>
                                             <td>Rec
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                          <td>normal= </td>
                                          <td>Req
				 </td>
                                          <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e475">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/date</h4>
                                                <p>
                                                   <appnotes>Enter normalized publication or copyright date in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 
            <b>2004</b>

            ). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>

            section.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e475')">View Comments/Application Notes</a>

				 </td>
                                          <td>Use  "iso8601" to format the attribute value.
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                    <td>normal=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @normal<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e475">
                                          <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/date</h4>
                                          <p>
                                             <appnotes>Enter normalized publication or copyright date in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 
            <b>2004</b>

            ). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>

            section.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e475')">View Comments/Application Notes</a>

				 </td>
                                    <td> Use "iso8601" to format attribute value.
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='date'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                          <td>encodinganalog
= </td>
                                          <td>Req
				 </td>
                                          <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e493">
                                                <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/date</h4>
                                                <p>
                                                   <appnotes>Mapped Dublin Core element.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e493')">View Comments/Application Notes</a>

				 </td>
                                          <td>'date' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                                    <td>encodinganalog=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e493">
                                          <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/date</h4>
                                          <p>
                                             <appnotes>Mapped Dublin Core element.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e493')">View Comments/Application Notes</a>

				 </td>
                                    <td>'date' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/filedesc/publicationstmt/date
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/eadheader/filedesc/publicationstmt/date
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e455">
                                 <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/date</h4>
                                 <p>
                                    <appnotes>Date of publication or copyright of the finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e455')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/publicationstmt/address/seriesstmt">
                        <axsl:for-each select="ead/eadheader/filedesc/publicationstmt/address/seriesstmt"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/filedesc/publicationstmt/address/seriesstmt
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/eadheader/filedesc/publicationstmt/address/seriesstmt
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e515">
                                    <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/address/seriesstmt</h4>
                                    <p>
                                       <appnotes>Wrapper for information about published monographic series, if any, to which the finding aid belongs; see EAD Tag Library for details.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e515')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/filedesc/publicationstmt/address/notestmt">
                        <axsl:for-each select="ead/eadheader/filedesc/publicationstmt/address/notestmt"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/filedesc/publicationstmt/address/notestmt
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/eadheader/filedesc/publicationstmt/address/notestmt
&gt; does not appear in this document.<div class="appnotes" id="app.d0e521">
                                    <h4>Comments/Application Notes for ead/eadheader/filedesc/publicationstmt/address/notestmt</h4>
                                    <p>
                                       <appnotes>Wrapper for general notes describing finding aid; see EAD Tag Library for details.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e521')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc">
                        <axsl:for-each select="ead/eadheader/profiledesc"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/profiledesc
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/profiledesc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e527">
                                 <h4>Comments/Application Notes for ead/eadheader/profiledesc</h4>
                                 <p>
                                    <appnotes>Wrapper for information about encoded version and language(s) of finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e527')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc/creation">
                        <axsl:for-each select="ead/eadheader/profiledesc/creation"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/profiledesc/creation
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/eadheader/profiledesc/creation
&gt; does not appear in this document.<div class="appnotes" id="app.d0e533">
                                 <h4>Comments/Application Notes for ead/eadheader/profiledesc/creation</h4>
                                 <p>
                                    <appnotes>Statement about the encoding of the finding aid. Generally include at least the name of the encoder(s), if known.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e533')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc/date">
                        <axsl:for-each select="ead/eadheader/profiledesc/date">
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/profiledesc/date
				 </td>
                                             <td>era
= </td>
                                             <td>Rec
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/profiledesc/date
				 </td>
                                       <td>era=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/profiledesc/date
				 </td>
                                             <td>calendar
= </td>
                                             <td>Rec
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/profiledesc/date
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/profiledesc/date
				 </td>
                                             <td>normal= </td>
                                             <td>Rec
				 </td>
                                             <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e559">
                                                   <h4>Comments/Application Notes for ead/eadheader/profiledesc/date</h4>
                                                   <p>
                                                      <appnotes>Enter normalized initial encoding date in ISO 8601 format (e.g., 2004-03). See examples in Dates section of the Best Practice Guidlines.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e559')">View Comments/Application Notes</a>

				 </td>
                                             <td>Use  "iso8601" to format the attribute value. 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/profiledesc/date
				 </td>
                                       <td>normal=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @normal<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e559">
                                             <h4>Comments/Application Notes for ead/eadheader/profiledesc/date</h4>
                                             <p>
                                                <appnotes>Enter normalized initial encoding date in ISO 8601 format (e.g., 2004-03). See examples in Dates section of the Best Practice Guidlines.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e559')">View Comments/Application Notes</a>

				 </td>
                                       <td> Use "iso8601" to format attribute value. 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/profiledesc/date
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/eadheader/profiledesc/date
&gt; does not appear in this document.<div class="appnotes" id="app.d0e539">
                                    <h4>Comments/Application Notes for ead/eadheader/profiledesc/date</h4>
                                    <p>
                                       <appnotes>Date of 
         <i>initial</i>

         encoding in EAD.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e539')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc/langusage">
                        <axsl:for-each select="ead/eadheader/profiledesc/langusage"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/profiledesc/langusage
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/eadheader/profiledesc/langusage
&gt; does not appear in this document.<div class="appnotes" id="app.d0e575">
                                 <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage</h4>
                                 <p>
                                    <appnotes>Provides a statement about languages, sublanguages, and dialects represented in an encoded finding aid. The language(s) in which the finding aid is written can be further specified using the &lt;language&gt; subelement within &lt;langusage&gt;.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e575')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc/langusage/language">
                        <axsl:for-each select="ead/eadheader/profiledesc/langusage/language">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='language'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                          <td>encodinganalog
= </td>
                                          <td>Req
				 </td>
                                          <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e583">
                                                <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                                <p>
                                                   <appnotes>Mapped Dublin Core element.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e583')">View Comments/Application Notes</a>

				 </td>
                                          <td>'language' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                    <td>encodinganalog=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e583">
                                          <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                          <p>
                                             <appnotes>Mapped Dublin Core element.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e583')">View Comments/Application Notes</a>

				 </td>
                                    <td>'language' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@langcode">
								 <axsl:variable name="langcodes" select="'aar abk ace ach ada ady afa afh afr ain aka akk alb sqi ale alg alt amh ang anp apa ara arc arg arm hye arn arp art arw asm ast ath aus ava ave awa aym aze bad bai bak bal bam ban baq eus bas bat bej bel bem ben ber bho bih bik bin bis bla bnt tib bod bos bra bre btk bua bug bul bur mya byn cad cai car cat cau ceb cel cze ces cha chb che chg chi zho chk chm chn cho chp chr chu chv chy cmc cnr cop cor cos cpe cpf cpp cre crh crp csb cus wel cym cze ces dak dan dar day del den ger deu dgr din div doi dra dsb dua dum dut nld dyu dzo efi egy eka gre ell elx eng enm epo est baq eus ewe ewo fan fao per fas fat fij fil fin fiu fon fre fra fre fra frm fro frr frs fry ful fur gaa gay gba gem geo kat ger deu gez gil gla gle glg glv gmh goh gon gor got grb grc gre ell grn gsw guj gwi hai hat hau haw heb her hil him hin hit hmn hmo hrv hsb hun hup arm hye iba ibo ice isl ido iii ijo iku ile ilo ina inc ind ine inh ipk ira iro ice isl ita jav jbo jpn jpr jrb kaa kab kac kal kam kan kar kas geo kat kau kaw kaz kbd kha khi khm kho kik kin kir kmb kok kom kon kor kos kpe krc krl kro kru kua kum kur kut lad lah lam lao lat lav lez lim lin lit lol loz ltz lua lub lug lui lun luo lus mac mkd mad mag mah mai mak mal man mao mri map mar mas may msa mdf mdr men mga mic min mis mac mkd mkh mlg mlt mnc mni mno moh mon mos mao mri may msa mul mun mus mwl mwr bur mya myn myv nah nai nap nau nav nbl nde ndo nds nep new nia nic niu dut nld nno nob nog non nor nqo nso nub nwc nya nym nyn nyo nzi oci oji ori orm osa oss ota oto paa pag pal pam pan pap pau peo per fas phi phn pli pol pon por pra pro pus qaa-qtz que raj rap rar roa roh rom rum ron rum ron run rup rus sad sag sah sai sal sam san sas sat scn sco sel sem sga sgn shn sid sin sio sit sla slo slk slo slk slv sma sme smi smj smn smo sms sna snd snk sog som son sot spa alb sqi srd srn srp srr ssa ssw suk sun sus sux swa swe syc syr tah tai tam tat tel tem ter tet tgk tgl tha tib bod tig tir tiv tkl tlh tli tmh tog ton tpi tsi tsn tso tuk tum tup tur tut tvl twi tyv udm uga uig ukr umb und urd uzb vai ven vie vol vot wak wal war was wel cym wen wln wol xal xho yao yap yid yor ypk zap zbl zen zgh zha chi zho znd zul zun zxx zza'" />
                                 <axsl:choose>
                                    <axsl:when test="contains(concat(' ', $langcodes, ' '), concat(' ', @langcode, ' '))"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                          <td>langcode
= </td>
                                          <td>Req
				 </td>
                                          <td>@langcode "<axsl:value-of select="@langcode" />" is not valid <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e595">
                                                <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                                <p>
                                                   <appnotes>Consult 
            <a href="http://www.loc.gov/standards/iso639-2/" target="_blank">ISO 639-2b</a>

            for the correct language code(s). The encoding template defaults to “eng”.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e595')">View Comments/Application Notes</a>

				 </td>
                                          <td>See the <a href="https://www.loc.gov/standards/iso639-2/php/code_list.php" target="_blank">ISO 639-2 Code List</a>
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                    <td>langcode=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @langcode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e595">
                                          <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                          <p>
                                             <appnotes>Consult 
            <a href="http://www.loc.gov/standards/iso639-2/" target="_blank">ISO 639-2b</a>

            for the correct language code(s). The encoding template defaults to “eng”.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e595')">View Comments/Application Notes</a>

				 </td>
                                    <td>See the <a href="https://www.loc.gov/standards/iso639-2/php/code_list.php" target="_blank">ISO 639-2 Code List</a> 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@scriptcode">
                                 <axsl:choose>
                                    <axsl:when test="@scriptcode='latn'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                             <td>scriptcode
= </td>
                                             <td>Rec
				 </td>
                                             <td>@scriptcode is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e610">
                                                   <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                                   <p>
                                                      <appnotes>Consult 
            <a href="http://www.unicode.org/iso15924/" target="_blank">ISO 15924</a>

            for the correct script code(s). The encoding template defaults to “latn”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e610')">View Comments/Application Notes</a>

				 </td>
                                             <td>'latn'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                                       <td>scriptcode=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @scriptcode<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e610">
                                             <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                             <p>
                                                <appnotes>Consult 
            <a href="http://www.unicode.org/iso15924/" target="_blank">ISO 15924</a>

            for the correct script code(s). The encoding template defaults to “latn”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e610')">View Comments/Application Notes</a>

				 </td>
                                       <td>'latn'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/profiledesc/langusage/language
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/eadheader/profiledesc/langusage/language
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e581">
                                 <h4>Comments/Application Notes for ead/eadheader/profiledesc/langusage/language</h4>
                                 <p>
                                    <appnotes>Use as many &lt;language&gt; tags as necessary to encode languages predominantly represented in the text of the finding aid. Do not confuse with the &lt;langmaterial&gt; tag, which is used to specify the language(s) significantly represented within the collection itself.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e581')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/profiledesc/descrules">
                        <axsl:for-each select="ead/eadheader/profiledesc/descrules"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/eadheader/profiledesc/descrules
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/eadheader/profiledesc/descrules
&gt; does not appear in this document.<div class="appnotes" id="app.d0e629">
                                 <h4>Comments/Application Notes for ead/eadheader/profiledesc/descrules</h4>
                                 <p>
                                    <appnotes>Identifies the rules used in preparing the finding aid. The program recommends the following wording/tagging: 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;descrules&gt;Finding aid based on DACS (&lt;title render=”italic”&gt;Describing Archives: A Content Standard&lt;/title&gt;), 2nd Edition</b>

         
                                       <br/>

         
                                       <br/>

         Not mandatory in legacy finding aids if the descriptive rules used by the original author(s) are not known.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e629')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/revisiondesc">
                        <axsl:for-each select="ead/eadheader/revisiondesc"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/revisiondesc
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/eadheader/revisiondesc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e646">
                                    <h4>Comments/Application Notes for ead/eadheader/revisiondesc</h4>
                                    <p>
                                       <appnotes>Used to record information about significant changes or alterations that have been made to the encoded finding aid 
         <i>after</i>

         its initial EAD encoding. It is not used to note insignificant changes such as correction of typos, spelling, etc. The revisions should be recorded as a series of &lt;change&gt; elements, each containing a &lt;date&gt; and an &lt;item&gt; element.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e646')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/revisiondesc/change">
                        <axsl:for-each select="ead/eadheader/revisiondesc/change"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/revisiondesc/change
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/eadheader/revisiondesc/change
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e655">
                                    <h4>Comments/Application Notes for ead/eadheader/revisiondesc/change</h4>
                                    <p>
                                       <appnotes>Wrapper that holds information about notable change to a finding aid; contains &lt;date&gt; and &lt;item&gt; elements. Use one &lt;change&gt; element set for each change described.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e655')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/revisiondesc/change/date">
                        <axsl:for-each select="ead/eadheader/revisiondesc/change/date">
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                             <td>era
= </td>
                                             <td>Rec
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                       <td>era=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                             <td>calendar
= </td>
                                             <td>Rec
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                             <td>normal= </td>
                                             <td>Rec
				 </td>
                                             <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e681">
                                                   <h4>Comments/Application Notes for ead/eadheader/revisiondesc/change/date</h4>
                                                   <p>
                                                      <appnotes>Enter normalized change date in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 
            <b>2008-08</b>

            ). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e681')">View Comments/Application Notes</a>

				 </td>
                                             <td>Use  "iso8601" to format the attribute value. 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/eadheader/revisiondesc/change/date
				 </td>
                                       <td>normal=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @normal<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e681">
                                             <h4>Comments/Application Notes for ead/eadheader/revisiondesc/change/date</h4>
                                             <p>
                                                <appnotes>Enter normalized change date in 
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 
            <b>2008-08</b>

            ). See examples in Dates section of the 
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e681')">View Comments/Application Notes</a>

				 </td>
                                       <td> Use "iso8601" to format attribute value. 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/revisiondesc/change/date
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/eadheader/revisiondesc/change/date
&gt; does not appear in this document.<div class="appnotes" id="app.d0e661">
                                    <h4>Comments/Application Notes for ead/eadheader/revisiondesc/change/date</h4>
                                    <p>
                                       <appnotes>Date of change (e.g., 
         <b>Aug., 2008</b>

         ).</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e661')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/eadheader/revisiondesc/change/item">
                        <axsl:for-each select="ead/eadheader/revisiondesc/change/item"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/eadheader/revisiondesc/change/item
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/eadheader/revisiondesc/change/item
&gt; does not appear in this document.<div class="appnotes" id="app.d0e706">
                                    <h4>Comments/Application Notes for ead/eadheader/revisiondesc/change/item</h4>
                                    <p>
                                       <appnotes>Brief narrative description of change (e.g., 
         <b>Collection accrual inventory added</b>

         .).</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e706')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
               </tbody>
            </table>

   
            <h2>Table 2 &lt;archdesc&gt;</h2>
            <table border="1" width="100%" rules="all">
               <tbody>
                  <tr>
                     <th width="20%">Element Location</th>
                     <th width="15%">Attributes or Child Elements</th>
                     <th width="5%">Status</th>
                     <th width="40%">Comments/Application Notes</th>
                     <th width="20%">Possible Values</th>
                  </tr>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc">
                        <axsl:for-each select="ead/archdesc">
                           <axsl:choose>
                              <axsl:when test="@level">
                                 <axsl:choose>
                                    <axsl:when test="@level='collection'  or @level='recordgrp'  or @level='series'  or @level='subgrp'  or @level='subseries'  or @level='otherlevel' "/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc
				 </td>
                                          <td>level=
									 </td>
                                          <td>Req
				 </td>
                                          <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e727">
                                                <h4>Comments/Application Notes for ead/archdesc</h4>
                                                <p>
                                                   <appnotes>Use one of the following terms in the attribute: “collection” “recordgrp” “series” “subgrp” “subseries” “otherlevel” The encoding template defaults to “collection” but this may be changed to another term.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e727')">View Comments/Application Notes</a>

				 </td>
                                          <td>'collection'  or 'recordgrp'  or 'series'  or 'subgrp'  or 'subseries'  or 'otherlevel' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc
				 </td>
                                    <td>level=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @level<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e727">
                                          <h4>Comments/Application Notes for ead/archdesc</h4>
                                          <p>
                                             <appnotes>Use one of the following terms in the attribute: “collection” “recordgrp” “series” “subgrp” “subseries” “otherlevel” The encoding template defaults to “collection” but this may be changed to another term.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e727')">View Comments/Application Notes</a>

				 </td>
                                    <td>'collection'  or 'recordgrp'  or 'series'  or 'subgrp'  or 'subseries'  or 'otherlevel' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@type">
                                 <axsl:choose>
                                    <axsl:when test="@type='guide'  or @type='inventory'  or @type='register'  or @type='accession' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc
				 </td>
                                             <td>type=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e754">
                                                   <h4>Comments/Application Notes for ead/archdesc</h4>
                                                   <p>
                                                      <appnotes>Use one of the following terms in the attribute: “guide” “inventory” “register” or “accession” The encoding template defaults to “inventory” but this may be changed to another term.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e754')">View Comments/Application Notes</a>

				 </td>
                                             <td>'guide'  or 'inventory'  or 'register'  or 'accession'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc
				 </td>
                                       <td>type=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @type<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e754">
                                             <h4>Comments/Application Notes for ead/archdesc</h4>
                                             <p>
                                                <appnotes>Use one of the following terms in the attribute: “guide” “inventory” “register” or “accession” The encoding template defaults to “inventory” but this may be changed to another term.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e754')">View Comments/Application Notes</a>

				 </td>
                                       <td>'guide'  or 'inventory'  or 'register'  or 'accession'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@relatedencoding">
                                 <axsl:choose>
                                    <axsl:when test="@relatedencoding='dc'  or @relatedencoding='marc21' "/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc
				 </td>
                                          <td>relatedencoding=
									 </td>
                                          <td>Req
				 </td>
                                          <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e775">
                                                <h4>Comments/Application Notes for ead/archdesc</h4>
                                                <p>
                                                   <appnotes>Indicate descriptive encoding system to which the &lt;archdesc&gt; elements – those elements that describe the collection -- can be mapped. Participating institutions must produce a MARC record for each collection described in a finding aid; therefore, most repositories will use “marc21” encoding analogs to map EAD elements in &lt;archdesc&gt; to related MARC 21 bibliographic fields and subfields. The EAD BPG and encoding template default to “marc21” encoding analogs for &lt;archdesc&gt; elements. 
            <br/>

            Note: Dublin Core (“dc”) is the encoding system to which &lt;eadheader&gt; elements -- those describing the finding aid document rather than the collection itself -- are mapped. In the &lt;archdesc&gt; section of these guidelines, elements are mapped to MARC 21, but Dublin Core (“dc”) mappings are included in the Columns/Application Notes column for informational purposes.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e775')">View Comments/Application Notes</a>

				 </td>
                                          <td>'dc'  or 'marc21' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc
				 </td>
                                    <td>relatedencoding=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @relatedencoding<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e775">
                                          <h4>Comments/Application Notes for ead/archdesc</h4>
                                          <p>
                                             <appnotes>Indicate descriptive encoding system to which the &lt;archdesc&gt; elements – those elements that describe the collection -- can be mapped. Participating institutions must produce a MARC record for each collection described in a finding aid; therefore, most repositories will use “marc21” encoding analogs to map EAD elements in &lt;archdesc&gt; to related MARC 21 bibliographic fields and subfields. The EAD BPG and encoding template default to “marc21” encoding analogs for &lt;archdesc&gt; elements. 
            <br/>

            Note: Dublin Core (“dc”) is the encoding system to which &lt;eadheader&gt; elements -- those describing the finding aid document rather than the collection itself -- are mapped. In the &lt;archdesc&gt; section of these guidelines, elements are mapped to MARC 21, but Dublin Core (“dc”) mappings are included in the Columns/Application Notes column for informational purposes.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e775')">View Comments/Application Notes</a>

				 </td>
                                    <td>'dc'  or 'marc21' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e725">
                                 <h4>Comments/Application Notes for ead/archdesc</h4>
                                 <p>
                                    <appnotes>Wrapper element for descriptive information about the body of archival materials being described in the finding aid.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e725')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did">
                        <axsl:for-each select="ead/archdesc/did"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did
&gt; does not appear in this document.<div class="appnotes" id="app.d0e798">
                                 <h4>Comments/Application Notes for ead/archdesc/did</h4>
                                 <p>
                                    <appnotes>Wrapper element for core information about the described collection/record group. &lt;did&gt; may be used at the top-level &lt;archdesc&gt; or at any component level &lt;c0x&gt;.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e798')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/repository">
                        <axsl:for-each select="ead/archdesc/did/repository"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/repository
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/repository
&gt; does not appear in this document.<div class="appnotes" id="app.d0e806">
                                 <h4>Comments/Application Notes for ead/archdesc/did/repository</h4>
                                 <p>
                                    <appnotes>Wrapper for the institution or agency responsible for providing intellectual access to the materials being described.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e806')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="/ead/archdesc/did/repository">
                        <axsl:choose>
                           <axsl:when test="ead/archdesc/did/repository/corpname|ead/archdesc/did/repository/name">
                              <axsl:for-each select="ead/archdesc/did/repository/corpname|ead/archdesc/did/repository/name">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog">
                                       <axsl:choose>
                                          <axsl:when test="@encodinganalog='852$a'"/>
                                          <axsl:otherwise>
                                             <axsl:if test="$all='yes'">
                                                <tr>
                                                   <td>archdesc repository corpname or name
				 </td>
                                                   <td>encodinganalog
= </td>
                                                   <td>Rec
				 </td>
                                                   <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                      <div class="appnotes" id="app.d0e814">
                                                         <h4>Comments/Application Notes for archdesc repository corpname or name</h4>
                                                         <p>
                                                            <appnotes>Dublin Core: “publisher”.</appnotes>
                                                         </p>
                                                      </div>
                                                      <br/>
                                                      <a class="appnotes-link" onclick="getAppNotes('app.d0e814')">View Comments/Application Notes</a>

				 </td>
                                                   <td>'852$a'  
				</td>
                                                </tr>
                                             </axsl:if>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>archdesc repository corpname or name
				 </td>
                                             <td>encodinganalog=
					 </td>
                                             <td>Rec
				 </td>
                                             <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e814">
                                                   <h4>Comments/Application Notes for archdesc repository corpname or name</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “publisher”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e814')">View Comments/Application Notes</a>

				 </td>
                                             <td>'852$a'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:for-each>
                           </axsl:when>
                           <axsl:otherwise>
                              <tr>
                                 <td>archdesc repository corpname or name
				 </td>
                                 <td> </td>
                                 <td>Req
				 </td>
                                 <td>The element &lt; archdesc repository corpname or name
&gt; does not appear in this document.<div class="appnotes" id="app.d0e812">
                                       <h4>Comments/Application Notes for archdesc repository corpname or name</h4>
                                       <p>
                                          <appnotes>Top-level name of the repository (e.g., 
         <b>Oregon Historical Society</b>

         or 
         <b>Whitworth University Archives</b>

         ).</appnotes>
                                       </p>
                                    </div>
                                    <br/>
                                    <a class="appnotes-link" onclick="getAppNotes('app.d0e812')">View Comments/Application Notes</a>

				 </td>
                                 <td>
				 </td>
                              </tr>
                           </axsl:otherwise>
                        </axsl:choose>
                     </axsl:when>
                     <axsl:otherwise/>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/repository/subarea">
                        <axsl:for-each select="ead/archdesc/did/repository/subarea">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='852$b'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/repository/subarea
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e838">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/repository/subarea</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “publisher”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e838')">View Comments/Application Notes</a>

				 </td>
                                             <td>'852$b'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/repository/subarea
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e838">
                                             <h4>Comments/Application Notes for ead/archdesc/did/repository/subarea</h4>
                                             <p>
                                                <appnotes>Dublin Core: “publisher”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e838')">View Comments/Application Notes</a>

				 </td>
                                       <td>'852$b'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/repository/subarea
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/did/repository/subarea
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e836">
                                 <h4>Comments/Application Notes for ead/archdesc/did/repository/subarea</h4>
                                 <p>
                                    <appnotes>A secondary or subsidiary administrative level within the repository, such as the name of a department or division (e.g., 
         <b>Center for Pacific Northwest Studies</b>

         ).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e836')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/unitid">
                        <axsl:for-each select="ead/archdesc/did/unitid">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='099'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unitid
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e863">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “identifier”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e863')">View Comments/Application Notes</a>

				 </td>
                                             <td>'099'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitid
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e863">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                             <p>
                                                <appnotes>Dublin Core: “identifier”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e863')">View Comments/Application Notes</a>

				 </td>
                                       <td>'099'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@countrycode">
                                 <axsl:choose>
                                    <axsl:when test="@countrycode[string-length()='2']"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/unitid
				 </td>
                                          <td>countrycode= </td>
                                          <td>Req
				 </td>
                                          <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e875">
                                                <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                                <p>
                                                   <appnotes>Use ISO 3166-1 code, usually “us” (United States) for participants (defaulted as “us” in the encoding template).</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e875')">View Comments/Application Notes</a>

				 </td>
                                          <td>Use  "iso3166-1" to format the attribute value.
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/unitid
				 </td>
                                    <td>countrycode=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @countrycode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e875">
                                          <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                          <p>
                                             <appnotes>Use ISO 3166-1 code, usually “us” (United States) for participants (defaulted as “us” in the encoding template).</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e875')">View Comments/Application Notes</a>

				 </td>
                                    <td> Use "iso3166-1" to format attribute value.
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@repositorycode"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/unitid
				 </td>
                                    <td>repositorycode=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @repositorycode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e884">
                                          <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                          <p>
                                             <appnotes>Use the same value entered in MAINAGENCYCODE in &lt;eadid&gt;, which is the MARC code, not the OCLC code.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e884')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@type"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitid
				 </td>
                                       <td>type=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @type<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e892">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                             <p>
                                                <appnotes>Indicates the type of ID provided, such as accessioning ID, record group ID, etc.; e.g., type=”recordgrp” or type=”collection”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e892')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/unitid
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/unitid
&gt; does not appear in this document.<div class="appnotes" id="app.d0e861">
                                 <h4>Comments/Application Notes for ead/archdesc/did/unitid</h4>
                                 <p>
                                    <appnotes>A unique control number or reference point for the described material, such as a collection or record group number, lot number, accession number, classification number, or entry number in a bibliography or catalog. Institutions that do not assign a collection or other control number to their collections should enter the text "Consult repository."</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e861')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/origination">
                        <axsl:for-each select="ead/archdesc/did/origination"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/origination
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc/did/origination
&gt; does not appear in this document.<div class="appnotes" id="app.d0e904">
                                 <h4>Comments/Application Notes for ead/archdesc/did/origination</h4>
                                 <p>
                                    <appnotes>Information about the individual(s) or organization(s) responsible for the creation, accumulation, assembly, and/or maintenance and use of the described materials.** 
         <br/>

         
                                       <br/>

         &lt;origination&gt; is a wrapper element for one or more of the selected name elements below. At the broadest level of description in &lt;archdesc&gt;, one &lt;origination&gt; element may be used, and it may contain one or more personal, family, or corporate name(s) (the primary creator(s) of the entire body of material described in the finding aid).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e904')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="/ead/archdesc/did/origination">
                        <axsl:choose>
                           <axsl:when test="ead/archdesc/did/origination/persname|ead/archdesc/did/origination/famname|ead/archdesc/did/origination/corpname">
                              <axsl:for-each select="ead/archdesc/did/origination/persname|ead/archdesc/did/origination/famname|ead/archdesc/did/origination/corpname">
                                 <axsl:choose>
                                    <axsl:when test="@source">
                                       <axsl:choose>
                                          <axsl:when test="@source='lcnaf'"/>
                                          <axsl:otherwise>
                                             <tr>
                                                <td>archdesc origination persname or famname or corpname
				 </td>
                                                <td>source
= </td>
                                                <td>MA
				 </td>
                                                <td>@source is not set correctly <axsl:call-template name="getcontext"/>
                                                   <div class="appnotes" id="app.d0e916">
                                                      <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                      <p>
                                                         <appnotes>If the name was found in the LC Name Authority File, enter “lcnaf” in the SOURCE attribute. In this case, there is no need to use the RULES attribute (below).</appnotes>
                                                      </p>
                                                   </div>
                                                   <br/>
                                                   <a class="appnotes-link" onclick="getAppNotes('app.d0e916')">View Comments/Application Notes</a>

				 </td>
                                                <td>'lcnaf' 
				 </td>
                                             </tr>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>archdesc origination persname or famname or corpname
				 </td>
                                          <td>source=
					 </td>
                                          <td>MA
				 </td>
                                          <td> Missing @source<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e916">
                                                <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                <p>
                                                   <appnotes>If the name was found in the LC Name Authority File, enter “lcnaf” in the SOURCE attribute. In this case, there is no need to use the RULES attribute (below).</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e916')">View Comments/Application Notes</a>

				 </td>
                                          <td>'lcnaf' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                                 <axsl:choose>
                                    <axsl:when test="@rules">
                                       <axsl:choose>
                                          <axsl:when test="@rules='aacr2' or @rules='rda'"/>
                                          <axsl:otherwise>
                                             <tr>
                                                <td>archdesc origination persname or famname or corpname
				 </td>
                                                <td>rules=
									 </td>
                                                <td>MA
				 </td>
                                                <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                   <div class="appnotes" id="app.d0e928">
                                                      <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                      <p>
                                                         <appnotes>If the name was not found in the LC authority file but was formulated using AACR2 or RDA, enter “rda” or “aacr2” in the RULES attribute. Do not use DACS as a rules attribute.</appnotes>
                                                      </p>
                                                   </div>
                                                   <br/>
                                                   <a class="appnotes-link" onclick="getAppNotes('app.d0e928')">View Comments/Application Notes</a>

				 </td>
                                                <td>'aacr2', 'rda' 
				 </td>
                                             </tr>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>archdesc origination persname or famname or corpname
				 </td>
                                          <td>rules=
					 </td>
                                          <td>MA
				 </td>
                                          <td> Missing @rules<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e928">
                                                <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                <p>
                                                   <appnotes>If the name was not found in the LC authority file but was formulated using AACR2 or RDA, enter “rda” or “aacr2” in the RULES attribute. Do not use DACS as a rules attribute.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e928')">View Comments/Application Notes</a>

				 </td>
                                          <td>'aacr2', 'rda'
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog">
                                       <axsl:choose>
                                          <axsl:when test="@encodinganalog='100'  or @encodinganalog='110'  or @encodinganalog='111' "/>
                                          <axsl:otherwise>
                                             <axsl:if test="$all='yes'">
                                                <tr>
                                                   <td>archdesc origination persname or famname or corpname
				 </td>
                                                   <td>encodinganalog=
									 </td>
                                                   <td>Rec
				 </td>
                                                   <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                      <div class="appnotes" id="app.d0e942">
                                                         <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                         <p>
                                                            <appnotes>Enter ”100” for personal name; “100” for family name; “110” for corporate name; “111” for meeting or conference name. Note that both the name of an organization (MARC 110) and the name of a meeting or conference (MARC 111) are mapped to the EAD &lt;corpname&gt; element. 
            <br/>

            
                                                               <br/>

            Dublin Core: “creator”.</appnotes>
                                                         </p>
                                                      </div>
                                                      <br/>
                                                      <a class="appnotes-link" onclick="getAppNotes('app.d0e942')">View Comments/Application Notes</a>

				 </td>
                                                   <td>'100'  or '110'  or '111'  
				</td>
                                                </tr>
                                             </axsl:if>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>archdesc origination persname or famname or corpname
				 </td>
                                             <td>encodinganalog=
					 </td>
                                             <td>Rec
				 </td>
                                             <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e942">
                                                   <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                   <p>
                                                      <appnotes>Enter ”100” for personal name; “100” for family name; “110” for corporate name; “111” for meeting or conference name. Note that both the name of an organization (MARC 110) and the name of a meeting or conference (MARC 111) are mapped to the EAD &lt;corpname&gt; element. 
            <br/>

            
                                                         <br/>

            Dublin Core: “creator”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e942')">View Comments/Application Notes</a>

				 </td>
                                             <td>'100'  or '110'  or '111'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                                 <axsl:choose>
                                    <axsl:when test="@role">
                                       <axsl:choose>
                                          <axsl:when test="@role='creator'  or @role='collector'  or @role='photographer' "/>
                                          <axsl:otherwise>
                                             <axsl:if test="$all='yes'">
                                                <tr>
                                                   <td>archdesc origination persname or famname or corpname
				 </td>
                                                   <td>role=
									 </td>
                                                   <td>Rec
				 </td>
                                                   <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                      <div class="appnotes" id="app.d0e964">
                                                         <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                         <p>
                                                            <appnotes>A contextual role or relationship for each person, family, or corporate body entered as the creator. Usually use “creator,” “collector,” or “photographer” at the top level of description. Additional role terms may be used as appropriate; the program recommends taking role terms from a controlled vocabulary such as the 
            <a href="http://www.loc.gov/marc/relators/">MARC List of Relator Codes</a>

            . Do not use “subject.”</appnotes>
                                                         </p>
                                                      </div>
                                                      <br/>
                                                      <a class="appnotes-link" onclick="getAppNotes('app.d0e964')">View Comments/Application Notes</a>

				 </td>
                                                   <td>'creator'  or 'collector'  or 'photographer'  
				</td>
                                                </tr>
                                             </axsl:if>
                                          </axsl:otherwise>
                                       </axsl:choose>
                                    </axsl:when>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>archdesc origination persname or famname or corpname
				 </td>
                                             <td>role=
					 </td>
                                             <td>Rec
				 </td>
                                             <td> Missing @role<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e964">
                                                   <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                                   <p>
                                                      <appnotes>A contextual role or relationship for each person, family, or corporate body entered as the creator. Usually use “creator,” “collector,” or “photographer” at the top level of description. Additional role terms may be used as appropriate; the program recommends taking role terms from a controlled vocabulary such as the 
            <a href="http://www.loc.gov/marc/relators/">MARC List of Relator Codes</a>

            . Do not use “subject.”</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e964')">View Comments/Application Notes</a>

				 </td>
                                             <td>'creator'  or 'collector'  or 'photographer'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:for-each>
                           </axsl:when>
                           <axsl:otherwise>
                              <tr>
                                 <td>archdesc origination persname or famname or corpname
				 </td>
                                 <td> </td>
                                 <td>MA
				 </td>
                                 <td> The repeatable element &lt;archdesc origination persname or famname or corpname
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e914">
                                       <h4>Comments/Application Notes for archdesc origination persname or famname or corpname</h4>
                                       <p>
                                          <appnotes>&lt;persname&gt;: Proper name of individual (lastname, firstname – 
         <b>Smith, Mary</b>

         ), or &lt;famname&gt;: Proper name of family (natural language word order – 
         <b>Smith family</b>

         ), or &lt;corpname&gt;: Proper name of organization/agency (natural language word order – 
         <b>Smith Banking Corp.</b>

         ), or name of conference or meeting, exhibition, expedition, athletic contest, fair, etc. (see the Tag Library under &lt;corpname&gt; for details on certain types of event names). 
         <br/>

         
                                             <br/>

         Best practice: Use LC name authority form if possible (check LC, OCLC, or RLG name authority files), or formulate according to 
            RDA

         or AACR2.</appnotes>
                                       </p>
                                    </div>
                                    <br/>
                                    <a class="appnotes-link" onclick="getAppNotes('app.d0e914')">View Comments/Application Notes</a>

				 </td>
                                 <td>
				 </td>
                              </tr>
                           </axsl:otherwise>
                        </axsl:choose>
                     </axsl:when>
                     <axsl:otherwise/>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/unittitle">
                        <axsl:for-each select="ead/archdesc/did/unittitle">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='245$a'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unittitle
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1004">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/unittitle</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “title”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1004')">View Comments/Application Notes</a>

				 </td>
                                             <td>'245$a'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unittitle
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1004">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unittitle</h4>
                                             <p>
                                                <appnotes>Dublin Core: “title”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1004')">View Comments/Application Notes</a>

				 </td>
                                       <td>'245$a'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/unittitle
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/unittitle
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1002">
                                 <h4>Comments/Application Notes for ead/archdesc/did/unittitle</h4>
                                 <p>
                                    <appnotes>The title, either transcribed or supplied, of the described collection. A supplied title generally consists of the name of the creator(s) or collector(s) and the nature of the materials being described. 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;unittitle encodinganalog=”245$a”&gt;Annie Abel-Henderson Papers&lt;/unittitle&gt;</b>

         
                                       <br/>

         
                                       <br/>

         
                                       <b>&lt;unittitle encodinganalog=”245$a”&gt;Grace Howard Gray Scrapbook&lt;/unittitle&gt;</b>

         
                                       <br/>

         
                                       <br/>

         If the collection title includes within it the name of a publication, such as the title of a newspaper, enclose the publication name in a &lt;title&gt; element, and set the &lt;title&gt; element’s RENDER attribute to “italic”. 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;unittitle encodinganalog=”245$a”&gt;Roger S. Fillmore &lt;title render=”italic”&gt;Spokane Daily News&lt;/title&gt; Collection&lt;/unittitle&gt;</b>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1002')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/unitdate">
                        <axsl:for-each select="ead/archdesc/did/unitdate">
                           <axsl:choose>
                              <axsl:when test="@type">
                                 <axsl:choose>
                                    <axsl:when test="@type='inclusive'  or @type='bulk' "/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/unitdate
				 </td>
                                          <td>type=
									 </td>
                                          <td>Req
				 </td>
                                          <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e1047">
                                                <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                                <p>
                                                   <appnotes>Use “inclusive” for the full date range (even if date range is a single year, month, or day); use “bulk” only in an optional repeated instance of &lt;unitdate&gt; in which bulk (i.e., predominant) dates are stated.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e1047')">View Comments/Application Notes</a>

				 </td>
                                          <td>'inclusive'  or 'bulk' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/unitdate
				 </td>
                                    <td>type=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @type<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e1047">
                                          <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                          <p>
                                             <appnotes>Use “inclusive” for the full date range (even if date range is a single year, month, or day); use “bulk” only in an optional repeated instance of &lt;unitdate&gt; in which bulk (i.e., predominant) dates are stated.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e1047')">View Comments/Application Notes</a>

				 </td>
                                    <td>'inclusive'  or 'bulk' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@datechar">
                                 <axsl:choose>
                                    <axsl:when test="@datechar='creation'  or @datechar='recordkeeping'  or @datechar='publication'  or @datechar='broadcast' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unitdate
				 </td>
                                             <td>datechar=
									 </td>
                                             <td>Opt
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1062">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                                   <p>
                                                      <appnotes>Enter a term that indicates the nature of the recorded date(s), usually creation, record-keeping activity, publication, or broadcast.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1062')">View Comments/Application Notes</a>

				 </td>
                                             <td>'creation'  or 'recordkeeping'  or 'publication'  or 'broadcast'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitdate
				 </td>
                                       <td>datechar=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @datechar<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1062">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                             <p>
                                                <appnotes>Enter a term that indicates the nature of the recorded date(s), usually creation, record-keeping activity, publication, or broadcast.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1062')">View Comments/Application Notes</a>

				 </td>
                                       <td>'creation'  or 'recordkeeping'  or 'publication'  or 'broadcast'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unitdate
				 </td>
                                             <td>era
= </td>
                                             <td>Rec
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitdate
				 </td>
                                       <td>era=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unitdate
				 </td>
                                             <td>calendar
= </td>
                                             <td>Rec
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitdate
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/unitdate
				 </td>
                                          <td>normal= </td>
                                          <td>Req
				 </td>
                                          <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e1101">
                                                <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                                <p>
                                                   <appnotes>Enter normalized begin/end date in
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 1893/1992). See examples in Dates section of the
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e1101')">View Comments/Application Notes</a>

				 </td>
                                          <td>Use  "iso8601" to format the attribute value.
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/unitdate
				 </td>
                                    <td>normal=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @normal<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e1101">
                                          <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                          <p>
                                             <appnotes>Enter normalized begin/end date in
            <a href="http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=26780&amp;ICS1=1&amp;ICS2=140&amp;ICS3=30" target="_blank">ISO 8601</a>

            format (e.g., 1893/1992). See examples in Dates section of the
               <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e1101')">View Comments/Application Notes</a>

				 </td>
                                    <td> Use "iso8601" to format attribute value.
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@certainty"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitdate
				 </td>
                                       <td>certainty=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @certainty<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1116">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                             <p>
                                                <appnotes>Indicates the level of confidence for the information given; for example, set to “approximate” or “circa” if the dates are uncertain.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1116')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='245$f'  or @encodinganalog='245$g' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/unitdate
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1124">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                                   <p>
                                                      <appnotes>”245$f” for inclusive dates; “245$g” for bulk dates. 
            <br/>

            
                                                         <br/>

            Dublin Core: “coverage” (temporal).</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1124')">View Comments/Application Notes</a>

				 </td>
                                             <td>'245$f'  or '245$g'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/unitdate
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1124">
                                             <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                             <p>
                                                <appnotes>”245$f” for inclusive dates; “245$g” for bulk dates. 
            <br/>

            
                                                   <br/>

            Dublin Core: “coverage” (temporal).</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1124')">View Comments/Application Notes</a>

				 </td>
                                       <td>'245$f'  or '245$g'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/unitdate
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/unitdate
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1045">
                                 <h4>Comments/Application Notes for ead/archdesc/did/unitdate</h4>
                                 <p>
                                    <appnotes>The date(s) of the described materials. Kinds of dates that may be recorded include creation, record-keeping activity, publication, or broadcast dates. May be a single date or a date range (e.g., 
         <b>1893-1992</b>

         ). Optionally, repeat the &lt;unitdate&gt; element to state bulk date(s), specifying type of date in the TYPE attribute. The program recommends that words indicating approximation (such as “circa,” “approximately,” and “probably”) as well as names of months be spelled out rather than abbreviated. In compliance with 
            <a href="http://files.archivists.org/pubs/DACS2E-2013.pdf" target="_blank">DACS</a>

         , use “undated” if the date(s) are unknown or would be difficult or misleading to estimate (use the complete word “undated”; do not use “n.d.” or “s.d.”). 
         <br/>

         
                                       <br/>

         To insure compliance with ISAD(G), do not nest &lt;unitdate&gt; inside &lt;unittitle&gt;.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1045')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physdesc">
                        <axsl:for-each select="ead/archdesc/did/physdesc"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/physdesc
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/did/physdesc
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1157">
                                 <h4>Comments/Application Notes for ead/archdesc/did/physdesc</h4>
                                 <p>
                                    <appnotes>A wrapper element for physical details about the described materials. Use subelements &lt;extent&gt;, &lt;physfacet&gt;, &lt;dimensions&gt;, and if desired, &lt;genreform&gt; to record the information.
         <br/>

         
                                       <br/>

         Use separate &lt;physdesc&gt; element sets to accommodate physical description information for different formats included in the collection (e.g., one &lt;physdesc&gt; for number of cubic feet of papers, another &lt;physdesc&gt; for number of photographic prints).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1157')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physdesc/extent">
                        <axsl:for-each select="ead/archdesc/did/physdesc/extent">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='300$a'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/physdesc/extent
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1169">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/physdesc/extent</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “format”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1169')">View Comments/Application Notes</a>

				 </td>
                                             <td>'300$a'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/physdesc/extent
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1169">
                                             <h4>Comments/Application Notes for ead/archdesc/did/physdesc/extent</h4>
                                             <p>
                                                <appnotes>Dublin Core: “format”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1169')">View Comments/Application Notes</a>

				 </td>
                                       <td>'300$a'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/physdesc/extent
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/did/physdesc/extent
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1167">
                                 <h4>Comments/Application Notes for ead/archdesc/did/physdesc/extent</h4>
                                 <p>
                                    <appnotes>State extent of space occupied (in linear or cubic feet) and/or number of containers and/or items. If desired, include additional details concerning types and formats of material, as in the first example below. Use separate &lt;extent&gt; tags inside a single &lt;physdesc&gt; to state the same information in different ways (e.g., one &lt;extent&gt; element for cubic feet and another &lt;extent&gt; element for number of containers, both nested inside the same &lt;physdesc&gt; element). Units of measure should be expressed as part of the content of this tag.
         <br/>

         
                                       <br/>

         
                                       <b>&lt;physdesc&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;extent&gt;12 cubic feet, including textual materials, photographs, and videocassettes&lt;/extent&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;extent&gt;14 boxes&lt;/extent&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;/physdesc&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;physdesc&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;extent&gt;238 photographic prints&lt;/extent&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;/physdesc&gt;</b>

         
                                       <br/>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1167')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physdesc/physfacet">
                        <axsl:for-each select="ead/archdesc/did/physdesc/physfacet"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/did/physdesc/physfacet
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc/did/physdesc/physfacet
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1224">
                                    <h4>Comments/Application Notes for ead/archdesc/did/physdesc/physfacet</h4>
                                    <p>
                                       <appnotes>For details regarding appearance (e.g., color), materials, technique, etc. For guidance on terminology and syntax in describing physical aspects of particular types of non-textual materials, consult the appropriate content standards listed in 
            <a href="http://files.archivists.org/pubs/DACS2E-2013.pdf" target="_blank">DACS</a>.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1224')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physdesc/dimensions">
                        <axsl:for-each select="ead/archdesc/did/physdesc/dimensions"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/did/physdesc/dimensions
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc/did/physdesc/dimensions
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1233">
                                    <h4>Comments/Application Notes for ead/archdesc/did/physdesc/dimensions</h4>
                                    <p>
                                       <appnotes>For guidance on stating the measurements of particular types of materials (such as the height and width of photographs or the diameter and tape width of reel-to-reel audio tapes), consult the appropriate content standards listed in 
            <a href="http://files.archivists.org/pubs/DACS2E-2013.pdf" target="_blank">DACS</a>.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1233')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physdesc/materialspec">
                        <axsl:for-each select="ead/archdesc/did/physdesc/materialspec"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/did/physdesc/materialspec
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/archdesc/did/physdesc/materialspec
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1242">
                                    <h4>Comments/Application Notes for ead/archdesc/did/physdesc/materialspec</h4>
                                    <p>
                                       <appnotes>For information about a specific type of material that is not recorded in any other element (such as scale for cartographic materials). See the EAD Tag Library for details.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1242')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/abstract">
                        <axsl:for-each select="ead/archdesc/did/abstract">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='5203_'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/abstract
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'5203_'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/abstract
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'5203_'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/abstract
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/abstract
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1248">
                                 <h4>Comments/Application Notes for ead/archdesc/did/abstract</h4>
                                 <p>
                                    <appnotes>Use for a very brief summary of collection contents and biographical information at the highest level (but also use &lt;scopecontent&gt; for fuller description). The text in the top-level &lt;abstract&gt; element is displayed in search result lists presented on the researcher site. When a user scans a list of hits retrieved through a search, the abstract, displayed under the title of each retrieved finding aid, provides the user with basic information about the collection and/or its creator. This helps the user decide whether or not to view the complete finding aid. The abstract also displays in the finding aid. 
         <br/>

         
                                       <br/>

         At component level (e.g., “folder” or “item”), use &lt;scopecontent&gt; rather than &lt;abstract&gt;.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1248')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/physloc">
                        <axsl:for-each select="ead/archdesc/did/physloc">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/physloc
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1269">
                                             <h4>Comments/Application Notes for ead/archdesc/did/physloc</h4>
                                             <p>
                                                <appnotes>The 
            <a href="http://www.loc.gov/marc/bibliographic/ecbdhold.html" target="_blank">MARC 852</a>

            field contains various subfields that may be mapped to information in &lt;physloc&gt;.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1269')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/did/physloc
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc/did/physloc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1267">
                                    <h4>Comments/Application Notes for ead/archdesc/did/physloc</h4>
                                    <p>
                                       <appnotes>Name or number of the building, room, stack, shelf, or other tangible area where material is shelved. Do not confuse with &lt;container&gt; or &lt;repository&gt;.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1267')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/langmaterial">
                        <axsl:for-each select="ead/archdesc/did/langmaterial"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/langmaterial
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/did/langmaterial
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1284">
                                 <h4>Comments/Application Notes for ead/archdesc/did/langmaterial</h4>
                                 <p>
                                    <appnotes>A prose statement naming the language(s) of the materials in the collection or unit. One or more language name(s) are enclosed in nested &lt;language&gt; tags. 
         <br/>

         
                                       <br/>

         If the collection, such as a photograph collection, contains no associated text, state that fact in &lt;langmaterial&gt; using wording similar to the following: 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;langmaterial&gt;No textual or other language materials are included in the collection.&lt;/langmaterial&gt;</b>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1284')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/langmaterial/language">
                        <axsl:for-each select="ead/archdesc/did/langmaterial/language">
                           <axsl:choose>
                              <axsl:when test="@langcode">
                                 <axsl:choose>
                                    <axsl:when test="@langcode[string-length()='3']"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/langmaterial/language
				 </td>
                                          <td>langcode= </td>
                                          <td>MA
				 </td>
                                          <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e1303">
                                                <h4>Comments/Application Notes for ead/archdesc/did/langmaterial/language</h4>
                                                <p>
                                                   <appnotes>Consult 
            <a href="http://www.loc.gov/standards/iso639-2/" target="_blank">ISO 639-2b</a>

            for the correct language code(s).</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e1303')">View Comments/Application Notes</a>

				 </td>
                                          <td>Use  "iso639-2b" to format the attribute value.
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/langmaterial/language
				 </td>
                                    <td>langcode=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @langcode<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e1303">
                                          <h4>Comments/Application Notes for ead/archdesc/did/langmaterial/language</h4>
                                          <p>
                                             <appnotes>Consult 
            <a href="http://www.loc.gov/standards/iso639-2/" target="_blank">ISO 639-2b</a>

            for the correct language code(s).</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e1303')">View Comments/Application Notes</a>

				 </td>
                                    <td> Use "iso639-2b" to format attribute value.
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='546'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/did/langmaterial/language
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1315">
                                                   <h4>Comments/Application Notes for ead/archdesc/did/langmaterial/language</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “language”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1315')">View Comments/Application Notes</a>

				 </td>
                                             <td>'546'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/did/langmaterial/language
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1315">
                                             <h4>Comments/Application Notes for ead/archdesc/did/langmaterial/language</h4>
                                             <p>
                                                <appnotes>Dublin Core: “language”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1315')">View Comments/Application Notes</a>

				 </td>
                                       <td>'546'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/langmaterial/language
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/did/langmaterial/language
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1301">
                                 <h4>Comments/Application Notes for ead/archdesc/did/langmaterial/language</h4>
                                 <p>
                                    <appnotes>Subelement of &lt;langmaterial&gt; within which the language of the materials being described is specified. 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;langmaterial&gt;Correspondence in &lt;language langcode=”fre”&gt;French&lt;/language&gt; and &lt;language langcode=”ger”&gt;German&lt;/language&gt;.</b>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1301')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/did/dao">
                        <axsl:for-each select="ead/archdesc/did/dao">
                           <axsl:choose>
                              <axsl:when test="@linktype">
                                 <axsl:choose>
                                    <axsl:when test="@linktype='simple'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/dao
				 </td>
                                          <td>linktype
= </td>
                                          <td>MA
				 </td>
                                          <td>@linktype is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                          <td>'simple' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/dao
				 </td>
                                    <td>linktype=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @linktype<axsl:call-template name="getcontext"/>

				 </td>
                                    <td>'simple' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role">
                                 <axsl:choose>
                                    <axsl:when test="@role='harvest-all'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/did/dao
				 </td>
                                          <td>role
= </td>
                                          <td>MA
				 </td>
                                          <td>@role is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                          <td>'harvest-all' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/dao
				 </td>
                                    <td>role=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @role<axsl:call-template name="getcontext"/>

				 </td>
                                    <td>'harvest-all' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/dao
				 </td>
                                    <td>role=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @role<axsl:call-template name="getcontext"/>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@href"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/did/dao
				 </td>
                                    <td>href=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @href<axsl:call-template name="getcontext"/>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/did/dao
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/did/dao
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1340">
                                 <h4>Comments/Application Notes for ead/archdesc/did/dao</h4>
                                 <p>
                                    <appnotes>To link to associated digital objects at the collection level, insert a &lt;dao&gt; element at the end of &lt;archdesc&gt;&lt;did&gt;. Set the linktype attribute to "simple" and role to "harvest-all." In the href attribute, put the link to the OAI set that contains the digital objects. Each one of those objects must in turn have a link to the finding aid ARK from the dc:relations field. 
          <br/>
          
                                       <b>For more information, see Describing and Linking to Digital Objects in the EAD Best Practices.</b>
       
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1340')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/bioghist[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc/bioghist[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='5450_'  or @encodinganalog='5451_' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/bioghist
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1390">
                                                   <h4>Comments/Application Notes for ead/archdesc/bioghist</h4>
                                                   <p>
                                                      <appnotes>In order to distinguish a biographical note (biographical information about the person or family who created a collection of papers), from a historical note (background information about the organization or agency that created a collection of records), this attribute may be used to record the MARC value for one or the other. A value of “5450_” indicates that the note contains biographical information about a person or family; “5451_” indicates that the note contains historical information about an organization. If preferred, the &lt;head&gt; element may be used in place of (or in addition to) the ENCODINGANALOG attribute to make this distinction. 
            <br/>

            
                                                         <br/>

            Dublin Core: “description”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1390')">View Comments/Application Notes</a>

				 </td>
                                             <td>'5450_'  or '5451_'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/bioghist
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1390">
                                             <h4>Comments/Application Notes for ead/archdesc/bioghist</h4>
                                             <p>
                                                <appnotes>In order to distinguish a biographical note (biographical information about the person or family who created a collection of papers), from a historical note (background information about the organization or agency that created a collection of records), this attribute may be used to record the MARC value for one or the other. A value of “5450_” indicates that the note contains biographical information about a person or family; “5451_” indicates that the note contains historical information about an organization. If preferred, the &lt;head&gt; element may be used in place of (or in addition to) the ENCODINGANALOG attribute to make this distinction. 
            <br/>

            
                                                   <br/>

            Dublin Core: “description”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1390')">View Comments/Application Notes</a>

				 </td>
                                       <td>'5450_'  or '5451_'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/bioghist
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/bioghist
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1384">
                                 <h4>Comments/Application Notes for ead/archdesc/bioghist</h4>
                                 <p>
                                    <appnotes>Provides researcher with background and context information pertaining to record creator(s) or collector(s). A chronology list &lt;chronlist&gt; that matches dates and date ranges with associated events may be used instead of or in addition to paragraphs &lt;p&gt; of text. 
         <br/>

         
                                       <br/>

         If the biographical or historical information is provided in narrative form, the text must be enclosed in paragraph &lt;p&gt; tags. &lt;p&gt; is repeatable. 
         <br/>

         
                                       <br/>

         If more than one &lt;bioghist&gt; element is needed (e.g., if the collection was created by more than one entity, necessitating more than one biographical or administrative history note), use a separate &lt;bioghist&gt; element for each creator, but nest them inside a “wrapper” &lt;bioghist&gt; element. 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;bioghist&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;bioghist encodinganalog=”5450_”&gt;&lt;p&gt;Text of first biographical note.&lt;/p&gt;&lt;'bioghist&gt; &lt;bioghist encodinganalog=”5450_”&gt;&lt;p&gt;Text of second biographical note.&lt;/p&gt;&lt;/bioghist&gt;</b>

         
                                       <br/>

         
                                       <b>&lt;/bioghist&gt;</b>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1384')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//bioghist/head[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//bioghist/head[not(ancestor::dsc)]"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//bioghist/head
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//bioghist/head
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1438">
                                    <h4>Comments/Application Notes for ead/archdesc//bioghist/head</h4>
                                    <p>
                                       <appnotes>In order to distinguish a biographical note (biographical information about the person or family who created a collection of papers), from a historical note (background information about the organization or agency that created a collection of records), this attribute may be used to record the MARC value for one or the other. A value of “5450_” indicates that the note contains biographical information about a person or family; “5451_” indicates that the note contains historical information about an organization. If preferred, the &lt;head&gt; element may be used in place of (or in addition to) the ENCODINGANALOG attribute to make this distinction. 
         <br/>

         
                                          <br/>

         
                                          <b>Repeatable only if more than one &lt;bioghist&gt; element is used (one &lt;label&gt; may be used with each).</b>
         
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1438')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//bioghist/chronlist[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//bioghist/chronlist[not(ancestor::dsc)]"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//bioghist/chronlist
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//bioghist/chronlist
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1451">
                                    <h4>Comments/Application Notes for ead/archdesc//bioghist/chronlist</h4>
                                    <p>
                                       <appnotes>See the Lists section of the 
            <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing">Best Practice Guidelines</a>, or see the EAD Tag Library for more information on encoding a chronological list of significant biographical or historical events.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1451')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//scopecontent[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//scopecontent[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='5202_'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//scopecontent
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1466">
                                                   <h4>Comments/Application Notes for ead/archdesc//scopecontent</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “description”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1466')">View Comments/Application Notes</a>

				 </td>
                                             <td>'5202_'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//scopecontent
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1466">
                                             <h4>Comments/Application Notes for ead/archdesc//scopecontent</h4>
                                             <p>
                                                <appnotes>Dublin Core: “description”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1466')">View Comments/Application Notes</a>

				 </td>
                                       <td>'5202_'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//scopecontent
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc//scopecontent
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1460">
                                 <h4>Comments/Application Notes for ead/archdesc//scopecontent</h4>
                                 <p>
                                    <appnotes>Provides the researcher with a general description of the topical range and content, as well as the document types and formats, of the collection as a whole. If organization/arrangement information is difficult to separate, it may be given as part of &lt;scopecontent&gt;, but it is preferable to place that information in &lt;arrangement&gt;.
         <br/>

         
                                       <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1460')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//odd[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//odd[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='500'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//odd
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1492">
                                                   <h4>Comments/Application Notes for ead/archdesc//odd</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “description”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1492')">View Comments/Application Notes</a>

				 </td>
                                             <td>'500'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//odd
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1492">
                                             <h4>Comments/Application Notes for ead/archdesc//odd</h4>
                                             <p>
                                                <appnotes>Dublin Core: “description”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1492')">View Comments/Application Notes</a>

				 </td>
                                       <td>'500'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//odd
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//odd
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1486">
                                    <h4>Comments/Application Notes for ead/archdesc//odd</h4>
                                    <p>
                                       <appnotes>Use for general notes that are not appropriate in more specific elements. The text of the note(s) is enclosed in repeatable &lt;p&gt; tags. A possible use of &lt;odd&gt;: If a legacy finding aid combines &lt;bioghist&gt; and &lt;scopecontent&gt; information, the text could be placed inside &lt;odd&gt;. However, the program strongly recommends that consortium members use more specific note elements whenever possible. 
         <br/>

         
                                          <br/>

         Do note confuse with &lt;note&gt;, which may be used to provide a short comment, such as citing the source of a quotation or justifying an assertion. &lt;odd&gt; is intended for information that is more than a short comment. 
         <br/>

         
                                          <br/>

         While &lt;odd&gt; is repeatable, best practice is to nest a separate &lt;p&gt; element for each general note inside a single &lt;odd&gt; element, except in the situation described below, in which a specific &lt;odd&gt; note must be identified in the TYPE attribute. 
         <br/>

         
                                          <br/>

         Finding aids for photograph or other collections sometimes include essay-like contextual or interpretive notes that belong in neither &lt;bioghist&gt; nor &lt;scopecontent&gt; because they describe neither the creator of the collection nor the contents of the collection. Example: A brief essay on the history of Japanese baseball in the Northwest in a personal collection of photographs of Japanese baseball players in Seattle. &lt;odd&gt; may be used to accommodate such notes. Enter “hist” into the &lt;odd&gt; TYPE attribute to specify that this is a contextual/interpretive note &lt;odd type=”hist”&gt;. 
         <br/>

         
                                          <br/>

         For other general notes, a nested &lt;head&gt; element containing a brief heading clarifying the contents of the note may be provided, but only if a heading is needed. 
         <br/>

         
                                          <br/>

         The example below uses &lt;odd&gt; to accommodate a glossary in list format. 
         <br/>

         
                                          <br/>

         
                                          <b>&lt;encodinganalog=”500”&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;head&gt;Glossary&lt;/head&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;list type=”deflist”&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;defitem&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;label&gt;acequiaY&lt;/label&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;item&gt;An irrigation ditch or canal.&lt;/item&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;/defitem&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;defitem&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;label&gt;ADG&lt;/label&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;item&gt;Average daily body weight gain.&lt;/item&gt; &lt;/defitem&gt; &lt;/list&gt; &lt;/odd&gt;</b>
         
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1486')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//odd/head">
                        <axsl:for-each select="ead/archdesc//odd/head"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//odd/head
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//odd/head
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e1580">
                                    <h4>Comments/Application Notes for ead/archdesc//odd/head</h4>
                                    <p>
                                       <appnotes>If needed to clarify the contents of the &lt;odd&gt; note, provide the heading here. Provide a heading only if the contents of the &lt;odd&gt; note would be unclear without it. One &lt;head&gt; may be used with each &lt;odd&gt;.
         <br/>
         
                                          <br/>
         &lt;head&gt;Publications List&lt;/head&gt;
         </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1580')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//arrangement[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//arrangement[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='351'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//arrangement
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1596">
                                                   <h4>Comments/Application Notes for ead/archdesc//arrangement</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “description”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1596')">View Comments/Application Notes</a>

				 </td>
                                             <td>'351'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//arrangement
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1596">
                                             <h4>Comments/Application Notes for ead/archdesc//arrangement</h4>
                                             <p>
                                                <appnotes>Dublin Core: “description”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1596')">View Comments/Application Notes</a>

				 </td>
                                       <td>'351'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//arrangement
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc//arrangement
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1590">
                                 <h4>Comments/Application Notes for ead/archdesc//arrangement</h4>
                                 <p>
                                    <appnotes>Provides information about the arrangement of the collection (into series, for example) and/or the filing sequence of the material (alphabetical, chronological, etc.). 
         <br/>

         
                                       <br/>

         
                                       <b>&lt;arrangement&gt; &lt;p&gt;Arranged in two series: 1. Correspondence (alphabetical); 2. Subject files (alphabetical by topic).&lt;/p&gt; &lt;/arrangement&gt; </b>
         
                                       <br/>

         
                                       <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1590')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//fileplan">
                        <axsl:for-each select="ead/archdesc//fileplan"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//fileplan
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc//fileplan
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1623">
                                    <h4>Comments/Application Notes for ead/archdesc//fileplan</h4>
                                    <p>
                                       <appnotes>See the EAD Tag Library for information on this element.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1623')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//altformavail[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//altformavail[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='530'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//altformavail
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1639">
                                                   <h4>Comments/Application Notes for ead/archdesc//altformavail</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “relation”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1639')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '530' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//altformavail
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1639">
                                             <h4>Comments/Application Notes for ead/archdesc//altformavail</h4>
                                             <p>
                                                <appnotes>Dublin Core: “relation”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1639')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '530' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//altformavail
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//altformavail
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1633">
                                    <h4>Comments/Application Notes for ead/archdesc//altformavail</h4>
                                    <p>
                                       <appnotes>Provides researcher with information about alternative formats available, such as microfilm or digital versions. If the whole collection or some of its contents have been digitized, use &lt;dao&gt; in the &lt;dsc&gt;. 
         <br/>

         
                                          <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1633')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//accessrestrict[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//accessrestrict[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='506'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/accessrestrict
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1665">
                                                   <h4>Comments/Application Notes for ead/archdesc/accessrestrict</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “rights”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1665')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '506' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/accessrestrict
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1665">
                                             <h4>Comments/Application Notes for ead/archdesc/accessrestrict</h4>
                                             <p>
                                                <appnotes>Dublin Core: “rights”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1665')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '506' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/accessrestrict
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td>The element &lt; ead/archdesc/accessrestrict
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1659">
                                 <h4>Comments/Application Notes for ead/archdesc/accessrestrict</h4>
                                 <p>
                                    <appnotes>Provides researcher with information about conditions
            governing access. If there are no restrictions on
            access, repositories are strongly encouraged to make a statement to that effect, such as: “Collection is
            open for research.”
            Text must be enclosed in paragraph &lt;p&gt;  tags; &lt;p&gt; is
               repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1659')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/accessrestrict/legalstatus">
                        <axsl:for-each select="ead/archdesc/accessrestrict/legalstatus"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/accessrestrict/legalstatus
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc/accessrestrict/legalstatus
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1681">
                                    <h4>Comments/Application Notes for ead/archdesc/accessrestrict/legalstatus</h4>
                                    <p>
                                       <appnotes>See the EAD Tag Library for information on this element.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1681')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//userestrict[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//userestrict[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='540'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//userestrict
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1693">
                                                   <h4>Comments/Application Notes for ead/archdesc//userestrict</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “rights”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1693')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '540' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//userestrict
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1693">
                                             <h4>Comments/Application Notes for ead/archdesc//userestrict</h4>
                                             <p>
                                                <appnotes>Dublin Core: “rights”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1693')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '540' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//userestrict
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc//userestrict
&gt; does not appear in this document.

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//prefercite[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//prefercite[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='524'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//prefercite
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td> For MARC21: '524' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//prefercite
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td> For MARC21: '524' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//prefercite
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//prefercite
&gt; does not appear in this document.

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//custodhist[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//custodhist[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='561'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//custodhist
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td> For MARC21: '561' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//custodhist
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td> For MARC21: '561' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//custodhist
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//custodhist
&gt; does not appear in this document.

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//acqinfo[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//acqinfo[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='541'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//acqinfo
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td> For MARC21: '541' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//acqinfo
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td> For MARC21: '541' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//acqinfo
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc//acqinfo
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1738">
                                 <h4>Comments/Application Notes for ead/archdesc//acqinfo</h4>
                                 <p>
                                    <appnotes>Identifies the immediate source from which the described materials were acquired by the repository. Also includes the date(s) and method(s) of acquisition, along with any non-confidential information deemed useful by the repository. 
         <br/>

         
                                       <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e1738')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//accruals[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//accruals[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='584'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/accruals
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td> For MARC21: '584' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/accruals
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td> For MARC21: '584' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/accruals
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc/accruals
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1761">
                                    <h4>Comments/Application Notes for ead/archdesc/accruals</h4>
                                    <p>
                                       <appnotes>Provides researcher with information about anticipated additions to materials being described. 
         <br/>

         
                                          <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags;&lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1761')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//processinfo[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//processinfo[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='583'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//processinfo
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td> For MARC21: '583' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//processinfo
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td> For MARC21: '583' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//processinfo
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//processinfo
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1784">
                                    <h4>Comments/Application Notes for ead/archdesc//processinfo</h4>
                                    <p>
                                       <appnotes>Provides researcher with information about staff processing actions such as accessioning, organizing, describing, preserving, and storing described materials for research use. 
         <br/>

         
                                          <br/>

         &lt;processinfo&gt;
         <br/>

         &lt;p&gt;Processed in 2003.&lt;/p&gt;
         <br/>

         &lt;/processinfo&gt; 
         <br/>

         
                                          <br/>

         Text may be enclosed in paragraph &lt;p&gt; tags; &lt;'p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1784')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//separatedmaterial[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//separatedmaterial[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='5440_'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//separatedmaterial
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'5440_'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//separatedmaterial
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'5440_'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//separatedmaterial
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//separatedmaterial
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1815">
                                    <h4>Comments/Application Notes for ead/archdesc//separatedmaterial</h4>
                                    <p>
                                       <appnotes>Provides researcher with information on materials that have been physically separated or removed. 
         <br/>

         
                                          <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1815')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//bibliography[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//bibliography[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='510'  or @encodinganalog='581' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//bibliography
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e1844">
                                                   <h4>Comments/Application Notes for ead/archdesc//bibliography</h4>
                                                   <p>
                                                      <appnotes>The encoding template defaults to “581” but this may be changed.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e1844')">View Comments/Application Notes</a>

				 </td>
                                             <td>'510'  or '581'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//bibliography
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e1844">
                                             <h4>Comments/Application Notes for ead/archdesc//bibliography</h4>
                                             <p>
                                                <appnotes>The encoding template defaults to “581” but this may be changed.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e1844')">View Comments/Application Notes</a>

				 </td>
                                       <td>'510'  or '581'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//bibliography
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc//bibliography
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1838">
                                    <h4>Comments/Application Notes for ead/archdesc//bibliography</h4>
                                    <p>
                                       <appnotes>Provides researcher with citations to works that are based on or considered highly relevant to the materials being described. Use the 
         <i>&gt;Chicago Style Manual</i>

         to formulate bibliographic entries. 
         <br/>

         
                                          <br/>

         Inside &lt;bibliography&gt; a bibliographic entry may either be tagged in a simple paragraph &lt;p&gt; element or in a more specific fashion, using &lt;bibref&gt;, &lt;persname&gt;, &lt;title&gt;, &lt;imprint&gt;, etc. There is no single correct way to encode &lt;bibliography&gt;; the decision generally is based on individual repository search needs. For additional details, see the 
            <a href="http://www.loc.gov/ead/tglib/" target="_blank">EAD Tag Library</a>

         . Note that elements inside &lt;bibliography&gt; are repeatable. 
         <br/>

         
                                          <br/>

         In the following example, 
         <i>note that text may be added between name and title elements inside &lt;bibref&gt; and that spaces must be included between elements for proper display</i>

         (for example, between &lt;persname&gt; and &lt;title&gt;). 
         <br/>

         
                                          <br/>

         
                                          <b>&lt;bibliography encodinganalog="581"&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;bibref&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;persname&gt;Sucher, David&lt;/persname&gt; (ed.), </b>
         
                                          <br/>

         
                                          <b>[space]</b>
         
                                          <br/>

         
                                          <b>&lt;title render="italic"&gt;Photographs of Puget Sound</b>
         
                                          <br/>

         
                                          <b>Past&lt;/title&gt; [space]</b>
         
                                          <br/>

         
                                          <b>&lt;imprint&gt;(Seattle, Puget Sound Access,</b>
         
                                          <br/>

         
                                          <b>1973)&lt;/imprint&gt; .</b>
         
                                          <br/>

         
                                          <b>&lt;/bibref&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;bibref&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;persname&gt;Frederick, Richard&lt;/persname&gt;</b>
         
                                          <br/>

         
                                          <b>[space] and [space] &lt;persname&gt;Engerman,</b>
         
                                          <br/>

         
                                          <b>Jeanne&lt;/persname&gt;. [space] </b>
         
                                          <br/>

         
                                          <b>&lt;title render="italic"&gt;Asahel Curtis : Photographs</b>
         
                                          <br/>

         
                                          <b>of the Great Northwest&lt;/title&gt; [space]</b>
         
                                          <br/>

         
                                          <b>&lt;imprint&gt;(Tacoma, Washington State Historical</b>
         
                                          <br/>

         
                                          <b>Society, 1983)&lt;/imprint&gt;.</b>
         
                                          <br/>

         
                                          <b>&lt;/bibref&gt;</b>
         
                                          <br/>

         
                                          <b>&lt;/bibliography&gt; </b>
         
                                          <br/>

         
                                          <br/>
         
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1838')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//otherfindaid[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//otherfindaid[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='555'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//otherfindaid
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'555'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//otherfindaid
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'555'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//otherfindaid
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//otherfindaid
&gt; does not appear in this document.<div class="appnotes" id="app.d0e1981">
                                    <h4>Comments/Application Notes for ead/archdesc//otherfindaid</h4>
                                    <p>
                                       <appnotes>Provides researcher with information about additional or alternative guides to the described materials (e.g., card files, correspondence lists, creator generated lists).
		<br/>
		
                                          <br/>
Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e1981')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//relatedmaterial[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//relatedmaterial[not(ancestor::dsc)]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='5441_'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//relatedmaterial
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2010">
                                                   <h4>Comments/Application Notes for ead/archdesc//relatedmaterial</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “relation”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2010')">View Comments/Application Notes</a>

				 </td>
                                             <td>'5441_'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//relatedmaterial
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2010">
                                             <h4>Comments/Application Notes for ead/archdesc//relatedmaterial</h4>
                                             <p>
                                                <appnotes>Dublin Core: “relation”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2010')">View Comments/Application Notes</a>

				 </td>
                                       <td>'5441_'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//relatedmaterial
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc//relatedmaterial
&gt; does not appear in this document.<div class="appnotes" id="app.d0e2004">
                                    <h4>Comments/Application Notes for ead/archdesc//relatedmaterial</h4>
                                    <p>
                                       <appnotes>Provides researcher with information about additional or alternative guides to the described materials (e.g., card files, correspondence lists, creator generated lists).
		<br/>
		
                                          <br/>
Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2004')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//index[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//index[not(ancestor::dsc)]"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//index
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc//index
&gt; does not appear in this document.<div class="appnotes" id="app.d0e2030">
                                    <h4>Comments/Application Notes for ead/archdesc//index</h4>
                                    <p>
                                       <appnotes>Similar to a back-of-the-book index, an index in an encoded finding aid provides a list of key terms (such as names and topics represented in the collection) and linking references to the container(s) or position(s) in the finding aid where the indexed material appears.
         <br/>
         
                                          <br/>
Note: Automatically generated indexes are included in some vendor-encoded finding aids, but due to their length, automatically generated indexes will not be displayed in the researcher site. Optional hand-encoded indexes will be displayed, however.
&lt;index&gt; may contain a &lt;head&gt; element that clarifies the type of index provided, one or more &lt;p&gt; elements if explanatory text is needed, and a series of &lt;indexentry&gt; elements. The &lt;indexentry&gt; contains an access element (such as the &lt;name&gt; or &lt;subject&gt; being indexed), an optional &lt;note&gt;, and one or more optional Pointer &lt;ptr&gt;, Pointer Group &lt;ptrgrp&gt;, or Reference &lt;ref&gt; elements. Plain text cannot be used in an &lt;indexentry&gt;.
See the EAD Tag Library for details on encoding &lt;index&gt; and its subordinate elements, particularly the linking elements.
         <br/>
         
                                          <br/>

                                          <b>&lt;index&gt;</b>
                                          <br/>

                                          <b>&lt;head&gt;Photographer Index&gt;&lt;/head&gt;</b>
                                          <br/>

                                          <b>&lt;p&gt;Names of photographers and studios, and the locations in which they operated, are given as they appear on the photographs (usually stamped or written on the versos).&lt;/p&gt;</b>
                                          <br/>

                                          <b>&lt;indexentry&gt;</b>
                                          <br/>

                                          <b>&lt;corpname&gt;Baker Art Gallery, Columbus, Ohio&lt;/corpname&gt;</b>
                                          <br/>

                                          <b>&lt;ref linktype=”simple” target=”act:0002” actuate=”onrequest” show=”replace”&gt;Grace Arnold&lt;/ref&gt;</b>
                                          <br/>

                                          <b>&lt;ref linktype=”simple” target=”act:0012” actuate=”onrequest” show=”replace”&gt;Nina Beason&lt;/ref&gt;</b>
                                          <br/>

                                          <b>&lt;/indexentry&gt;</b>
                                          <br/>

                                          <b>&lt;indexentry&gt;</b>
                                          <br/>

                                          <b>&lt;corpname&gt;Theo C. Marceau Studio, San Francisco, Calif.&lt;/corpname&gt;</b>
                                          <br/>

                                          <b>&lt;ref linktype=”simple” target=”port:0028” actuate=”onrequest” show=”replace”&gt;Portrait of Robert R. Hayden&lt;/ref&gt;</b>
                                          <br/>

                                          <b>&lt;/indexentry&gt; …</b>
                                          <br/>

                                          <b>&lt;/index&gt;</b>
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2030')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//appraisal[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc//appraisal[not(ancestor::dsc)]"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//appraisal
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc//appraisal
&gt; does not appear in this document.<div class="appnotes" id="app.d0e2098">
                                    <h4>Comments/Application Notes for ead/archdesc//appraisal</h4>
                                    <p>
                                       <appnotes>See the EAD Tag Library for information on this element.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2098')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/controlaccess[not(ancestor::dsc)]">
                        <axsl:for-each select="ead/archdesc/controlaccess[not(ancestor::dsc)]"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/controlaccess
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/archdesc/controlaccess
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2108">
                                 <h4>Comments/Application Notes for ead/archdesc/controlaccess</h4>
                                 <p>
                                    <appnotes>wrapper element that designates key access points, preferably taken from a controlled vocabulary or list, for the materials described in a finding aid. Participating institutions must use &lt;controlaccess&gt; elements in their finding aids:<br/>

                                       <br/>

                                       <ul>

                                          <li>to facilitate faceting on search results;</li>
   
                                          <li>to indicate a personal, family, corporate, or place name with major representation in the materials being described. Names may represent either co-creators of the collection (in addition to the main creator named in &lt;origination&gt;) or subjects of the collection;</li>

                                          <li>to indicate major topics, occupations, functions, or described titles in a collection.</li>

                                       </ul>

                                       <br/>
Assign as many controlled access points as needed to represent the names, topics, places, etc., that are determined to be significant in the collection. Controlled subheadings, such as those approved for use with LC subject headings, may be added as needed, separated by a double hyphen-- (with no spaces between heading terms and hyphens).
With the exception of a period needed for an initial in a personal or corporate name heading, do not end a controlled access heading with a period (the stylesheet supplies the ending period when required by AACR2/MARC). Other ending punctuation required by AACR2/MARC may be used (such as a closing parenthesis, a hyphen to indicate an open date, and a question mark to indicate uncertain birth/death dates).
<br/>

                                       <br/>
In addition, assigning at least one <b>browsing term</b> (encoded in &lt;controlaccess&gt;&lt;subject source=”archiveswest”&gt;) is required.
            Use one &lt;controlaccess&gt; element as a wrapper for all access points, with additional, specific &lt;controlaccess&gt; tags nested inside (as demonstrated in the encoding template&gt;). Types of controlled access terms include &lt;persname&gt;, &lt;famname&gt;, &lt;corpname&gt;, &lt;geogname&gt;, &lt;subject&gt; (LCSH), &lt;subject&gt; (browsing terms), &lt;genreform&gt;, &lt;occupation&gt;, &lt;function&gt;, and &lt;title&gt;. For consistent display of headings, group &lt;controlaccess&gt; terms by type, in the order given above, as in the following example, a (fictional) collection of photographs of Montana Senator Mike Mansfield:
<br/>

                                       <br/>

                                       <b>&lt;controlaccess id=”a12”&gt;</b>
                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;persname encodinganalog="600" source=”lcnaf” role="subject"&gt;Mansfield, Mike, 1903- --Photographs&lt;/persname&gt;</b>
                                       <br/>

                                       <b>&lt;persname encodinganalog="700" rules=”rda” role="photographer"&gt;Oberdorfer, Don&lt;/persname&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;famname encodinganalog=”600” rules=”rda” role=”subject”&gt;Mansfield family--Photographs&lt;/famname&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;corpname encodinganalog=”610” source=”lcnaf” role=”subject”&gt;Montana. Legislature&lt;/corpname&gt;</b>
                                       <br/>

                                       <b>&lt;corpname encodinganalog="710" rules=”aacr2” role="photographer"&gt;Jenkins Photo Studio&lt;/corpname&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;subject encodinganalog=”650” source=”lcsh”&gt;Legislative bodies--United States&lt;/subject&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Political Campaigns&lt;/subject&gt;</b>
                                       <br/>

                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Public Utilities&lt;/subject&gt;</b>
                                       <br/>

                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Public Works&lt;/subject&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess &gt;</b>
                                       <br/>

                                       <b>&lt;genreform source=”gmgpc”</b>
                                       <br/>

                                       <b>encodinganalog=”655”&gt;Portrait photographs&lt;/genreform&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>
                                       <br/>

                                       <b>&lt;occupation encodinganalog=”656” source=”lcsh”&gt;Legislators--United States&lt;/occupation&gt;</b>
                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>

                                       <b>… etc….</b>
                                       <br/>

                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>
                                       <br/>

                                       <br/>
Institutions should use standard sources for name and subject headings when assigning controlled access terms, or standard rules when establishing new controlled access names and terms.
<br/>

                                       <br/>
When a name, subject, or form/genre heading is taken from a standard name authority source, or a subject or form/genre vocabulary, the SOURCE attribute should contain the standard abbreviation for the source. For names, this is usually <b>lcnaf</b> (<a href="http://authorities.loc.gov/" target="_blank">LC Name Authority File</a> as source of established proper names). For subjects and form/genre terms, generally use <b>lcsh</b> (<a href="http://authorities.loc.gov/" target="_blank">Library of Congress Subject Headings</a>), <b>lctgm</b> (<a href="http://www.loc.gov/rr/print/tgm1/toc.html" target="_blank">Library of Congress Thesaurus for Graphic Materials -- topical terms</a>), <b>gmgpc</b> (<a href="http://www.loc.gov/rr/print/tgm2/" target="_blank">Library of Congress Thesaurus for Graphic Materials -- form/genre terms</a>), or <b>aat</b> (<a href="http://www.getty.edu/research/conducting_research/vocabularies/aat/" target="_blank">Art &amp; Architecture Thesaurus</a>).
If the name heading or subject term is not found in a standard source, do the following:
<br/>

                                       <ul>

                                          <li>Leave the SOURCE attribute blank;</li>
   
                                          <li>Construct a name heading following an established content standard such as <a href="http://www.rdatoolkit.org/">RDA</a> or <a href="http://www.alastore.ala.org/SiteSolution.taf?_sn=catalog2&amp;_pn=product_detail&amp;_op=1844" target="_blank">AACR2.</a>
                                          </li>

                                          <li>For a subject or form/genre heading, follow the guidelines for constructing new terms in a standard such as the <a href="http://www.loc.gov/cds/lcsh.html" target="_blank">Library of Congress Subject Cataloging Manual</a> (SCM), <a href="http://www.getty.edu/research/conducting_research/vocabularies/aat/" target="_blank">Art &amp; Architecture Thesaurus</a> (AAT), <a href="http://www.loc.gov/rr/print/tgm1/toc.html" target="_blank">Thesaurus for Graphic Materials</a> (LCTGM), or other vocabulary standard.</li>
   
                                          <li>Use the RULES attribute to indicate the content standard by which the name heading or term is constructed, e.g., "aacr2", "rda", “scm”, “aat”, “lctgm”, etc. Do not use DACS as a rules attribute.</li>

                                          <li>If the term is not constructed according to an established content standard, encode the RULES attribute value as "local".</li>

                                       </ul>

                                       <br/>
For instructions on assigning browsing terms, see under &lt;subject&gt; browsing terms below.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2108')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//persname">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//persname">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='600'  or @encodinganalog='700' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//persname
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2355">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                                   <p>
                                                      <appnotes>Use ”600” if the name represents a subject of the collection. Use ”700” if the name is a co-creator or contributor. If a name functions as both a co-creator and a subject of a collection, prepare two &lt;persname&gt; entries for that individual: one with encodinganalog=”600” and role=”subject” to denote the person as a subject, the other with encodinganalog=”700” and role=”photographer” (or other appropriate role term) to indicate the person as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                         <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2355')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '600'  or  '700' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//persname
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2355">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                             <p>
                                                <appnotes>Use ”600” if the name represents a subject of the collection. Use ”700” if the name is a co-creator or contributor. If a name functions as both a co-creator and a subject of a collection, prepare two &lt;persname&gt; entries for that individual: one with encodinganalog=”600” and role=”subject” to denote the person as a subject, the other with encodinganalog=”700” and role=”photographer” (or other appropriate role term) to indicate the person as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                   <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2355')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '600'  or  '700' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//persname
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2374">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                          <p>
                                             <appnotes>Use “lcnaf” if the name is established in the LC Name Authority File. Use the appropriate abbreviation or code for any other authority from which the heading is taken, e.g., "ulan" (<a href="http://www.getty.edu/research/conducting_research/vocabularies/ulan/" target="_blank">Union List of Artists Names</a>). If the name does not appear in an authority file, leave blank, and use the RULES attribute to indicate how the name is established.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2374')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//persname
				 </td>
                                    <td>rules=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @rules<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2385">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                          <p>
                                             <appnotes>If there is no name authority record available for a particular name, establish the name heading and use “rda” or “aacr2” to indicate that the name has been formulated according to RDA or AACR2 rules. Do not use DACS as a rules attribute. If the form of the name is not based on a content standard such as RDA or AACR2, use “local” instead.
<br/>

                                                <br/>
If the name is taken from a standard name authority file, leave the RULES attribute blank and identify the name authority source in the SOURCE attribute.
            </appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2385')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//persname
				 </td>
                                       <td>role=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @role<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2397">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                             <p>
                                                <appnotes>Use ”subject” if the name is a subject of the collection (the ENCODINGANALOG value should be “600”); use “creator,” “contributor,” or other term if the person contributed to creation of the content of the collection (the ENCODINGANALOG value should be “700”). Select the role term from the relator term section of the <a href="http://www.loc.gov/marc/relators/relaterm.html" target="_blank">MARC Code List for Relators, Sources, Description Conventions</a>.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2397')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//persname
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//persname
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2353">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//persname</h4>
                                 <p>
                                    <appnotes>Access terms related to personal names representing significant subject(s) and/or co-creator(s) of the collection. Provide one or more &lt;persname&gt; elements.
<br/>

                                       <br/>
Use the form of the name(s) located in a standard naming authority file, such as the <a href="http://authorities.loc.gov/" target="_blank">Library of Congress Name Authority File</a>. If a name does not appear in an authority file, establish the name according to a content standard such as RDA or AACR2.
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens). With the exception of a period needed for an initial in a personal name heading, do not end a personal name heading with a period (the stylesheet supplies the ending period when required by AACR2/MARC). Other ending punctuation required by AACR2/MARC may be used (such as a closing parenthesis, a hyphen to indicate an open date, and a question mark to indicate uncertain birth/death dates).
<br/>

                                       <br/>

                                       <b>&lt;persname encodinganalog=”600” source=”lcnaf” role=”subject”&gt;Lough, Harold--Archives&lt;/persname&gt;</b>
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2353')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//famname">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//famname">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='600'  or @encodinganalog='700' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//famname
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2427">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                                   <p>
                                                      <appnotes>Use ”600” if the family name represents a subject of the collection. Use ”700” if the name is a co-creator or contributor.
<br/>

                                                         <br/>
If a family name functions as both a co-creator and a subject of a collection, prepare two &lt;famname&gt; entries for that family: one with encodinganalog=”600” and role=”subject” to denote the family as a subject, the other with encodinganalog=”700” and role=”creator” (or other appropriate term) to indicate the family as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                         <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2427')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '600'  or  '700' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//famname
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2427">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                             <p>
                                                <appnotes>Use ”600” if the family name represents a subject of the collection. Use ”700” if the name is a co-creator or contributor.
<br/>

                                                   <br/>
If a family name functions as both a co-creator and a subject of a collection, prepare two &lt;famname&gt; entries for that family: one with encodinganalog=”600” and role=”subject” to denote the family as a subject, the other with encodinganalog=”700” and role=”creator” (or other appropriate term) to indicate the family as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                   <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2427')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '600'  or  '700' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//famname
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2450">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                          <p>
                                             <appnotes>Because family names do not appear in the Library of Congress Name Authority File, leave this attribute blank. Use the RULES attribute instead to indicate that the form of the name follows AACR2 rules.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2450')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//famname
				 </td>
                                    <td>rules=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @rules<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2458">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                          <p>
                                             <appnotes>Use “rda” to indicate that the name has been formulated according to RDA.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2458')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//famname
				 </td>
                                       <td>role=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @role<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2466">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                             <p>
                                                <appnotes>Use ”subject” if the name is a subject in the collection (the ENCODINGANALOG value should be “600”); use “creator,” “contributor,” or other term if the family contributed to creation of the content of the collection (the ENCODINGANALOG value should be “700”). Select the role term from the relator term section of the <a href="http://www.loc.gov/marc/relators/relaterm.html" target="_blank">MARC Code List for Relators, Sources, Description Conventions</a>.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2466')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//controlaccess//famname
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//controlaccess//famname
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2425">
                                    <h4>Comments/Application Notes for ead/archdesc//controlaccess//famname</h4>
                                    <p>
                                       <appnotes>Access terms related to family names. Use one or more &lt;famname&gt; elements to represent significant subject(s) and/or co-creator(s) of the collection.
<br/>

                                          <br/>
            Because family names do not appear in the Library of Congress Name Authority File (but rather as LC Subject Authority headings that designate only one form of a family name as the authorized form), establish the name according to RDA.
<br/>

                                          <br/>
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens). Do not end the heading in a period.
<br/>

                                          <br/>

                                          <b>&lt;famname encodinganalog=”600” rules=”rda” role=”subject”&gt;McColl family--Archives&lt;/famname&gt;</b>
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2425')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//corpname">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//corpname">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='610'  or @encodinganalog='611'  or @encodinganalog='710'  or @encodinganalog='711' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//corpname
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2497">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                                   <p>
                                                      <appnotes>For an organization: Use ”610” for the name as a subject of the collection, or use ”710” for the name as a co- creator or contributor of the collection.
<br/>

                                                         <br/>
For a conference or meeting: Use “611” for the conference name as a subject of the collection, or use “711” for the conference name as a co-creator or contributor.
<br/>

                                                         <br/>
If a corporate name functions as both a creator and a subject of a collection (as when the records of a subordinate agency are included as a subgroup in the records for the parent agency), prepare two &lt;corpname&gt; entries for that corporate name: one with encodinganalog=”610” and role=”subject” to denote the corporate body as a subject, the other with encodinganalog=”710” and role=”creator” (or other appropriate role term) to indicate the body as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                         <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2497')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '610'  or  '611'  or  '710'  or  '711' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//corpname
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2497">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                             <p>
                                                <appnotes>For an organization: Use ”610” for the name as a subject of the collection, or use ”710” for the name as a co- creator or contributor of the collection.
<br/>

                                                   <br/>
For a conference or meeting: Use “611” for the conference name as a subject of the collection, or use “711” for the conference name as a co-creator or contributor.
<br/>

                                                   <br/>
If a corporate name functions as both a creator and a subject of a collection (as when the records of a subordinate agency are included as a subgroup in the records for the parent agency), prepare two &lt;corpname&gt; entries for that corporate name: one with encodinganalog=”610” and role=”subject” to denote the corporate body as a subject, the other with encodinganalog=”710” and role=”creator” (or other appropriate role term) to indicate the body as one of the creators of the collection. Do not list the main creator of the collection in both &lt;origination&gt; and &lt;controlaccess&gt;. The main creator (flagged as a creator by the use of the ENCODINGANALOG and ROLE attributes) belongs only in &lt;origination&gt;.
<br/>

                                                   <br/>
Dublin Core: “subject | contributor”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2497')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '610'  or  '611'  or  '710'  or  '711' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//corpname
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2530">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                          <p>
                                             <appnotes>Use “lcnaf” if the name is established in LC Name Authority File. Use the appropriate abbreviation or code for any other authority from which heading is taken. If the name does not appear in an authority file, leave blank, and use the RULES attribute to indicate how the name is established.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2530')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//corpname
				 </td>
                                    <td>rules=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @rules<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2538">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                          <p>
                                             <appnotes>If there is no name authority record available for a particular name, use “rda” or “aacr2” to indicate that the name has been formulated according to RDA or AACR2 rules. Do not use DACS as a rules attribute. If the form of the name is not based on a content standard such as RDA or AACR2, use “local” instead.
			<br/>
			
                                                <br/>
If the name is taken from a standard name authority file, leave the RULES attribute blank and identify the name authority source in the SOURCE attribute.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2538')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//corpname
				 </td>
                                       <td>role=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @role<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2550">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                             <p>
                                                <appnotes>Use ”subject” if the name is a subject in the collection (the ENCODINGANALOG value should be “610”); use “creator,” “contributor,” or other term if the corporate body contributed to creation of the content of the collection (the ENCODINGANALOG value should be “710”). Select the role term from the relator term section of the <a href="http://www.loc.gov/marc/relators/relaterm.html" target="_blank">MARC Code List for Relators, Sources, Description Conventions</a>.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2550')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//corpname
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//corpname
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2495">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//corpname</h4>
                                 <p>
                                    <appnotes>Accommodates access terms related to corporate and conference names representing significant subject(s) and/or co-creator(s) of the collection. Provide one or more &lt;corpname&gt; elements. Use the form of the name(s) located in a standard naming authority file, such as the <a href="http://authorities.loc.gov/" target="_blank">Library of Congress Name Authority File</a>. If a name does not appear in an authority file, establish the name according to a content standard such as RDA or  <a href="http://www.alastore.ala.org/SiteSolution.taf?_sn=catalog2&amp;_pn=product_detail&amp;_op=1844" target="_blank">AACR2</a>. Do not use DACS as a rules attribute.
<br/>

                                       <br/>
Controlled subheadings may be added if needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens). With the exception of a period needed for an initial in a corporate name heading, do not end a corporate name heading with a period (the stylesheet supplies the ending period when required by AACR2/MARC). Other ending punctuation required by AACR2/MARC may be used (such as a closing parenthesis).
<br/>

                                       <br/>

                                       <b>&lt;corpname encodinganalog=”610” source=”lcnaf” role=”subject”&gt;Boeing Airplane Company&lt;/corpname&gt;</b>
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2495')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//geogname">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//geogname">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='651' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//geogname
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2583">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “coverage” (spatial).</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2583')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '651' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//geogname
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2583">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                             <p>
                                                <appnotes>Dublin Core: “coverage” (spatial).</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2583')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '651' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//geogname
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2595">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                          <p>
                                             <appnotes>Use “lcsh” if name is established in LCSH. Use abbreviation or code for any other authority from which heading is taken, e.g., "tgn". If name is unestablished, leave blank.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2595')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//geogname
				 </td>
                                    <td>rules=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @rules<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2603">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                          <p>
                                             <appnotes>If there is no authority record available for a particular place, feature, or jurisdiction name, use “scm” to indicate that the name has been formulated according to the LC Subject Cataloging Manual.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2603')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role">
                                 <axsl:choose>
                                    <axsl:when test="@role='subject'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//geogname
				 </td>
                                             <td>role
= </td>
                                             <td>Rec
				 </td>
                                             <td>@role is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2611">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                                   <p>
                                                      <appnotes>Use ”subject” since the geographic name is a subject in the collection.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2611')">View Comments/Application Notes</a>

				 </td>
                                             <td>'subject'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//geogname
				 </td>
                                       <td>role=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @role<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2611">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                             <p>
                                                <appnotes>Use ”subject” since the geographic name is a subject in the collection.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2611')">View Comments/Application Notes</a>

				 </td>
                                       <td>'subject'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//geogname
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//geogname
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2581">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//geogname</h4>
                                 <p>
                                    <appnotes>Access terms related to places, natural features, or political jurisdictions. Use one or more &lt;geogname&gt; tags.
<br/>

                                       <br/>
Take the geographic term from a standard geographic authority file, such as the <a href="http://authorities.loc.gov/" target="_blank">Library of Congress Subject Headings</a> or the <a href="http://www.getty.edu/research/conducting_research/vocabularies/tgn/index.html" target="_blank">Getty Thesaurus for Geographic Names</a>. If a term does not appear in an authority file, establish the term according to a content standard such as the <a href="http://www.loc.gov/cds/lcsh.html" target="_blank">LC Subject Cataloging Manual</a>.
<br/>

                                       <br/>
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens).
<br/>

                                       <br/>
With the exception of a period needed for an initial, do not end a geographic heading with a period (the stylesheet supplies the ending period when required by AACR2/MARC). Other ending punctuation required by AACR2/MARC may be used (such as a closing parenthesis).
<br/>

                                       <br/>

                                       <b>&lt;geogname encodinganalog=”651” source=”lcsh”&gt;United States--Foreign relations--20th century&lt;/geogname&gt;</b>
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2581')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//subject[not(@source='archiveswest')]">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//subject[not(@source='archiveswest')]">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='650'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//subject
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2656">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “subject”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2656')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '650' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//subject
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2656">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                             <p>
                                                <appnotes>Dublin Core: “subject”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2656')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '650' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//subject
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2668">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                          <p>
                                             <appnotes>The program recommends that repositories use LCSH as the source of subject headings used in finding aids; set SOURCE to "lcsh." For any other source used, such as the LC Thesaurus for Graphic Materials (“lctgm”), use the appropriate code from the Library of Congress' <a href="http://www.loc.gov/marc/relators/relasour.html" target="_blank">Term, Name, and Title Sources code list</a>.
<br/>

                                                <br/>
Institutions that participate in the Library of Congress <a href="http://www.loc.gov/catdir/pcc/saco/saco.html" target="_blank">SACO program</a> may propose a new heading for inclusion in LCSH if needed. If the term is approved, use it in the &lt;subject&gt; element and set SOURCE to “lcsh”.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2668')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules">
                                 <axsl:choose>
                                    <axsl:when test="@rules=''"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//subject
				 </td>
                                             <td>rules
= </td>
                                             <td>Opt
				 </td>
                                             <td>@rules is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2686">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                                   <p>
                                                      <appnotes>Leave blank.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2686')">View Comments/Application Notes</a>

				 </td>
                                             <td>''  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//subject
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2686">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                             <p>
                                                <appnotes>Leave blank.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2686')">View Comments/Application Notes</a>

				 </td>
                                       <td>''  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//subject
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//subject
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2654">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject</h4>
                                 <p>
                                    <appnotes>Access terms related to topics. Use one or more &lt;subject&gt; tags.
<br/>

                                       <br/>
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens).
<br/>

                                       <br/>
With the exception of a period needed for an initial, do not end a subject heading with a period (the stylesheet supplies the ending period when required by LCSH/MARC). Other ending punctuation required by LCSH/MARC may be used (such as a closing parenthesis).
<br/>

                                       <br/>

                                       <b>&lt;subject encodinganalog=”650” source=”lcsh”&gt;Japanese Americans--Evacuation and relocation, 1942-1945&lt;/subject&gt;</b>
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2654')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//subject[@source='archiveswest']">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//subject[@source='archiveswest']">
                           <axsl:choose>
                              <axsl:when test="@altrender">
                                 <axsl:choose>
                                    <axsl:when test="@altrender='nodisplay'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                          <td>altrender
= </td>
                                          <td>Req
				 </td>
                                          <td>@altrender is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e2717">
                                                <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                                <p>
                                                   <appnotes>The browsing terms are not displayed in the finding aids themselves; rather, they appear on the researcher site as browsing headings under which are grouped all finding aids that include materials significant to that topic. The ALTRENDER attribute value of “nodisplay” is used for that purpose.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e2717')">View Comments/Application Notes</a>

				 </td>
                                          <td>'nodisplay' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                    <td>altrender=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @altrender<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2717">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                          <p>
                                             <appnotes>The browsing terms are not displayed in the finding aids themselves; rather, they appear on the researcher site as browsing headings under which are grouped all finding aids that include materials significant to that topic. The ALTRENDER attribute value of “nodisplay” is used for that purpose.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2717')">View Comments/Application Notes</a>

				 </td>
                                    <td>'nodisplay' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source">
                                 <axsl:choose>
                                    <axsl:when test="@source='archiveswest'"/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                          <td>source
= </td>
                                          <td>Req
				 </td>
                                          <td>@source is not set correctly <axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e2729">
                                                <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                                <p>
                                                   <appnotes>For each browsing term assigned, enter “archiveswest” in the SOURCE attribute.</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e2729')">View Comments/Application Notes</a>

				 </td>
                                          <td>'archiveswest' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                    <td>source=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e2729">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                          <p>
                                             <appnotes>For each browsing term assigned, enter “archiveswest” in the SOURCE attribute.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e2729')">View Comments/Application Notes</a>

				 </td>
                                    <td>'archiveswest' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules">
                                 <axsl:choose>
                                    <axsl:when test="@rules=''"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                             <td>rules
= </td>
                                             <td>Opt
				 </td>
                                             <td>@rules is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2741">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                                   <p>
                                                      <appnotes>Leave blank.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2741')">View Comments/Application Notes</a>

				 </td>
                                             <td>''  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2741">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                             <p>
                                                <appnotes>Leave blank.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2741')">View Comments/Application Notes</a>

				 </td>
                                       <td>''  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='690'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Opt
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2752">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                                   <p>
                                                      <appnotes>If desired, browsing terms may be mapped to the MARC 690 field (used for local topical terms).</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2752')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '690' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2752">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                             <p>
                                                <appnotes>If desired, browsing terms may be mapped to the MARC 690 field (used for local topical terms).</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2752')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '690' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//subject AW browsing terms
				 </td>
                           <td> </td>
                           <td>Req
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//subject AW browsing terms
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2715">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//subject AW browsing terms</h4>
                                 <p>
                                    <appnotes>To facilitate browsing of collections included in the database, encoders should add topical “browsing” terms as appropriate to the materials described. Only use terms included on the alphabetically arranged <a href="https://drive.google.com/file/d/1u7IbWDMAH2sk59nU3YMpIU5bAUEpZp92/view?usp=sharing" target="_blank">EAD Best Practices</a>. Assign terms representing topics, places, and material types that are represented significantly in the collection.
<br/>

                                       <br/>
Specificity: As a rule of thumb when assigning terms, select the term(s) that most closely and specifically match the content of the collection. E.g., the browsing term list contains place terms for both cities and states/provinces. For a collection concerned primarily with Juneau, assign “Juneau” but not “Alaska” as the browsing term representing place. For a collection covering various locations in Alaska, assign “Alaska”. For a collection featuring significant coverage of Juneau as well as other locations in the state, both “Juneau” and “Alaska” would be appropriate.
<br/>

                                       <br/>
As appropriate to the intellectual content of the described materials, assign to the finding aid at least one browsing term. More browsing terms may be assigned as needed.
<br/>

                                       <br/>
For each browsing term assigned, enter “archiveswest” in the SOURCE attribute. Set the ALTRENDER attribute to “nodisplay” and set ENCODINGANALOG to “690”.
<br/>

                                       <br/>
The assigned browsing terms should be nested inside a &lt;controlaccess&gt; wrapper element. Note that all browsing terms are placed in &lt;subject&gt;, even geographic and “Material Type” terms. Do not use subheadings. Do not end with a period.
<br/>

                                       <br/>

                                       <b>&lt;controlaccess&gt;</b>

                                       <br/>

                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Music&lt;/subject&gt;</b>

                                       <br/>
            
                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Performing Arts&lt;/subject&gt;</b>

                                       <br/>
            
                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Chinese Americans&lt;/subject&gt;</b>

                                       <br/>
            
                                       <b>&lt;subject altrender=”nodisplay” source=”archiveswest” encodinganalog=”690”&gt;Women&lt;/subject&gt;</b>

                                       <br/>

                                       <b>&lt;/controlaccess&gt;</b>

                                       <br/>

                                       <br/>

                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2715')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//genreform">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//genreform">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='655' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//genreform
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2825">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “type”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2825')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '655' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//genreform
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2825">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                             <p>
                                                <appnotes>Dublin Core: “type”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2825')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '655' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//genreform
				 </td>
                                       <td>source=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @source<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2837">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                             <p>
                                                <appnotes>Encode appropriate code for source found in the Library of Congress' <a href="http://www.loc.gov/marc/relators/relasour.html" target="_blank">Term, Name, and Title Sources</a> code list, usually “lcsh” or “aat” or “gmgpc”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2837')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules">
                                 <axsl:choose>
                                    <axsl:when test="@rules=''"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//genreform
				 </td>
                                             <td>rules
= </td>
                                             <td>Opt
				 </td>
                                             <td>@rules is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2848">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                                   <p>
                                                      <appnotes>Leave blank.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2848')">View Comments/Application Notes</a>

				 </td>
                                             <td>''  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//genreform
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2848">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                             <p>
                                                <appnotes>Leave blank.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2848')">View Comments/Application Notes</a>

				 </td>
                                       <td>''  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//controlaccess//genreform
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//controlaccess//genreform
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2823">
                                    <h4>Comments/Application Notes for ead/archdesc//controlaccess//genreform</h4>
                                    <p>
                                       <appnotes>Access terms related to genre or form terms. Use one or more &lt;genreform&gt; tags to list major genres and/or forms of material represented in the materials described. To enhance retrieval by form/genre, the program strongly encourages participants to add &lt;genreform&gt; entries for photographs, moving images, sound recordings, scrapbooks, diaries, artifacts, and oral histories.
<br/>

                                          <br/>
If the controlled vocabulary source from which the genre or form term was taken provides guidance on the addition of subheadings, follow those rules to provide a subheading that qualifies the main heading in some way (if desired). Separate a main heading from a subheading with a double hyphen -- (with no spaces between heading terms and hyphens). Do not end with a period.
<br/>

                                          <br/>

                                          <b>&lt;genreform encodinganalog=”655” source=”gmgpc”&gt;Portrait photographs--1920-1930&lt;/genreform&gt;</b>
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2823')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//occupation">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//occupation">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='656'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//occupation
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2875">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “subject”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2875')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '656' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//occupation
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2875">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                             <p>
                                                <appnotes>Dublin Core: “subject”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2875')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '656' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//occupation
				 </td>
                                       <td>source=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @source<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2887">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                             <p>
                                                <appnotes>Encode appropriate code for source found in the Library of Congress' <a href="http://www.loc.gov/marc/relators/relasour.html" target="_blank">Term, Name, and Title Sources</a> code list, usually “lcsh” or “aat” or “gmgpc”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2887')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules">
                                 <axsl:choose>
                                    <axsl:when test="@rules=''"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//occupation
				 </td>
                                             <td>rules
= </td>
                                             <td>Opt
				 </td>
                                             <td>@rules is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2898">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                                   <p>
                                                      <appnotes>Leave blank.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2898')">View Comments/Application Notes</a>

				 </td>
                                             <td>''  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//occupation
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2898">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                             <p>
                                                <appnotes>Leave blank.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2898')">View Comments/Application Notes</a>

				 </td>
                                       <td>''  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//controlaccess//occupation
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//controlaccess//occupation
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2873">
                                    <h4>Comments/Application Notes for ead/archdesc//controlaccess//occupation</h4>
                                    <p>
                                       <appnotes>Access terms related to types of work or professions. Use one or more &lt;occupation&gt; tags. If dictated by institutional policy, occupation terms may be placed in the &lt;subject&gt; element rather than the &lt;occupation&gt; element.
<br/>

                                          <br/>
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens). Do not end an occupation heading with a period (the stylesheet supplies the ending period when required by LCSH/MARC). Other ending punctuation required by LCSH/MARC may be used (such as a closing parenthesis).
<br/>

                                          <br/>

                                          <b>&lt;occupation encodinganalog=”656” source=”lcsh”&gt;College teachers--Idaho&lt;/occupation&gt;</b>
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2873')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//function">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//function">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='657'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//function
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2925">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “subject”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2925')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '657' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//function
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2925">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                             <p>
                                                <appnotes>Dublin Core: “subject”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2925')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '657' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//function
				 </td>
                                       <td>source=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @source<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2937">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                             <p>
                                                <appnotes>Encode appropriate code for source found in the Library of Congress' <a href="http://www.loc.gov/marc/relators/relasour.html" target="_blank">Term, Name, and Title Sources</a> code list, usually “lcsh” or “aat” or “gmgpc”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2937')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules">
                                 <axsl:choose>
                                    <axsl:when test="@rules=''"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//function
				 </td>
                                             <td>rules
= </td>
                                             <td>Opt
				 </td>
                                             <td>@rules is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2948">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                                   <p>
                                                      <appnotes>Leave blank.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2948')">View Comments/Application Notes</a>

				 </td>
                                             <td>''  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//function
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2948">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                             <p>
                                                <appnotes>Leave blank.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2948')">View Comments/Application Notes</a>

				 </td>
                                       <td>''  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc//controlaccess//function
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;ead/archdesc//controlaccess//function
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2923">
                                    <h4>Comments/Application Notes for ead/archdesc//controlaccess//function</h4>
                                    <p>
                                       <appnotes>Access terms related to spheres of activity and/or processes that generated the described materials. If dictated by institutional policy, function terms may be placed in the &lt;subject&gt; element rather than the &lt;function&gt; element.
<br/>

                                          <br/>
Controlled subheadings may be added as needed, separated by a double hyphen -- (with no spaces between heading terms and hyphens). Do not end a function heading with a period (the stylesheet supplies the ending period when required by LCSH/MARC). Other ending punctuation required by LCSH/MARC may be used (such as a closing parenthesis).
<br/>

                                          <br/>

                                          <b>&lt;function encodinganalog=”657” source=”lcsh”&gt;City planning--Oregon--Eugene&lt;/function&gt;</b>
                                       </appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e2923')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc//controlaccess[not(ancestor::dsc)]//title">
                        <axsl:for-each select="ead/archdesc//controlaccess[not(ancestor::dsc)]//title">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='630'  or @encodinganalog='730'  or @encodinganalog='740' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc//controlaccess//title
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e2975">
                                                   <h4>Comments/Application Notes for ead/archdesc//controlaccess//title</h4>
                                                   <p>
                                                      <appnotes>Encoding analog 630 will be used to provide subject access to collections with material about a given published work. These may be forms of titles found either in LCNAF (as with 730, below) or in the LC Name/Title Authority file (as with 740, below).
<br/>

                                                         <br/>
Encoding analog 740 will more frequently be used for standardized forms of titles contained within a collection. Such titles will not be found in LCNAF, but will be found in the LC Name/Title Authority Headings. These titles are established following their author's name, so the author must be searched in this file, and the form of the title desired will be found in the subfield "$t" in the MARC authority record. EAD tagging does not provide for the encoding of these "Author/Title" entries, therefore the title is to be taken from the "$t" of these authority records, encoded as &lt;controlaccess&gt;&lt;title&gt;, with encodinganalog="740".
<br/>

                                                         <br/>
Encoding analog 730 will be used very rarely. 730 is used in the case where a text of the work is contained in the collection being described, there is no known author, and a Uniform Title heading has been established in the LC Name Authority File (LCNAF). More rarely, a collection may contain a work that was published as part of a larger work. If access by the title of this larger work is desired, encoding analog 730 may be used in providing this title.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e2975')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '630'  or  '730'  or  '740' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc//controlaccess//title
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e2975">
                                             <h4>Comments/Application Notes for ead/archdesc//controlaccess//title</h4>
                                             <p>
                                                <appnotes>Encoding analog 630 will be used to provide subject access to collections with material about a given published work. These may be forms of titles found either in LCNAF (as with 730, below) or in the LC Name/Title Authority file (as with 740, below).
<br/>

                                                   <br/>
Encoding analog 740 will more frequently be used for standardized forms of titles contained within a collection. Such titles will not be found in LCNAF, but will be found in the LC Name/Title Authority Headings. These titles are established following their author's name, so the author must be searched in this file, and the form of the title desired will be found in the subfield "$t" in the MARC authority record. EAD tagging does not provide for the encoding of these "Author/Title" entries, therefore the title is to be taken from the "$t" of these authority records, encoded as &lt;controlaccess&gt;&lt;title&gt;, with encodinganalog="740".
<br/>

                                                   <br/>
Encoding analog 730 will be used very rarely. 730 is used in the case where a text of the work is contained in the collection being described, there is no known author, and a Uniform Title heading has been established in the LC Name Authority File (LCNAF). More rarely, a collection may contain a work that was published as part of a larger work. If access by the title of this larger work is desired, encoding analog 730 may be used in providing this title.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e2975')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '630'  or  '730'  or  '740' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//title
				 </td>
                                    <td>source=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @source<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e3001">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//title</h4>
                                          <p>
                                             <appnotes>Use “lctah” when title is established in LC Title or LC Name/Title Authority Headings file. Use abbreviation or code for any other authority from which heading is taken. If title is unestablished, leave blank.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e3001')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc//controlaccess//title
				 </td>
                                    <td>rules=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @rules<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e3009">
                                          <h4>Comments/Application Notes for ead/archdesc//controlaccess//title</h4>
                                          <p>
                                             <appnotes>Use “aacr2” if the title is not taken from an authorized source as described above, but is formulated according to AACR2.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e3009')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc//controlaccess//title
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;ead/archdesc//controlaccess//title
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e2973">
                                 <h4>Comments/Application Notes for ead/archdesc//controlaccess//title</h4>
                                 <p>
                                    <appnotes>Access terms related to titles of published works to which a collection is related, such as monographs, serials, or paintings represented prominently in the collection. Do not end in a period unless the title ends in an initial.
<br/>

                                       <br/>

                                       <b>&lt;title render=”italic” encodinganalog=”630” source=”lctah”&gt;Bozeman daily chronicle&lt;/title&gt;</b>
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e2973')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
               </tbody>
            </table>

   
            <h2>Table 3 &lt;dsc&gt;</h2>
            <table border="1" width="100%" rules="all">
               <tbody>
                  <tr>
                     <th width="20%">Element Location</th>
                     <th width="15%">Attributes or Child Elements</th>
                     <th width="5%">Status</th>
                     <th width="40%">Comments/Application Notes</th>
                     <th width="20%">Possible Values</th>
                  </tr>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc">
                        <axsl:for-each select="ead/archdesc/dsc">
                           <axsl:choose>
                              <axsl:when test="@type">
                                 <axsl:choose>
                                    <axsl:when test="@type='combined'  or @type='analyticover'  or @type='in-depth' "/>
                                    <axsl:otherwise>
                                       <tr>
                                          <td>ead/archdesc/dsc
				 </td>
                                          <td>type=
									 </td>
                                          <td>Req
				 </td>
                                          <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                             <div class="appnotes" id="app.d0e3039">
                                                <h4>Comments/Application Notes for ead/archdesc/dsc</h4>
                                                <p>
                                                   <appnotes>While the program does not prescribe a particular type of component part presentation, it strongly encourages repositories to use the "combined" approach, where each major subdivision is described and immediately followed by a container list at one or more narrower levels. "Combined" facilitates stylesheet manipulation of multi-level finding aid data. 
            <br/>

            
                                                      <br/>

            For finding aids that include a narrative description of major subdivisions, such as series and subseries, but that lack a file- or item-level container list, use"analyticover". 
            <br/>

            
                                                      <br/>

            For finding aids that lack any major subdivisions and consist only of a high-level description followed by a file- or item-level container list, use "in-depth".</appnotes>
                                                </p>
                                             </div>
                                             <br/>
                                             <a class="appnotes-link" onclick="getAppNotes('app.d0e3039')">View Comments/Application Notes</a>

				 </td>
                                          <td>'combined'  or 'analyticover'  or 'in-depth' 
				 </td>
                                       </tr>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <tr>
                                    <td>ead/archdesc/dsc
				 </td>
                                    <td>type=
					 </td>
                                    <td>Req
				 </td>
                                    <td> Missing @type<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e3039">
                                          <h4>Comments/Application Notes for ead/archdesc/dsc</h4>
                                          <p>
                                             <appnotes>While the program does not prescribe a particular type of component part presentation, it strongly encourages repositories to use the "combined" approach, where each major subdivision is described and immediately followed by a container list at one or more narrower levels. "Combined" facilitates stylesheet manipulation of multi-level finding aid data. 
            <br/>

            
                                                <br/>

            For finding aids that include a narrative description of major subdivisions, such as series and subseries, but that lack a file- or item-level container list, use"analyticover". 
            <br/>

            
                                                <br/>

            For finding aids that lack any major subdivisions and consist only of a high-level description followed by a file- or item-level container list, use "in-depth".</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e3039')">View Comments/Application Notes</a>

				 </td>
                                    <td>'combined'  or 'analyticover'  or 'in-depth' 
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/dsc
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc/dsc
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3033">
                                 <h4>Comments/Application Notes for ead/archdesc/dsc</h4>
                                 <p>
                                    <appnotes>A wrapper element that bundles information about the hierarchical arrangement of the materials being described. The &lt;dsc&gt; element surrounds all other (subordinate) elements in the Description of Component Parts section of the finding aid. A single &lt;dsc&gt; should be used with nested components in which descriptions for subgrp, series, subseries, file, item, and otherlevel (as reflected in the intellectual arrangement of the collection) are placed at the appropriate level in the component hierarchy.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3033')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="//c01|//c02|//c03|//c04|//c05|//c06|//c07|//c08|//c09|//c10|//c11|//c12|//c">
                        <axsl:for-each select="//c01|//c02|//c03|//c04|//c05|//c06|//c07|//c08|//c09|//c10|//c11|//c12|//c">
                           <axsl:choose>
                              <axsl:when test="@level or @otherlevel"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>c/c0x
				 </td>
                                    <td> </td>
                                    <td>MA
				 </td>
                                    <td>You must supply at least one of the attributes: level or otherlevel<div class="appnotes" id="app.d0e3071">
                                          <h4>Comments/Application Notes for c/c0x</h4>
                                          <p>
                                             <appnotes>The program has defined the following levels, as reflected in the arrangement of the collection: 
            <br/>

            
                                                <br/>

            “subgrp” “series” “subseries” “file” and “item”. (Also acceptable, though less frequently used in component descriptions, are “collection” and “recordgrp”.) Use one of these terms for each level of the &lt;c0x&gt; structure. 
            <br/>

            
                                                <br/>

            A level designation of “subseries” or “file” may be repeated in a subsequent &lt;c0x&gt;; i.e., it is acceptable to nest a subseries within a subseries, or a file within a file. Encoders may simply repeat the term “subseries” or “file” in the nested LEVEL attribute, or they may add the prefix “sub” to either term (“sub-subseries” or “sub-file”). If the prefix is used, however, the attributes must be encoded as follows: 
            <br/>

            
                                                <br/>

            &lt;c04 level=”otherlevel” otherlevel=”sub-subseries”&gt; 
            <br/>

            
                                                <br/>

            The program has approved the use of the value “otherlevel” to accommodate accession-level entries. If this is used, put the value “accession” into the OTHERLEVEL attribute. Do not use "otherlevel" for box-level descriptions; use "file"
            <br/>

            
                                                <br/>

            For details, see Component Tags.</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e3071')">View Comments/Application Notes</a>

				 </td>
                                    <td>n/a
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>c/c0x
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;c/c0x
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e3069">
                                 <h4>Comments/Application Notes for c/c0x</h4>
                                 <p>
                                    <appnotes>Encoders must use numbered (&lt;c01&gt;-&lt;c12&gt;) component elements; it provides a clearer view of the hierarchical structure and makes computer manipulation easier. 
         <br/>

         
                                       <br/>
         
                                    </appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3069')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="//dsc//did">
                        <axsl:for-each select="//dsc//did"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>c/c0x did
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; c/c0x did
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3150">
                                 <h4>Comments/Application Notes for c/c0x did</h4>
                                 <p>
                                    <appnotes>A required wrapper element that bundles other elements identifying core information about the described materials.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3150')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//unitid">
                        <axsl:for-each select="ead/archdesc/dsc//unitid">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='099'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitids
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3158">
                                                   <h4>Comments/Application Notes for component unitids</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “identifier”</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3158')">View Comments/Application Notes</a>

				 </td>
                                             <td>'099'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitids
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3158">
                                             <h4>Comments/Application Notes for component unitids</h4>
                                             <p>
                                                <appnotes>Dublin Core: “identifier”</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3158')">View Comments/Application Notes</a>

				 </td>
                                       <td>'099'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>component unitids
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; component unitids
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3156">
                                 <h4>Comments/Application Notes for component unitids</h4>
                                 <p>
                                    <appnotes>Unique identifiers should be encoded in &lt;unitid&gt; rather than &lt;container&gt; or &lt;unittitle&gt; (e.g., &lt;unitid&gt;Series A&lt;/unitid&gt;).</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3156')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//did/container">
                        <axsl:for-each select="ead/archdesc/dsc//did/container">
                           <axsl:choose>
                              <axsl:when test="@type"/>
                              <axsl:otherwise>
                                 <tr>
                                    <td>c/c0x did/container
				 </td>
                                    <td>type=
					 </td>
                                    <td>MA
				 </td>
                                    <td> Missing @type<axsl:call-template name="getcontext"/>
                                       <div class="appnotes" id="app.d0e3176">
                                          <h4>Comments/Application Notes for c/c0x did/container</h4>
                                          <p>
                                             <appnotes>Use of the TYPE attribute is mandatory if applicable to identify the type of physical container(s) used to house the collection. Use any useful designations, such as: “box” “carton” “folder” “box-folder” “reel” “frame” 
            <br/>

            
                                                <br/>

            “oversize” “reel-frame” “volume” “album” “page” “map-case” “folio” “verticalfile”. Although neither EAD nor the program require the use of certain TYPE terms, repositories are encouraged to prepare controlled in-house lists of container TYPE terms to enhance data consistency. 
            <br/>

            
                                                <br/>

            In determining whether to use one or two &lt;container&gt; elements in a given &lt;c0x&gt; entry, use the following rule of thumb. All data of the same TYPE should be entered in a single &lt;container&gt; element. It is also acceptable to enter two types of container data into a single &lt;container&gt; element. For example, a repository may elect to record “box” and “folder” information in two separate &lt;container&gt; elements, each one containing a different container type: 
            <br/>

            
                                                <br/>

            &lt;container type=”box”&gt;8&lt;/container&gt;
            <br/>

            &lt;container type=”folder”&gt;12-17&lt;/container&gt; 
            <br/>

            
                                                <br/>

            Or both types may be combined in a single &lt;container&gt; element using a combination term such as “volume-page” or “box-folder”: 
            <br/>

            
                                                <br/>

            &lt;container type=”box-folder”&gt;8/12-17&lt;/container&gt; 
            <br/>

            
                                                <br/>

            However, do not use two &lt;container&gt; elements for information of the same TYPE, even to record complex information. Rather, enter the complex information into a single &lt;container&gt; element. In the following example, the material described is contained in box 3, folder 12 through box 4, folder 4. 
            <br/>

            
                                                <br/>

            Acceptable:
            <br/>

            &lt;container type=”box-folder”&gt;3/12-4/4&lt;/container&gt;
            <br/>

            or
            <br/>

            &lt;container type=”box-folder”&gt;3/12-17, 4/1-4&lt;/container&gt;
            <br/>

            or
            <br/>

            &lt;container type=”box-folder”&gt;3/12-17 to 4/1-4&lt;/container&gt;
            <br/>

            but not
            <br/>

            &lt;container type=”box-folder”&gt;3/12-17&lt;/container&gt; &lt;container type=”box-folder”&gt;4/1-4&lt;/container&gt;</appnotes>
                                          </p>
                                       </div>
                                       <br/>
                                       <a class="appnotes-link" onclick="getAppNotes('app.d0e3176')">View Comments/Application Notes</a>

				 </td>
                                    <td>
				 </td>
                                 </tr>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>c/c0x did/container
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td> The repeatable element &lt;c/c0x did/container
&gt; not been used in this document.
							

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//did/origination">
                        <axsl:for-each select="ead/archdesc/dsc//did/origination">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='100'  or @encodinganalog='110'  or @encodinganalog='111' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>c/c0x did/origination
				 </td>
                                             <td>encodinganalog=
									 </td>
                                             <td>Rec
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3249">
                                                   <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                                   <p>
                                                      <appnotes>Use "100" for personal or family names (&lt;persname&gt; or &lt;famname&gt;), "110" for corporate names (&lt;corpname&gt;), and "111" for meeting names (&lt;corpname&gt;). Dublin Core: “creator”</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3249')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '100'  or  '110'  or  '111' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>c/c0x did/origination
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3249">
                                             <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                             <p>
                                                <appnotes>Use "100" for personal or family names (&lt;persname&gt; or &lt;famname&gt;), "110" for corporate names (&lt;corpname&gt;), and "111" for meeting names (&lt;corpname&gt;). Dublin Core: “creator”</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3249')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '100'  or  '110'  or  '111' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@source"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>c/c0x did/origination
				 </td>
                                       <td>source=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @source<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3267">
                                             <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                             <p>
                                                <appnotes>Set to “lcnaf” when the name is established in the LC Name Authority File. If the name is not found in LCNAF, formulate it according to RDA/AACR2 rules for name headings, and use the RULES attribute to state the rules followed. Note that at the &lt;c0x&gt; level, using LCNAF or RDA/AACR2 is recommended but not required.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3267')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@rules"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>c/c0x did/origination
				 </td>
                                       <td>rules=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @rules<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3275">
                                             <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                             <p>
                                                <appnotes>Set to “rda” or “aacr2" when the name is not established in LCNAF but formulated according RDA and/or AACR2 rules for name headings. Note that at the &lt;c0x&gt; level, using LCNAF or RDA/AACR2 is recommended but not required.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3275')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@role"/>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>c/c0x did/origination
				 </td>
                                       <td>role=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @role<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3283">
                                             <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                             <p>
                                                <appnotes>Usually “creator” or “collector ” or “photographer”. Select the role term from the relator term section of the MARC Code List for Relators, Sources, Description Conventions.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3283')">View Comments/Application Notes</a>

				 </td>
                                       <td> 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="persname|corpname|famname|name"><!--Remain silent No error--></axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>c/c0x did/origination
				 </td>
                                       <td>
&lt;persname&gt;
 or 
&lt;corpname&gt;
 or 
&lt;famname&gt;
 or 
&lt;name&gt;
 </td>
                                       <td>Rec
				 </td>
                                       <td>At least one child element should be supplied. 

<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3231">
                                             <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                             <p>
                                                <appnotes>Use one or more appropriate &lt;...name&gt; tags based on the type of origination name, entering one name per tag.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3231')">View Comments/Application Notes</a>

				 </td>
                                       <td>
&lt;persname&gt;
 or 
&lt;corpname&gt;
 or 
&lt;famname&gt;
 or 
&lt;name&gt;
 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>c/c0x did/origination
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; c/c0x did/origination
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3229">
                                 <h4>Comments/Application Notes for c/c0x did/origination</h4>
                                 <p>
                                    <appnotes>Mandatory if creator at level being described is different than defined at the &lt;archdesc&gt; or in a parent level. 
         <br/>

         
                                       <br/>

         Note that in component-level entries only, the decision to state the name in lastname, firstname order, as required in an authorized LC Name Authority File (LCNAF) name heading or a heading formulated according to AACR2 (Mansfield, Mike, 1903), or in firstname lastname order (Mike Mansfield) is based on institutional preference.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3229')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//did/unittitle">
                        <axsl:for-each select="ead/archdesc/dsc//did/unittitle">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='245$a'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unittitle
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3301">
                                                   <h4>Comments/Application Notes for component unittitle</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “title”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3301')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '245$a' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unittitle
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3301">
                                             <h4>Comments/Application Notes for component unittitle</h4>
                                             <p>
                                                <appnotes>Dublin Core: “title”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3301')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '245$a' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component unittitle
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; component unittitle
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3299">
                                    <h4>Comments/Application Notes for component unittitle</h4>
                                    <p>
                                       <appnotes>It is strongly recommended that titles be used at the component level. If a title is not provided because it has already been stated in a previous entry (and is meant to be “inherited” by succeeding entries), but dates are provided, a &lt;unittitle&gt; element is not required; rather, it is acceptable to place the date(s) inside &lt;unitdate&gt;. E.g., for a series entitle “Correspondence,” subseries titles are not required if “Correspondence” is assumed to apply to all entries in the series. Dates or date spans would be encoded in &lt;unitdate&gt; at the subseries level. 
         <br/>

         
                                          <br/>

         Do not nest &lt;unitdate&gt; inside &lt;unittitle&gt;.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3299')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="//dsc//unitdate">
                        <axsl:for-each select="//dsc//unitdate">
                           <axsl:choose>
                              <axsl:when test="@type">
                                 <axsl:choose>
                                    <axsl:when test="@type='inclusive'  or @type='bulk' "/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitdate
				 </td>
                                             <td>type=
									 </td>
                                             <td>Opt
				 </td>
                                             <td>The current value is not correct. 
<axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'inclusive'  or 'bulk'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitdate
				 </td>
                                       <td>type=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @type<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'inclusive'  or 'bulk'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@era">
                                 <axsl:choose>
                                    <axsl:when test="@era='ce'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitdate
				 </td>
                                             <td>era
= </td>
                                             <td>Opt
				 </td>
                                             <td>@era is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'ce'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitdate
				 </td>
                                       <td>era=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @era<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'ce'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@calendar">
                                 <axsl:choose>
                                    <axsl:when test="@calendar='gregorian'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitdate
				 </td>
                                             <td>calendar
= </td>
                                             <td>Opt
				 </td>
                                             <td>@calendar is not set correctly <axsl:call-template name="getcontext"/>

				 </td>
                                             <td>'gregorian'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitdate
				 </td>
                                       <td>calendar=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @calendar<axsl:call-template name="getcontext"/>

				 </td>
                                       <td>'gregorian'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@normal">
                                 <axsl:choose>
                                    <axsl:when test="@normal[(number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-after(substring-after(., '-'), '-')) &lt; 31) &#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '-')) &lt; 13 and number(substring-before(substring-after(substring-after(., '-'), '-'), '/')) &lt; 31 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000 and number(substring-before(substring-after(substring-after(., '/'), '-'), '-')) &lt; 13 and number(substring-after(substring-after(substring-after(., '/'), '-'), '-')) &lt; 31)&#xA;or (number(substring-before(., '-')) &lt; 3000 and number(substring-after(., '-')) &lt; 13)  or ( number(substring-before(., '-')) &lt; 3000 and number(substring-before(substring-after(., '-'), '/')) &lt; 13 and number(substring-before(substring-after(., '/'), '-')) &lt; 3000) or  (number() &lt; 3000) or ( number(substring-before(., '/')) &lt; 3000 and number(substring-after(., '/')) &lt; 3000)]"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitdate
				 </td>
                                             <td>normal= </td>
                                             <td>Opt
				 </td>
                                             <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3353">
                                                   <h4>Comments/Application Notes for component unitdate</h4>
                                                   <p>
                                                      <appnotes>The program considers this attribute a recommended feature at the series or subgroup level because it aids in searching by date, but an optional feature at the folder or item level. If used, enter the date or date range in the W3C profile of the ISO 8601 standard. For details and examples, see the Dates section.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3353')">View Comments/Application Notes</a>

				 </td>
                                             <td>Use  "iso8601" to format the attribute value. 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitdate
				 </td>
                                       <td>normal=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @normal<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3353">
                                             <h4>Comments/Application Notes for component unitdate</h4>
                                             <p>
                                                <appnotes>The program considers this attribute a recommended feature at the series or subgroup level because it aids in searching by date, but an optional feature at the folder or item level. If used, enter the date or date range in the W3C profile of the ISO 8601 standard. For details and examples, see the Dates section.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3353')">View Comments/Application Notes</a>

				 </td>
                                       <td> Use "iso8601" to format attribute value. 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='245$f'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component unitdate
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Rec
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3362">
                                                   <h4>Comments/Application Notes for component unitdate</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “coverage” (temporal).</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3362')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '245$f' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component unitdate
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Rec
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3362">
                                             <h4>Comments/Application Notes for component unitdate</h4>
                                             <p>
                                                <appnotes>Dublin Core: “coverage” (temporal).</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3362')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '245$f' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component unitdate
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;component unitdate
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e3321">
                                    <h4>Comments/Application Notes for component unitdate</h4>
                                    <p>
                                       <appnotes>Strongly recommended if a more specific creation date can be provided for a component than given in its parent description. Such entries provide a fuller description of a unit for researchers and improve searching by date. If multiple date ranges are present, each should be encoded with its own &lt;unitdate&gt;. If no date is available or applicable for a particular component, use the term “undated” inside the &lt;unitdate&gt; tags. 
         <br/>

         
                                          <br/>

         Where no &lt;unittitle&gt; content exists (or if a &lt;unittitle&gt; is meant to be “inherited” by succeeding entries), but dates are provided, do not include a &lt;unittitle&gt; element; instead, simply place the date(s) inside &lt;unitdate&gt;. 
         <br/>

         
                                          <br/>

         To insure compliance with ISAD(G), do not nest &lt;unitdate&gt; inside &lt;unittitle&gt;.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3321')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdescdsc/did//physdesc">
                        <axsl:for-each select="ead/archdescdsc/did//physdesc"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component physdesc
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;component physdesc
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e3386">
                                    <h4>Comments/Application Notes for component physdesc</h4>
                                    <p>
                                       <appnotes>A wrapper element for physical details about the described materials. Use subelements &lt;extent&gt;, and if desired, &lt;physfacet&gt;, &lt;dimensions&gt;, and &lt;genreform&gt; to record the information. 
         <br/>

         
                                          <br/>

         If desired, use separate &lt;physdesc&gt; element sets to accommodate physical description information for different formats included in the collection (e.g., one &lt;physdesc&gt; for number of cubic feet of papers, another &lt;physdesc&gt; for number of photographic prints).</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3386')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdescdsc/did//physdesc/extent">
                        <axsl:for-each select="ead/archdescdsc/did//physdesc/extent">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='300$a'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component physdesc/extent
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Opt
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3398">
                                                   <h4>Comments/Application Notes for component physdesc/extent</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “format”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3398')">View Comments/Application Notes</a>

				 </td>
                                             <td> For MARC21: '300$a' . 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component physdesc/extent
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3398">
                                             <h4>Comments/Application Notes for component physdesc/extent</h4>
                                             <p>
                                                <appnotes>Dublin Core: “format”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3398')">View Comments/Application Notes</a>

				 </td>
                                       <td> For MARC21: '300$a' . 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component physdesc/extent
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;component physdesc/extent
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e3396">
                                    <h4>Comments/Application Notes for component physdesc/extent</h4>
                                    <p>
                                       <appnotes>At the series or subgroup component level, extent should be encoded here rather than in &lt;unittitle&gt; or another element. Units of measure should be expressed as part of the content of this element.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3396')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//did/langmaterial">
                        <axsl:for-each select="ead/archdesc/dsc//did/langmaterial"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component langmaterial
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; component langmaterial
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3414">
                                    <h4>Comments/Application Notes for component langmaterial</h4>
                                    <p>
                                       <appnotes>A prose statement naming the language(s) of the materials in the collection or unit. The language name itself is enclosed in nested &lt;language&gt; tags.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3414')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//did/langmaterial/language">
                        <axsl:for-each select="ead/archdesc/dsc//did/langmaterial/language">
                           <axsl:choose>
                              <axsl:when test="@langcode">
                                 <axsl:choose>
                                    <axsl:when test="@langcode[string-length()='3']"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>component langmaterial/language
				 </td>
                                             <td>langcode= </td>
                                             <td>Opt
				 </td>
                                             <td>This attribute is not formated correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3422">
                                                   <h4>Comments/Application Notes for component langmaterial/language</h4>
                                                   <p>
                                                      <appnotes>Consult ISO 639-2b for the correct language code(s).</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3422')">View Comments/Application Notes</a>

				 </td>
                                             <td>Use  "iso639-2b" to format the attribute value. 
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>component langmaterial/language
				 </td>
                                       <td>langcode=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @langcode<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3422">
                                             <h4>Comments/Application Notes for component langmaterial/language</h4>
                                             <p>
                                                <appnotes>Consult ISO 639-2b for the correct language code(s).</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3422')">View Comments/Application Notes</a>

				 </td>
                                       <td> Use "iso639-2b" to format attribute value. 
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>component langmaterial/language
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td> The repeatable element &lt;component langmaterial/language
&gt; not been used in this document.
							<div class="appnotes" id="app.d0e3420">
                                    <h4>Comments/Application Notes for component langmaterial/language</h4>
                                    <p>
                                       <appnotes>Subelement of &lt;langmaterial&gt; within which the language of the materials being described is specified. &lt;langmaterial&gt;Correspondence in &lt;language langcode=”fre”&gt;French&lt;/language&gt; and &lt;language langcode=”ger”&gt;German&lt;/language&gt;.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3420')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//bioghist">
                        <axsl:for-each select="ead/archdesc/dsc//bioghist"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/dsc//bioghist
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc/dsc//bioghist
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3435">
                                    <h4>Comments/Application Notes for ead/archdesc/dsc//bioghist</h4>
                                    <p>
                                       <appnotes>At highest component levels, such as subgroup or series levels, biographical or administrative history information should be included if available and if the information is different from the collection-level &lt;bioghist&gt; note. Other levels (folder or item) may include &lt;bioghist&gt; if appropriate.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3435')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//scopecontent">
                        <axsl:for-each select="ead/archdesc/dsc//scopecontent">
                           <axsl:choose>
                              <axsl:when test="@encodinganalog">
                                 <axsl:choose>
                                    <axsl:when test="@encodinganalog='520'"/>
                                    <axsl:otherwise>
                                       <axsl:if test="$all='yes'">
                                          <tr>
                                             <td>ead/archdesc/dsc//scopecontent
				 </td>
                                             <td>encodinganalog
= </td>
                                             <td>Opt
				 </td>
                                             <td>@encodinganalog is not set correctly <axsl:call-template name="getcontext"/>
                                                <div class="appnotes" id="app.d0e3443">
                                                   <h4>Comments/Application Notes for ead/archdesc/dsc//scopecontent</h4>
                                                   <p>
                                                      <appnotes>Dublin Core: “description”.</appnotes>
                                                   </p>
                                                </div>
                                                <br/>
                                                <a class="appnotes-link" onclick="getAppNotes('app.d0e3443')">View Comments/Application Notes</a>

				 </td>
                                             <td>'520'  
				</td>
                                          </tr>
                                       </axsl:if>
                                    </axsl:otherwise>
                                 </axsl:choose>
                              </axsl:when>
                              <axsl:otherwise>
                                 <axsl:if test="$all='yes'">
                                    <tr>
                                       <td>ead/archdesc/dsc//scopecontent
				 </td>
                                       <td>encodinganalog=
					 </td>
                                       <td>Opt
				 </td>
                                       <td> Missing @encodinganalog<axsl:call-template name="getcontext"/>
                                          <div class="appnotes" id="app.d0e3443">
                                             <h4>Comments/Application Notes for ead/archdesc/dsc//scopecontent</h4>
                                             <p>
                                                <appnotes>Dublin Core: “description”.</appnotes>
                                             </p>
                                          </div>
                                          <br/>
                                          <a class="appnotes-link" onclick="getAppNotes('app.d0e3443')">View Comments/Application Notes</a>

				 </td>
                                       <td>'520'  
				</td>
                                    </tr>
                                 </axsl:if>
                              </axsl:otherwise>
                           </axsl:choose>
                        </axsl:for-each>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/dsc//scopecontent
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc/dsc//scopecontent
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3441">
                                    <h4>Comments/Application Notes for ead/archdesc/dsc//scopecontent</h4>
                                    <p>
                                       <appnotes>At highest component levels, such as subgroup or series levels, scope and content information should be included. Other levels (folder or item) may include scope and content notes as needed. Use &lt;scopecontent&gt; over &lt;abstract&gt; or &lt;note&gt; tags. Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3441')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//accessrestrict">
                        <axsl:for-each select="ead/archdesc/dsc//accessrestrict"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/dsc//accessrestrict
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc/dsc//accessrestrict
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3459">
                                 <h4>Comments/Application Notes for ead/archdesc/dsc//accessrestrict</h4>
                                 <p>
                                    <appnotes>Provides researcher with information about conditions governing access. Enter information here only if it differs from what is stated at the collection level. 
         <br/>

         
                                       <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3459')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//userestrict">
                        <axsl:for-each select="ead/archdesc/dsc//userestrict"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/dsc//userestrict
				 </td>
                              <td> </td>
                              <td>Rec
				 </td>
                              <td>The element &lt; ead/archdesc/dsc//userestrict
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3469">
                                    <h4>Comments/Application Notes for ead/archdesc/dsc//userestrict</h4>
                                    <p>
                                       <appnotes>Provides information about copyright status or other conditions that affect the use of a collection after access has been provided. In addition to copyright status, this may include limitations or special considerations imposed by the repository, donor, legal statute, or other agency regarding reproduction, publication, or quotation of the described materials. 
         <br/>

         
                                          <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3469')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//accessrestrict">
                        <axsl:for-each select="ead/archdesc/dsc//accessrestrict"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <tr>
                           <td>ead/archdesc/dsc//accessrestrict
				 </td>
                           <td> </td>
                           <td>MA
				 </td>
                           <td>The element &lt; ead/archdesc/dsc//accessrestrict
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3479">
                                 <h4>Comments/Application Notes for ead/archdesc/dsc//accessrestrict</h4>
                                 <p>
                                    <appnotes>Provides researcher with information about conditions governing access. If materials have no restrictions on access, repositories are encouraged to make the following statement: “Collection is open to the public.” 
         <br/>

         
                                       <br/>

         Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                 </p>
                              </div>
                              <br/>
                              <a class="appnotes-link" onclick="getAppNotes('app.d0e3479')">View Comments/Application Notes</a>

				 </td>
                           <td>
				 </td>
                        </tr>
                     </axsl:otherwise>
                  </axsl:choose>
                  <axsl:choose>
                     <axsl:when test="ead/archdesc/dsc//note">
                        <axsl:for-each select="ead/archdesc/dsc//note"/>
                     </axsl:when>
                     <axsl:otherwise>
                        <axsl:if test="$all='yes'">
                           <tr>
                              <td>ead/archdesc/dsc//note
				 </td>
                              <td> </td>
                              <td>Opt
				 </td>
                              <td>The element &lt; ead/archdesc/dsc//note
&gt; does not appear in this document.<div class="appnotes" id="app.d0e3489">
                                    <h4>Comments/Application Notes for ead/archdesc/dsc//note</h4>
                                    <p>
                                       <appnotes>A generic note element that provides a short comment, such as citing the source of a quotation or justifying an assertion. Do note confuse with &lt;odd&gt;, which may be used within &lt;archdesc&gt; or&lt;c&gt; for information that is more than a short comment. Text should be enclosed in paragraph &lt;p&gt; tags; &lt;p&gt; is repeatable.</appnotes>
                                    </p>
                                 </div>
                                 <br/>
                                 <a class="appnotes-link" onclick="getAppNotes('app.d0e3489')">View Comments/Application Notes</a>

				 </td>
                              <td> 
				</td>
                           </tr>
                        </axsl:if>
                     </axsl:otherwise>
                  </axsl:choose>
               </tbody>
            </table>

            <div>
               <axsl:attribute name="id">source</axsl:attribute>
               <axsl:apply-templates mode="verb" select="."/>
            </div>
   </axsl:template>
   <axsl:template name="getcontext">
      <axsl:choose>
         <axsl:when test="name(..) ='ead'">
            <br/>
            <a>
               <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id()"/>')</axsl:attribute>
               <axsl:attribute name="class">context-link</axsl:attribute>
               View Context</a>
         </axsl:when>
         <axsl:when test="name()= 'did'">
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(..)"/>')</axsl:attribute>
              <axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:when>
         <axsl:when test="name(..)= 'did'">
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(../..)"/>')</axsl:attribute>
              <axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:when>
         <axsl:when test="name(../..) ='did'">
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(../../..)"/>')</axsl:attribute><axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:when>
         <axsl:when test="name(..) ='eadheader'">
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(..)"/>')</axsl:attribute>
              <axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:when>
         <axsl:when test="name(../..) ='archdesc' and name(..)='did'">
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(..)"/>')</axsl:attribute>
              <axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:when>
         <axsl:otherwise>
            <br/>
            <a>
              <axsl:attribute name="onclick">writeSource('<axsl:value-of select="generate-id(..)"/>')</axsl:attribute>
              <axsl:attribute name="class">context-link</axsl:attribute>
              View Context
            </a>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
</axsl:stylesheet>