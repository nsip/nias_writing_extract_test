<xsl:stylesheet version="1.0"
  xmlns:sif="http://www.sifassociation.org/datamodel/au/3.4"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text"  encoding="utf-8"/>

  <xsl:strip-space elements="*" />


  <xsl:template match="/sif | /sif:sif">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="//sif:SchoolInfo | //sif:StudentPersonal | //sif:NAPTest | //sif:NAPTestlet | //sif:NAPTestItem | //sif:NAPTestScoreSummary | //sif:NAPStudentResponseSet "/>
<xsl:template match="//SchoolInfo | //StudentPersonal | //NAPTest | //NAPTestlet | //NAPTestItem | //NAPTestScoreSummary | //NAPStudentResponseSet "/>

<xsl:template match="//sif:NAPEventStudentLink[sif:ParticipationCode = 'P' or sif:ParticipationCode = 'S' or sif:ParticipationCode = 'R']"/>
<xsl:template match="//NAPEventStudentLink[ParticipationCode = 'P' or ParticipationCode = 'S' or ParticipationCode = 'R']"/>

<xsl:template match="//sif:NAPEventStudentLink[not(sif:ParticipationCode = 'P' or sif:ParticipationCode = 'S' or sif:ParticipationCode = 'R')]">
  <xsl:value-of select="sif:NAPTestRefId"/>,<xsl:value-of select="sif:ParticipationCode"/>,<xsl:value-of select="sif:PlatformStudentIdentifier"/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="//NAPEventStudentLink[not(ParticipationCode = 'P' or ParticipationCode = 'S' or ParticipationCode = 'R')]">
  <xsl:value-of select="NAPTestRefId"/>,<xsl:value-of select="ParticipationCode"/>,<xsl:value-of select="PlatformStudentIdentifier"/><xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
