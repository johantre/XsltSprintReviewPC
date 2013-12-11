<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="fetchthissprint" >
        <xsl:param name="sprintfolder" />
        <xsl:param name="releasedoc" />
        
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="fetchedfolder" select="."/>
            <xsl:choose>
                <xsl:when test="contains($fetchedfolder, $sprintfolder)">
                    <xsl:value-of select="@name"/>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>