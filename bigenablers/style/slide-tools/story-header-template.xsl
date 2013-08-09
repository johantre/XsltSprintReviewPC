<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="mkslink-template.xsl"/>

	<xsl:template name="storyheader">
    <xsl:param name="state"/>
    <xsl:param name="mksid"/>
    <xsl:param name="title"/>

    <xsl:text disable-output-escaping="yes">&lt;h3 class=&quot;</xsl:text><xsl:value-of select="$state" /><xsl:text disable-output-escaping="yes">&quot;&gt;</xsl:text>
        <xsl:call-template name="mkslink">
            <xsl:with-param name="id" select="translate($mksid,' ','')" />
            <xsl:with-param name="state" select="$state" />
            <xsl:with-param name="title" select="$title"/>
        </xsl:call-template>
    <xsl:text disable-output-escaping="yes">&lt;/h3&gt;</xsl:text>

	</xsl:template>
</xsl:stylesheet>