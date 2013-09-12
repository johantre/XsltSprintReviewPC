<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="fetchthisrelease" >
        <xsl:param name="sprintfolder" />
        <xsl:param name="releasedoc" />

        <xsl:for-each select="$releasedoc//releases/release">
            <xsl:variable name="releasecount" select="position()"/>
	        <xsl:for-each select="./sprintfolders/sprintfolder">
	            <xsl:variable name="fetchedfolder" select="."/>
	            <xsl:choose>
	                <xsl:when test="contains($fetchedfolder, $sprintfolder)">
	                	<xsl:if test="$releasecount &gt; 1">, </xsl:if>
	                    <xsl:value-of select="../../@name"/>
	                </xsl:when>
	            </xsl:choose>
	        </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>