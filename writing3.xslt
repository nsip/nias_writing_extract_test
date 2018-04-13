<xsl:stylesheet version="1.0"
  xmlns:sif="http://www.sifassociation.org/datamodel/au/3.4"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text"  encoding="utf-8"/>

  <xsl:strip-space elements="*" />


  <xsl:template match="/sif | /sif:sif">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="//sif:SchoolInfo | //sif:StudentPersonal | //sif:NAPTest | //sif:NAPTestlet | //sif:NAPTestItem | //sif:NAPTestScoreSummary | //sif:NAPEventStudentLink "/>
<xsl:template match="//SchoolInfo | //StudentPersonal | //NAPTest | //NAPTestlet | //NAPTestItem | //NAPTestScoreSummary | //NAPEventStudentLink "/>

<!-- https://stackoverflow.com/questions/3309746/how-to-convert-newline-into-br-with-xslt -->
<xsl:template name="insertBreaks">
   <xsl:param name="pText" select="."/>

   <xsl:choose>
     <xsl:when test="not(contains($pText, '&#xA;'))">
       <xsl:copy-of select="$pText"/>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="substring-before($pText, '&#xA;')"/>\n<xsl:call-template name="insertBreaks">
         <xsl:with-param name="pText" select=
           "substring-after($pText, '&#xA;')"/>
       </xsl:call-template>
     </xsl:otherwise>
   </xsl:choose>
 </xsl:template>


<xsl:template match="//sif:NAPStudentResponseSet">
  <xsl:value-of select="sif:NAPTestRefId"/>,<xsl:value-of select="sif:PlatformStudentIdentifier"/>,<xsl:call-template name="insertBreaks"><xsl:with-param name="pText" select="sif:TestletList/sif:Testlet[1]/sif:ItemResponseList/sif:ItemResponse[1]/sif:Response"/></xsl:call-template><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="//NAPStudentResponseSet">
  <xsl:value-of select="NAPTestRefId"/>,<xsl:value-of select="PlatformStudentIdentifier"/>,<xsl:call-template name="insertBreaks"><xsl:with-param name="pText" select="TestletList/Testlet[1]/ItemResponseList/ItemResponse[1]/Response"/></xsl:call-template><xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
