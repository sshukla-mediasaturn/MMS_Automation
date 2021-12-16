<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0"  >
<!--
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at
 
       http://www.apache.org/licenses/LICENSE-2.0
 
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->
<!-- 
    Stylesheet for processing 2.1 output format test result files 
    To uses this directly in a browser, add the following to the JTL file as line 2:
    <?xml-stylesheet type="text/xsl" href="../extras/jmeter-results-detail-report_21.xsl"?>
    and you can then view the JTL in a browser
-->

 <xsl:output method="html" indent="yes" encoding="US-ASCII" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<!-- Defined parameters (overrideable) -->
   <xsl:param name="showData" select="'n'" />

   <xsl:template match="testResults">
      <html>
         <head>
     <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>ExTest Report Result</title>

    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>

    <!-- Optional Bootstrap theme -->


<a class="logo" href="https://www.publicisgroupe.com/en/services/services-publicis-sapient-en"><img src="ps_logo.png" alt="PublicisSapientReport" style="width:91px;height:91px;"/></a>

        <style type="text/css">
                         }
                        .Failure {
                            font-weight:bold; color:red;
                        }
                        
            
                        img
                        {
                          border-width: 0px;
                        }
                        
                       
                        
                        
                        .page_details
                        {
                           display: none;
                        }
            .errorpage_details
                        {
                           display: none;
                        }
                                        
                        .errorpage_details_expanded
                        {
                            display: block;
                            display/* hide this definition from  IE5/6 */: table-row;
                        }
            .page_details_expanded
                        {
                            display: block;
                            display/* hide this definition from  IE5/6 */: table-row;
                        }


                        .page_details_r_expanded
                        {
                            display: block;
                            display/* hide this definition from  IE5/6 */: table-row;
                        }

                    
        </style>

        <script language="JavaScript">
        <![CDATA[
                  function expand(details_id)
                   {                  
                      document.getElementById(details_id).className = document.getElementById(details_id).className +"_expanded";
                   }
                   
                   function collapse(details_id)
                   {                  
                      document.getElementById(details_id).className = "page_details";
                   }
                   
                   function change(details_id)
                   {
                      if(document.getElementById(details_id+"_image").name.match("expand"))
                      {
                         document.getElementById(details_id+"_image").name = "collapse";
                         var responseCode=document.getElementById(details_id+"_image").innerText;
                         if(!(responseCode.trim() == 'PASS' || responseCode.trim() == 'FAIL'))
                         {document.getElementById(details_id+"_image").innerHTML=" [-] ";}
                        if (includes(details_id,"page_details_r"))
                         {
                         decode(details_id);
                         }
                         expand(details_id);
                      }
                      else
                      {
                         document.getElementById(details_id+"_image").name = "expand";
                         var responseCode=document.getElementById(details_id+"_image").innerText;
                         if(!(responseCode.trim() == 'PASS' || responseCode.trim() == 'FAIL'))
                         {document.getElementById(details_id+"_image").innerHTML="[+]";}
                         collapse(details_id);
                      } 
                    }
                     function decode(details_id)
                    {
                      var QueryID="queryString_"+details_id;
                      var uri_enc = document.getElementById(QueryID);
                      var sHTML = uri_enc.innerHTML.replace(/\+/g, "");
                      sHTML=decodeURIComponent(sHTML);
                      uri_enc.innerText=sHTML;
                     }
                    function includes(container, value) {
                        var returnValue = false;
                        var pos = container.indexOf(value);
                        if (pos >= 0) {
                          returnValue = true;
                        }
                        return returnValue;
                      }
            ]]>

        </script>

        <script language="JavaScript">
                var allHTMLTags = new Array();
                var classObjs = new Array();
                
                function getElementByClass(theClass) {
                var allHTMLTags=document.getElementsByTagName('*');
                    for (var i=0; i &lt; allHTMLTags.length; i++) {                     
                        if (allHTMLTags[i].className==theClass) {
                        classObjs.push(allHTMLTags[i]);
                        }
                    }
                    return classObjs;
                }
               
                function timeStamp(){           
                            var tsTD = getElementByClass('TimeStamp');          
                            for(var i=0;i&lt; tsTD.length;i++){                        
                                var theDateObj = new Date(); //parseFloat(1314603704403)
                                theDateObj.setTime(tsTD[i].innerHTML);
                                tsTD[i].innerHTML= theDateObj;
                            }
                         
                            
                        }
                window.onload=timeStamp;                        
        </script>
		
       </head>

         <body>
            <xsl:call-template name="pageHeader" />

            <xsl:call-template name="Summary" />

            <xsl:call-template name="TestFailSummary" />

            <xsl:call-template name="detailView" />
          <script src="js/jquery-3.1.1.js"></script><script src="js/bootstrap.min.js"></script>

         </body>
      </html>
   </xsl:template>


   <xsl:template name="pageHeader">
   
  
<h3 align="center"><u>OMS Regression Test Results</u></h3>
   
   </xsl:template>


   <xsl:template name="display-percent">
      <xsl:param name="value" />
      <xsl:value-of select="format-number($value,'0.00%')" />
   </xsl:template>


   <xsl:template name="display-time">
      <xsl:param name="value" />
      <xsl:value-of select="format-number($value,'0 ms')" />
   </xsl:template>


   <xsl:template name="Summary">
      <h4 align="center">Summary</h4>

      <table class="table  table-striped table-bordered" >
         <xsl:variable name="allCount" select="count(/testResults/*/@tn[not(. = ../following-sibling::*/@tn)])" />
         <!--<xsl:variable name="allFailureCount" select="count(/testResults/*[@s='false']/@tn[not(. = ../following-sibling::*/@tn)])" />
                  <xsl:when test="../*[@tn= current()/@tn]/@s='false'">
-->
<xsl:variable name="allFailureCount" select="count(/testResults/*[@s='false']/@tn[not(. = ../following-sibling::*[@s='false']/@tn)])" />                  
         <xsl:variable name="allSuccessCount" select="$allCount - $allFailureCount" />
         <xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
         <xsl:variable name="allFailurePercent" select="$allFailureCount div $allCount" />
		 <xsl:variable name="count1" select="count(/testResults/sample[@lb='Constant Timer 1 min'])" />
		 <xsl:variable name="count2" select="count(/testResults/sample[@lb='Constant Timer 2 mins'])" />
		 <xsl:variable name="count3" select="count(/testResults/sample[@lb='Constant Timer 3 mins'])" />
		 <xsl:variable name="count5" select="count(/testResults/sample[@lb='Constant Timer 5 mins'])" />
         <xsl:variable name="allTotalTime" select="sum(/testResults/*/@t) + ($count1 * 60000) + ($count2 * 120000) + ($count3 * 180000) + ($count5 * 300000)" />
         <xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />

         <xsl:variable name="allMinTime">
            <xsl:call-template name="min">
               <xsl:with-param name="nodes" select="/testResults/*/@t" />
            </xsl:call-template>
         </xsl:variable>

         <xsl:variable name="allMaxTime">
            <xsl:call-template name="max">
               <xsl:with-param name="nodes" select="/testResults/*/@t" />
            </xsl:call-template>
         </xsl:variable>
         <thead class="thead-inverse">
          <tr valign="top">
           <th>Test Parameters</th>
            <th>Value</th>
         </tr>
       </thead>
       <tbody>
         <tr valign="top">
            <td>Run Date/Time</td>
            <td class="TimeStamp">
               <xsl:value-of select="/testResults/*/@ts" />
            </td>
         </tr>
         <tr>
            <td>Environment</td>
            <td>https://fom-test-nl.media-saturn.com</td>
         </tr>
         <tr>
            <td>Total TestCases</td>
            <td>
               <xsl:value-of select="$allCount" />
            </td>
         </tr>
         <tr>
            <td>Passed TestCases</td>
            <td>
            <xsl:value-of select="$allSuccessCount" />
            </td>
         </tr>
         <tr>
            <td>Failed TestCases</td>
            <td>
               <xsl:value-of select="$allFailureCount" />
            </td>
         </tr>
         <tr>
            <td>Failure Percentage</td>
            <td>
               <xsl:call-template name="display-percent">
                  <xsl:with-param name="value" select="$allFailurePercent" />
               </xsl:call-template>
            </td>
         </tr>
         <tr>
            <td>Total Run Time</td>
            <td>
               <xsl:call-template name="display-time">
                <xsl:with-param name="value" select="$allTotalTime" />
               </xsl:call-template>
            </td>
         </tr>
    </tbody>
      </table>
   </xsl:template>


   <xsl:template name="TestFailSummary">
      <h4 align="center">Test Fail Summary</h4>

     <table class="table  table-bordered table-striped">
      <thead class="thead-inverse">

         <tr>
            <th>Response Code(Failure)</th>
            <th>Count</th>
            <th>Impacted Testcases(Test Group --> Test Step)</th>
         </tr>
      </thead>
      <tbody>
         <xsl:for-each select="/testResults/*[@s='false'][not(@rc = preceding-sibling::*[@s='false']/@rc)]">        
                <xsl:variable name="rcCount" select="count(../*[@rc = current()/@rc][@s='false'])" />               
                <tr>
                   <td>
          <xsl:choose>
        <xsl:when test="@rc!=''">
                        <xsl:value-of select="@rc"/>
        </xsl:when>
        <xsl:otherwise>Other Failure
        </xsl:otherwise>
         </xsl:choose>
      
      </td>
           <td>
                      <xsl:value-of select="$rcCount" />
          </td>
        <td>
     <table>
          <xsl:for-each select="../*[@s='false'][@rc = current()/@rc]">        
                <xsl:variable name="lb" select="@lb" />
                <xsl:variable name="tn" select="@tn" />    
                  
<tr>
      <td>                 <xsl:value-of select="$tn" />
               -->
                       <xsl:value-of select="$lb" />
          </td>  
 </tr>           
          </xsl:for-each>
</table>
</td>
                </tr>
         </xsl:for-each>
      </tbody>
      </table>
   </xsl:template>

   <xsl:template name="detailView">
            <xsl:variable name="detailedReport" select="document('../prop.xml')//Feature[@id = 'detailedReport']" />

      <h4 align="center">ExTest Test Results Detail View</h4>

      <table class="table  table-bordered table-hover" >
        <thead class="thead-inverse">
          <tr valign="top">
          <th width="20%">Test Group</th>
          <th width="20%"> Test Step</th>
          <th width="8%">Test Step Result</th>
          <th>Total Time</th>
          <th width="5%">Request Data</th>
          <th width="5%">Scenario Result</th>
          <th>Response Message</th>
		  <th>Error Message</th>
          </tr>
        </thead>
      <tbody>


         <xsl:for-each select="/testResults/*[not(@tn = preceding-sibling::*/@tn)]">
			<xsl:variable name="constTime1" select="count(../*[@tn= current()/@tn][@lb='Constant Timer 1 min'])" />
			<xsl:variable name="constTime2" select="count(../*[@tn= current()/@tn][@lb='Constant Timer 2 mins'])" />
			<xsl:variable name="constTime3" select="count(../*[@tn= current()/@tn][@lb='Constant Timer 3 mins'])" />
			<xsl:variable name="constTime5" select="count(../*[@tn= current()/@tn][@lb='Constant Timer 5 mins'])" />
            <xsl:variable name="totalThreadTime" select="sum(../*[@tn= current()/@tn]/@t ) + ($constTime1 * 60000) + ($constTime2 * 120000) + ($constTime3 * 180000) + ($constTime5 * 300000)" />
            <xsl:variable name="position" select="position()" />

            <tr>
               <th scope="row">
                  <xsl:value-of select="@tn" />
               </th>
               <td>    
               
</td>
               <td></td>
               <td><xsl:value-of select="$totalThreadTime" /></td>
               <td></td>
               <td>

                 <xsl:choose>
         <xsl:when test="../*[@tn= current()/@tn]/@s='false'">
           <Strong><u>FAIL </u></Strong>
         </xsl:when>
         <xsl:otherwise>
          <Strong><u>PASS </u></Strong>
         </xsl:otherwise>
       </xsl:choose>

                  </td>
               <td></td>
			   
			  <!-- <td> <xsl:value-of select="responseData" /></td>-->
			   
            </tr>
<xsl:for-each select="../*[@tn = current()/@tn]">
              
               <tr>
                  <td></td>
                  <td>
                     <xsl:value-of select="@lb" />
                  </td>
                  <td>
                    <xsl:if test="@s='true'">
                        
                        <a class="btn btn-success" name="expand" alt="Pass Confirmation">
                      <xsl:attribute name="id">
                        <xsl:text />errorpage_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()" />_image</xsl:attribute>

                    <xsl:attribute name="href">
                        <xsl:text/>javascript:change('errorpage_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()"/>')</xsl:attribute> 

                        PASS
                    </a>
                    </xsl:if>
                    <xsl:if test="@s='false'">
                        
              <a name="expand" class="btn btn-danger" alt="ErrorMessage">
                   <xsl:attribute name="id">
                        <xsl:text />errorpage_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()" />_image</xsl:attribute>

                    <xsl:attribute name="href">
                        <xsl:text/>javascript:change('errorpage_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()"/>')</xsl:attribute> 
                        FAIL 
                    </a>
                    </xsl:if>
                  </td>
                  <td>
					   <xsl:choose>
						 <xsl:when test="@lb='Constant Timer 1 min'">
						   60000
						 </xsl:when>
						 <xsl:when test="@lb='Constant Timer 2 mins'">
						   120000
						 </xsl:when>
						 <xsl:when test="@lb='Constant Timer 3 mins'">
						   180000
						 </xsl:when>
						 <xsl:when test="@lb='Constant Timer 5 mins'">
						   300000
						 </xsl:when>
						 <xsl:otherwise>
						  <xsl:value-of select="@t" />
						 </xsl:otherwise>
					   </xsl:choose>				  
                  </td>
<td >
          <xsl:variable name="queryString" select="queryString" />
                                    
          <xsl:if test="(($queryString!='') and ($detailedReport='True'))">

        
                  <a class="btn btn-primary" name="expand" alt="INPUT">
                   <xsl:attribute name="id">
                        <xsl:text />page_details_r<xsl:value-of select="$position" />_<xsl:value-of select="position()" />_image</xsl:attribute>

                    <xsl:attribute name="href">
                        <xsl:text/>javascript:change('page_details_r<xsl:value-of select="$position" />_<xsl:value-of select="position()"/>')</xsl:attribute> 
                        [+] 
                    </a>
          
          
          </xsl:if>
          
                  </td>                  
         <td>
          <xsl:variable name="responseData" select="responseData" />

                                   <xsl:if test="(($responseData!='') and ($detailedReport='True'))">
                                    
          
                  <a  class="btn btn-primary" name="expand" alt="OUTPUT">
                   <xsl:attribute name="id">
                        <xsl:text />page_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()" />_image</xsl:attribute>

                    <xsl:attribute name="href">
                        <xsl:text/>javascript:change('page_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()"/>')</xsl:attribute> 
                        [+] 
                    </a>
          
          </xsl:if>
                                 
          
          
          
                  </td>
          
         
                  
				<td id="responseData">
				
                <xsl:choose>

                    <xsl:when test="@s='false'">
                             <xsl:choose>
                              <xsl:when test="@rm='OK'">
                                        Other Failure
                              </xsl:when>
                              <xsl:otherwise>
							  <xsl:value-of select="@rm"/>
                              </xsl:otherwise>
                              </xsl:choose>                        
                    </xsl:when>
					<xsl:when test="@lb='End Of Test Case'">
					  <strong style="color:green;">
						<xsl:value-of select="@rm"/>
					  </strong>
					</xsl:when>
                    <xsl:otherwise>
					  <xsl:variable name="rm" select="@rm" />
						<script language="JavaScript">
							var rm = "<xsl:value-of select="$rm"/>";
							rm= rm.replace(/,/g,"<br/>");
							document.write(rm);
						</script>					  
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
             <td> <xsl:value-of select="responseData" /></td>
                </tr>
                <tr class="page_details">
                  <xsl:attribute name="id">
                  <xsl:text />page_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()" /></xsl:attribute>

                  <td colspan="8" >
                     <div align="center">
                        <table bordercolor="#000000" border="" cellpadding="5" cellspacing="1" width="90%">
                           <tr>
                              <td align="center">
                               <xsl:variable name="responseData" select="responseData" />
                               
                                     <xsl:value-of select="$responseData" />
                                   
                              </td>
                           </tr>
                        </table>
                     </div>
                  </td>
               </tr>

 <tr class="page_details">
                  <xsl:attribute name="id">
                  <xsl:text />page_details_r<xsl:value-of select="$position" />_<xsl:value-of select="position()" /></xsl:attribute>

                  <td colspan="8">
                     <div align="center">
                        <table bordercolor="#000000" border="" cellpadding="5" cellspacing="1" width="90%">
                           <tr>
                              <td align="center">
                                 <xsl:variable name="queryString" select="queryString" />
                                <xsl:attribute name="id"><xsl:text />queryString_page_details_r<xsl:value-of select="$position" />_<xsl:value-of select="position()" /></xsl:attribute>
                                 <xsl:value-of  select="$queryString" />     
                              </td>
                           </tr>
                        </table>
                     </div>
                  </td>
               </tr>


          <tr class="errorpage_details">
                  <xsl:attribute name="id">
                  <xsl:text />errorpage_details_<xsl:value-of select="$position" />_<xsl:value-of select="position()" /></xsl:attribute>

                  <td colspan="8">
                     <div align="center">
                        <table bordercolor="#000000" border="" cellpadding="5" cellspacing="1" width="90%">
                           <tr>
                              <td align="center">
                               <xsl:variable name="ResponseCode" select="@rc" />
                                     <xsl:value-of select="$ResponseCode" />
                                   
                              </td>
                           </tr>
                        </table>
                     </div>
                  </td>
               </tr>
            </xsl:for-each>
         </xsl:for-each>
      </tbody>
      </table>
   </xsl:template>


   <xsl:template name="min">
      <xsl:param name="nodes" select="/.." />
      <xsl:choose>
         <xsl:when test="not($nodes)">NaN</xsl:when>
         <xsl:otherwise>
            <xsl:for-each select="$nodes">
               <xsl:sort data-type="number" />

               <xsl:if test="position() = 1">
                  <xsl:value-of select="number(.)" />
               </xsl:if>
            </xsl:for-each>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template name="max">
      <xsl:param name="nodes" select="/.." />
      <xsl:choose>
         <xsl:when test="not($nodes)">NaN</xsl:when>
         <xsl:otherwise>
            <xsl:for-each select="$nodes">
               <xsl:sort data-type="number" order="descending" />
               <xsl:if test="position() = 1">
                  <xsl:value-of select="number(.)" />
               </xsl:if>
            </xsl:for-each>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


</xsl:stylesheet>

