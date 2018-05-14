<xsl:stylesheet version="1.0"
  xmlns:sif="http://www.sifassociation.org/datamodel/au/3.4"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text"  encoding="utf-8"/>

  <xsl:strip-space elements="*" />


  <xsl:template match="/sif | /sif:sif">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="//sif:SchoolInfo | //sif:StudentPersonal | //sif:NAPEventStudentLink | //sif:NAPTestlet | //sif:NAPTestItem | //sif:NAPTestScoreSummary | //sif:NAPStudentResponseSet | //sif:NAPCodeFrame"/>
<xsl:template match="//SchoolInfo | //StudentPersonal | //NAPEventStudentLink | //NAPTestlet | //NAPTestItem | //NAPTestScoreSummary | //NAPStudentResponseSet | //NAPCodeFrame"/>

<xsl:template match="//sif:NAPTest[not(sif:TestContent/sif:Domain = 'Writing')]"/>
<xsl:template match="//NAPTest[not(TestContent/Domain = 'Writing')]"/>

<xsl:template match="//sif:NAPTest[sif:TestContent/sif:Domain = 'Writing']">
  <xsl:value-of select="@RefId"/>,<xsl:value-of select="sif:TestContent/sif:NAPTestLocalId"/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="//NAPTest[TestContent/Domain = 'Writing']">
  <xsl:value-of select="@RefId"/>,<xsl:value-of select="TestContent/NAPTestLocalId"/><xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
