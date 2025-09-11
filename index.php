<?php
// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');
?>

<title>Home - <?php echo SITE_TITLE; ?></title>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/home.css" />
<script src="<?php echo AW_DOMAIN; ?>/scripts/home.js"></script>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1 class="visuallyhidden">Archives West: Home</h1>

<div id="homesearchtop" role="search">
  <div id="spacer"></div>
  <?php include(AW_INCLUDES . '/search-form.php'); ?>
</div>

<div id="homecontent" class="container-fluid" role="main">
  <div id="home-about">
    <p>Archives West provides access to descriptions of primary sources in the western United States, including correspondence, diaries or photographs. Digital reproductions of the materials are available in some cases.</p>
  </div>
  <div class="row" id="searchby">
    <!-- search by place -->
    <div class="homesearchcategory" id="placesearch">
      <h2>By Repository</h2>
      <div id="searchbyinstitution">
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/idaho-49px.png" alt="Idaho" aria-hidden="true" width="49" height="49">
            </span>
          <span class="topicSearch">
            <button id="btn_Idaho" aria-controls="Idaho" aria-expanded="false">Idaho</button>
            <ul id="Idaho" class="searchterms" aria-labelledby="btn_Idaho" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=idbb">Boise State University Library, Special Collections and Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=idu">University of Idaho Library, Special Collections and Archives</a></li>
            </ul>
          </span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/montana-49px.png" alt="Montana" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button id="btn_Montana" aria-controls="Montana" aria-expanded="false">Montana</button>
            <ul id="Montana" class="searchterms" aria-labelledby="btn_Montana" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=mthi">Montana Historical Society, Research Center Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=mtbc">Montana State University Library, Merrill G. Burlingame Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=mtu">University of Montana, Mansfield Library, Archives and Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=mtul">University of Montana, William J. Jameson Law Library</a></li>
            </ul>
          </span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/oregon-49px.png" alt="Oregon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
          <button id="btn_Oregon" aria-controls="Oregon" aria-expanded="false">Oregon</button>
            <ul id="Oregon" class="searchterms" aria-labelledby="btn_Oregon" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orbec">Central Oregon Community College</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orngf">George Fox University Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orel">Lane Community College Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orpl">Lewis &amp; Clark College, Special Collections and Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orphs">Oregon Health &amp; Science University, Historical Collections &amp; Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orhi">Oregon Historical Society Research Library</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orkt">Oregon Institute of Technology Libraries, Shaw Historical Library</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orkfoit">Oregon Institute of Technology, University Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orcs">Oregon State University Libraries, Special Collections and Archives Research Center</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orfp">Pacific University, Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orashs">Southern Oregon University, Hannon Library</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=oru">University of Oregon Libraries, Special Collections and University Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=ormonw">Western Oregon University Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=orsaw">Willamette University Archives and Special Collections</a></li>
            </ul>
          </span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/utah-49px.png" alt="Utah" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
          <button id="btn_Utah" aria-controls="Utah" aria-expanded="false">Utah</button>
            <ul id="Utah" class="searchterms" aria-labelledby="btn_Utah" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=US-uuml">University of Utah Libraries, Special Collections.</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=US-utslumla">University of Utah Libraries, University Archives and Records Management</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=US-ula">Utah State University, Merrill-Cazier Library, Special Collections and Archives Division</a></li>
            </ul>
          </span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/washington-49px.png" alt="Washington" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
          <button id="btn_Washington" aria-controls="Washington" aria-expanded="false">Washington</button>
            <ul id="Washington" class="searchterms" aria-labelledby="btn_Washington" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waelc">Central Washington University, Archives and Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wachene">Eastern Washington University</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wae">Everett Public Library, Northwest Room</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wasmhi">Museum of History &amp; Industry, Sophie Frye Bass Library</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wasmar">Seattle Municipal Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waspc">Seattle Pacific University</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=was">Seattle Public Library, Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wasu">Seattle University, Lemieux Library and McGoldrick Learning Commons, Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wasp">Spokane Public Library, Inland Northwest Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wat">Tacoma Public Library Northwest Room, Special Collections &amp; Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waoe">The Evergreen State College, Malcolm Stilson Archives and Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=watu">University of Puget Sound, Archives &amp; Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wauem">University of Washington Ethnomusicology Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waseumn">University of Washington Libraries, Government Publications, Maps, and Microforms and Newspapers</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waseumc">University of Washington Libraries, Media Archive</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wauar">University of Washington Libraries, Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waboubl">University of Washington Libraries, UW Bothell</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waps">Washington State University Libraries, Manuscripts, Archives, and Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wabecp">Western Washington University, Center for Pacific Northwest Studies</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wabewwus">Western Washington University, Special Collections</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wabewwua">Western Washington University, University Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waww">Whitman College and Northwest Archives</a></li>
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=waspw">Whitworth University Archives and Special Collections</a></li>
            </ul>
          </span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="<?php echo AW_DOMAIN; ?>/layout/images/states/wyoming-49px.png" alt="Wyoming" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
          <button id="btn_Wyoming" aria-controls="Wyoming" aria-expanded="false">Wyoming</button>
            <ul id="Wyoming" class="searchterms" aria-labelledby="btn_Wyoming" style="display: none;">
              <li><a href="<?php echo AW_DOMAIN; ?>/search.php?r=wyuah">University of Wyoming, American Heritage Center</a></li>
            </ul>
          </span>
        </div>
      </div>
    </div>

    <!-- search by place -->
    <div class="homesearchcategory" id="topicsearch">
      <h2>By Subject</h2>
      <div id="searchbytopic">
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-1.png" alt="Agriculture and Natural Resources icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Agriculture_and_Natural_Resources" aria-controls="Agriculture_and_Natural_Resources" aria-expanded="false">Agriculture and Natural Resources</button>
          <ul class="searchterms" id="Agriculture_and_Natural_Resources" aria-labelledby="btn_Agriculture_and_Natural_Resources" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Agriculture">Agriculture</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Fisheries%20and%20Wildlife">Fisheries and Wildlife</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Logging">Logging</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Mines%20and%20Mineral%20Resources">Mines and Mineral Resources</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Ranching">Ranching</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Water%20and%20Water%20Rights">Water and Water Rights</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-2.png" alt="Arts, Humanities, and Social Sciences icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Arts_Humanities_and_Social_Sciences" aria-controls="Arts_Humanities_and_Social_Sciences" aria-expanded="false">Arts, Humanities, and Social Sciences</button>
          <ul class="searchterms" id="Arts_Humanities_and_Social_Sciences" aria-labelledby="btn_Arts_Humanities_and_Social_Sciences" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Anthropology">Anthropology</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Archaeology">Archaeology</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Architecture">Architecture</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Fine%20Arts">Fine Arts</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Journalism">Journalism</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Language%20and%20Languages">Language and Languages</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Literature">Literature</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Music">Music</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Performing%20Arts">Performing Arts</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-3.png" alt="Business, Industry, Labor, and Commerce icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Business_Industry_Labor_and_Commerce" aria-controls="Business_Industry_Labor_and_Commerce" aria-expanded="false">Business, Industry, Labor, and Commerce</button>
          <ul class="searchterms" id="Business_Industry_Labor_and_Commerce" aria-labelledby="btn_Business_Industry_Labor_and_Commerce" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Advertising%20and%20Marketing">Advertising and Marketing</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Businesses%20and%20Corporations">Businesses and Corporations</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Economics%20and%20Banking">Economics and Banking</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Fishing%20and%20Canning">Fishing and Canning</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Forestry%20and%20Forestry%20Products">Forestry and Forestry Products</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Labor%20History">Labor History</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Labor%20Unions">Labor Unions</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Publishers%20and%20Publishing">Publishers and Publishing</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Railroads">Railroads</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Retail%20Trade">Retail Trade</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Ships%20and%20Shipping">Ships and Shipping</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Transportation">Transportation</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-4.png" alt="Education icon" role="presentation" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Education" aria-controls="Education" aria-expanded="false">Education</button>
          <ul class="searchterms" id="Education" aria-labelledby="btn_Education" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Colleges%20and%20Universities">Colleges and Universities</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Elementary%20and%20Secondary%20Education">Elementary and Secondary Education</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Student%20Life">Student Life</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-5.png" alt="Environment and Conservation icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Environment_and_Conservation" aria-controls="Environment_and_Conservation" aria-expanded="false">Environment and Conservation</button>
          <ul class="searchterms" id="Environment_and_Conservation" aria-labelledby="btn_Environment_and_Conservation" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Environmental%20Activism">Environmental Activism</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Environmental%20Conditions">Environmental Conditions</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Land%20Use">Land Use</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:National%20Parks">National Parks</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Pollution">Pollution</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-6.png" alt="Immigration and American Expansion icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Immigration_and_American_Expansion" aria-controls="Immigration_and_American_Expansion" aria-expanded="false">Immigration and American Expansion</button>
          <ul class="searchterms" id="Immigration_and_American_Expansion" aria-labelledby="btn_Immigration_and_American_Expansion" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Expeditions%20and%20Adventure">Expeditions and Adventure</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Missionaries">Missionaries</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Overland%20Journeys%20to%20the%20Western%20United%20States">Overland Journeys to the Western United States</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Overland%20Journeys%20to%20the%20Northwestern%20United%20States">Overland Journeys to the Northwestern United States</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Pioneers">Pioneers</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-11.png" alt="Places icon" role="presentation" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Places" aria-controls="Places" aria-expanded="false">Places</button>
          <ul class="searchterms" id="Places" aria-labelledby="btn_Places" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Alaska">Alaska</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:British%20Columbia">British Columbia</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:California">California</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Idaho">Idaho</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Montana">Montana</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Oregon">Oregon</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Utah">Utah</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Washington%20(State)">Washington (State)</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Wyoming">Wyoming</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Anchorage">Anchorage</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Fairbanks">Fairbanks</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Juneau">Juneau</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Boise">Boise</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Coeur%20d'Alene">Coeur d'Alene</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Moscow">Moscow</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Pocatello">Pocatello</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Billings">Billings</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Bitterroot%20Valley">Bitterroot Valley</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Bozeman">Bozeman</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Helena">Helena</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Missoula">Missoula</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Missoula%20Valley">Missoula Valley</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Astoria">Astoria</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Bend">Bend</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Corvallis">Corvallis</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Eugene">Eugene</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Portland">Portland</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Salem">Salem</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Cache%20Valley">Cache Valley</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Cedar%20City">Cedar City</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Logan">Logan</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Moab">Moab</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Ogden">Ogden</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Orem">Orem</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Provo">Provo</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Saint%20George">Saint George</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Salt%20Lake%20City">Salt Lake City</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Bellingham">Bellingham</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Olympia">Olympia</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Seattle">Seattle</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Spokane">Spokane</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Tacoma">Tacoma</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Vancouver%20(Wash.)">Vancouver (Wash.)</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-7.png" alt="People, Ethnicity, and Culture icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_People_Ethnicity_and_Culture" aria-controls="People_Ethnicity_and_Culture" aria-expanded="false">People, Ethnicity, and Culture</button>
          <ul class="searchterms" id="People_Ethnicity_and_Culture" aria-labelledby="btn_People_Ethnicity_and_Culture" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:African%20Americans">African Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Children%20and%20Youth">Children and Youth</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Chinese%20Americans">Chinese Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Gays%20and%20Lesbians">Gays and Lesbians</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:German%20Americans">German Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Italian%20Americans">Italian Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Japanese%20Americans">Japanese Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Jewish%20Americans">Jewish Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Latinos%20and%20Latinas">Latinos and Latinas</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Mexican%20Americans">Mexican Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Multiculturalism">Multiculturalism</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Native%20Americans">Native Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Russian%20Americans">Russian Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Scandinavian%20Americans">Scandinavian Americans</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Women">Women</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-8.png" alt="Politics, Government, and Law icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Politics_Government_and_Law" aria-controls="Politics_Government_and_Law" aria-expanded="false">Politics, Government, and Law</button>
          <ul class="searchterms" id="Politics_Government_and_Law" aria-labelledby="btn_Politics_Government_and_Law" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:City%20Planning">City Planning</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Civic%20Activism">Civic Activism</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Civil%20Procedure%20and%20Courts">Civil Procedure and Courts</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Civil%20Rights">Civil Rights</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:International%20Relations">International Relations</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Laws%20and%20Legislation">Laws and Legislation</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Military">Military</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Political%20Campaigns">Political Campaigns</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Politics%20and%20Politicians">Politics and Politicians</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Public%20Finance">Public Finance</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Public%20Utilities">Public Utilities</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Public%20Works">Public Works</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Territorial%20Government">Territorial Government</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-9.png" alt="Science, Technology and Health icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Science_Technology_and_Health" aria-controls="Science_Technology_and_Health" aria-expanded="false">Science, Technology and Health</button>
          <ul class="searchterms" id="Science_Technology_and_Health" aria-labelledby="btn_Science_Technology_and_Health" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Disease">Disease</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Energy%20Production">Energy Production</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Medicine%20and%20Health">Medicine and Health</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Mental%20Health">Mental Health</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Nuclear%20Weapons%20and%20Testing">Nuclear Weapons and Testing</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Science">Science</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Technology">Technology</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-10.png" alt="Social Life and Customs icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Social_Life_and_Customs" aria-controls="Social_Life_and_Customs" aria-expanded="false">Social Life and Customs</button>
          <ul class="searchterms" id="Social_Life_and_Customs" aria-labelledby="btn_Social_Life_and_Customs" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:City%20and%20Town%20Life">City and Town Life</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Clubs%20and%20Societies">Clubs and Societies</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Fashion">Fashion</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Folklore%20and%20Folklife">Folklore and Folklife</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Foods%20and%20Nutrition">Foods and Nutrition</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Home%20and%20Family">Home and Family</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Media%20and%20Communication">Media and Communication</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Mormonism%20(Church%20of%20Jesus%20Christ%20of%20Latter-day%20Saints)">Mormonism (Church of Jesus Christ of Latter-day Saints)</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Parks%20and%20Playgrounds">Parks and Playgrounds</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Religion">Religion</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Sexuality">Sexuality</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Social%20Classes">Social Classes</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Sports%20and%20Recreation">Sports and Recreation</a></li></ul></span>
        </div>
        <div class="topic">
          <span class="topicIcon">
            <img src="layout/images/search/icon-search-12.png" alt="Material Type icon" aria-hidden="true" width="49" height="49">
          </span>
          <span class="topicSearch">
            <button role="button" id="btn_Material_Type" aria-controls="Material_Type" aria-expanded="false">Material Type</button>
          <ul class="searchterms" id="Material_Type" aria-labelledby="btn_Material_Type" style="display: none;"><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Architectural%20Drawings">Architectural Drawings</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Artifacts">Artifacts</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Diaries">Diaries</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Electronic%20Records">Electronic Records</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Maps">Maps</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Moving%20Images">Moving Images</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Oral%20Histories">Oral Histories</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Photographs">Photographs</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Scrapbooks">Scrapbooks</a></li><li><a class="sub-topic" href="<?php echo AW_DOMAIN; ?>/search.php?facet=subject:Sound%20Recordings">Sound Recordings</a></li></ul></span>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="rss">
  <h2>What's New?</h2>
  <div id="rss-content">Loading...</div>
</div>

<?php include(AW_INCLUDES . '/footer.php'); ?>
