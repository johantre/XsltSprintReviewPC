<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="fetchthisrelease" >
        <xsl:param name="sprintnumber" />
        <xsl:param name="releasedoc" />

        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:variable name="sprint" select="." /> 
            <xsl:variable name="doc" select="document(concat('../../', $sprint, '/sprint-review.xml'))" />
            <xsl:variable name="fetchedid" select="$doc//sprintreview/@id"/>
            
            <xsl:choose>
                <xsl:when test="$fetchedid = $sprintnumber">
                    <xsl:value-of select="../../@name"/>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>