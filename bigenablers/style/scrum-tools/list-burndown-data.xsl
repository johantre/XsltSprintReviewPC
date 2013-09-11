<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="recursive-sum.xsl"/>
    <xsl:import href="fetch-thisrelease.xsl"/>

    <xsl:template name="listburnedsumsinrelease" >
        <xsl:param name="sumtype" />
        <xsl:param name="releaseid" />
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprintfolder" />

        <xsl:choose>
            <xsl:when test="$thissprintfolder">
                <xsl:value-of select="$releasedoc//release[@id=$releaseid]/@totalpoints" />
                <xsl:value-of select="','" />
                <xsl:for-each select="$releasedoc//release[@id=$releaseid]">
                    <xsl:call-template name="recursivesum">
                        <xsl:with-param name="sumtype" select="$sumtype" />
                        <xsl:with-param name="sprints" select="$releasedoc//release[@id=$releaseid]/sprintfolders" />
                        <xsl:with-param name="releaseid" select="$releaseid"/>
                        <xsl:with-param name="sprintdoc" select="document(concat('../../', $releasedoc//release[@id=$releaseid]/sprintfolders/sprintfolder[1], '/sprint-review.xml'))" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder" />
                        <xsl:with-param name="runningtotal" select="$releasedoc//release[@id=$releaseid]/@totalpoints" />
                        <xsl:with-param name="sprintlocation" select="1" />
                    </xsl:call-template>
                </xsl:for-each>        
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="listsprints" >
        <xsl:param name="releaseid" />
        <xsl:param name="releasedoc" />
       '<xsl:value-of select="'00'" />'<xsl:value-of select="','" />
        <xsl:for-each select="$releasedoc//release[@id=$releaseid]/sprintfolders/sprintfolder">
            <xsl:variable name="fetchedfolder" select="."/>

            <xsl:for-each select="$releasedoc//sprints/sprint">
                <xsl:variable name="fetchedfolderinner" select="."/>
                <xsl:choose>
                    <xsl:when test="contains($fetchedfolder, $fetchedfolderinner)">'<xsl:value-of select="@name" />'<xsl:value-of select="','" /></xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="totalpoints" >
        <xsl:param name="releaseid" />
        <xsl:param name="releasedoc" />
        
        <xsl:for-each select="$releasedoc//release[@id=$releaseid]">
            <xsl:value-of select="$releasedoc//release[@id=$releaseid]/@totalpoints" />
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>