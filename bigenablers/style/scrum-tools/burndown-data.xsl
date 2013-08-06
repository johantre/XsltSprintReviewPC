<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template name="fetchvelocities" >
        <xsl:param name="doc" />
        <xsl:param name="sprints" />
        <xsl:param name="thissprint" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprint[$sprintlocation + 1]" >
            <xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points)" />
            <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprint > $sprints/sprint[$sprintlocation]" >
                    <xsl:call-template name="fetchvelocities">
                        <xsl:with-param name="doc" select="document(concat('../../', $sprints/sprint[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal - sum($doc//story[@state='story done']/@points)"/>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="fetchvelocities">                                <!-- xml-doc from: $thissprint iso $sprints/sprint[$sprintlocation + 1] -->
                        <xsl:with-param name="doc" select="document(concat('../../', $thissprint, '/sprint-review.xml'))" /> 
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprint[$sprintlocation]">
            <xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points)" />
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="fetchcommitment" >
        <xsl:param name="doc" />
        <xsl:param name="sprints" />
        <xsl:param name="thissprint" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprint[$sprintlocation + 1]">
        <xsl:value-of select="$runningtotal - sum($doc//story/@points)" />
        <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprint > $sprints/sprint[$sprintlocation]" >
                    <xsl:call-template name="fetchcommitment">                                      
                        <xsl:with-param name="doc" select="document(concat('../../', $sprints/sprint[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal - sum($doc//story/@points)"/>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="fetchcommitment">                                <!-- xml-doc from: $thissprint iso $sprints/sprint[$sprintlocation + 1] -->                            
                        <xsl:with-param name="doc" select="document(concat('../../', $thissprint, '/sprint-review.xml'))" />
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprint[$sprintlocation]">
            <xsl:value-of select="$runningtotal - sum($doc//story/@points)" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="listburnedvelocities" >
        <xsl:param name="sprintnumber" />

        <xsl:variable name="releasedoc" select="document('../release-burndown.xml')"/>
        <xsl:value-of select="$releasedoc//@totalpoints" />
        <xsl:value-of select="','" />
        <xsl:for-each select="$releasedoc">
            <xsl:call-template name="fetchvelocities">
                <xsl:with-param name="doc" select="document(concat('../../', $releasedoc//sprints/sprint[1], '/sprint-review.xml'))" />
                <xsl:with-param name="sprints" select="$releasedoc//sprints" />
                <xsl:with-param name="thissprint" select="$releasedoc//sprints/sprint[$sprintnumber]" />
                <xsl:with-param name="runningtotal" select="$releasedoc//@totalpoints" />
                <xsl:with-param name="sprintlocation" select="1" />
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listburnedcommitments" >
        <xsl:param name="sprintnumber" />

        <xsl:variable name="releasedoc" select="document('../release-burndown.xml')"/>
        <xsl:value-of select="$releasedoc//@totalpoints" />
        <xsl:value-of select="','" />
        <xsl:for-each select="$releasedoc">
            <xsl:call-template name="fetchcommitment">
                <xsl:with-param name="doc" select="document(concat('../../', $releasedoc//sprints/sprint[1], '/sprint-review.xml'))" />
                <xsl:with-param name="sprints" select="$releasedoc//sprints" />
                    <xsl:with-param name="thissprint" select="$releasedoc//sprints/sprint[$sprintnumber]" />
                <xsl:with-param name="runningtotal" select="$releasedoc//@totalpoints" />
                <xsl:with-param name="sprintlocation" select="1" />
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="listsprints" >
        <xsl:variable name="releasedoc" select="document('../release-burndown.xml')"/>
        <xsl:value-of select="'00,'" />
        <xsl:for-each select="$releasedoc//sprints/sprint">
            <xsl:value-of select="." />
            <xsl:value-of select="','" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="totalpoints" >
        <xsl:variable name="releasedoc" select="document('../release-burndown.xml')"/>
        <xsl:for-each select="$releasedoc">
            <xsl:value-of select="$releasedoc//@totalpoints" />
        </xsl:for-each>
    </xsl:template>

    
</xsl:stylesheet>