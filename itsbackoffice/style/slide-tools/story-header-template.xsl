<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="mkslink-template.xsl"/>

	<xsl:template name="storyheader">
    <xsl:param name="state"/>
    <xsl:param name="id"/>
    <xsl:param name="title"/>

    <h3 class="{$state}">
        <xsl:call-template name="storylink">
            <xsl:with-param name="id" select="translate($id,' ','')" />
            <xsl:with-param name="state" select="$state" />
            <xsl:with-param name="title" select="$title"/>
        </xsl:call-template>
    </h3>
    
	</xsl:template>
</xsl:stylesheet>