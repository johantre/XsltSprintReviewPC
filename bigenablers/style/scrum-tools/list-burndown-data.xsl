<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="recursive-sum.xsl"/>

    <xsl:template name="listburnedvelocities" >
        <xsl:param name="release" />
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprint" />

        <xsl:choose>
        <xsl:when test="$thissprint">
            <xsl:value-of select="$releasedoc//release[@name=$release]/@totalpoints" />
            <xsl:value-of select="','" />
            <xsl:for-each select="$releasedoc//release[@name=$release]">
                <xsl:call-template name="recursivesum">
                    <xsl:with-param name="doc" select="document(concat('../../', $releasedoc//release[@name=$release]/sprints/sprint[1], '/sprint-review.xml'))" />
                    <xsl:with-param name="data" select="'velocity'" />
                    <xsl:with-param name="sprints" select="$releasedoc//release[@name=$release]/sprints" />
                    <xsl:with-param name="thissprint" select="$thissprint" />
                    <xsl:with-param name="runningtotal" select="$releasedoc//release[@name=$release]/@totalpoints" />
                    <xsl:with-param name="sprintlocation" select="1" />
                </xsl:call-template>
            </xsl:for-each>        
        </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="listburnedcommitments" >
        <xsl:param name="release" />
        <xsl:param name="releasedoc" />
        <xsl:param name="thissprint" />
        
        <xsl:choose>
        <xsl:when test="$thissprint">
            <xsl:value-of select="$releasedoc//release[@name=$release]/@totalpoints" />
            <xsl:value-of select="','" />
            <xsl:for-each select="$releasedoc//release[@name=$release]">
                <xsl:call-template name="recursivesum">
                    <xsl:with-param name="doc" select="document(concat('../../', $releasedoc//release[@name=$release]/sprints/sprint[1], '/sprint-review.xml'))" />
                    <xsl:with-param name="data" select="'commitment'" />
                    <xsl:with-param name="sprints" select="$releasedoc//release[@name=$release]/sprints" />
                    <xsl:with-param name="thissprint" select="$thissprint" />
                    <xsl:with-param name="runningtotal" select="$releasedoc//release[@name=$release]/@totalpoints" />
                    <xsl:with-param name="sprintlocation" select="1" />
                </xsl:call-template>
            </xsl:for-each>
        </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="listsprints" >
        <xsl:param name="release" />
        <xsl:param name="releasedoc" />

        <xsl:value-of select="'00,'" />
        <xsl:for-each select="$releasedoc//release[@name=$release]/sprints/sprint">
            <xsl:value-of select="." />
            <xsl:value-of select="','" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="totalpoints" >
        <xsl:param name="release" />
        <xsl:param name="releasedoc" />
        
        <xsl:for-each select="$releasedoc//release[@name=$release]">
            <xsl:value-of select="$releasedoc//release[@name=$release]/@totalpoints" />
        </xsl:for-each>
    </xsl:template>

    
</xsl:stylesheet>