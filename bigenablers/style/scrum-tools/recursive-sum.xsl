<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="fetch-thissprint.xsl"/>

    <xsl:template name="recursivesum" >
        <xsl:param name="doc" />
        <xsl:param name="data" />
        <xsl:param name="sprints" />
        <xsl:param name="thissprint" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprint[$sprintlocation + 1]" >
            <xsl:choose>
                <xsl:when test="contains($data,'velocity')"><xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points)" /></xsl:when>
                <xsl:otherwise><xsl:value-of select="$runningtotal - sum($doc//story/@points)" /></xsl:otherwise>
            </xsl:choose>            
            <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprint > $sprints/sprint[$sprintlocation]" >
                    <xsl:call-template name="recursivesum">
                        <xsl:with-param name="doc" select="document(concat('../../', $sprints/sprint[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="data" select="$data"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" >
                            <xsl:choose>
                                <xsl:when test="contains($data,'velocity')"><xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points)" /></xsl:when>
                                <xsl:otherwise><xsl:value-of select="$runningtotal - sum($doc//story/@points)" /></xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="recursivesum">                                <!-- xml-doc from: $thissprint iso $sprints/sprint[$sprintlocation + 1] -->
                        <xsl:with-param name="doc" select="document(concat('../../', $thissprint, '/sprint-review.xml'))" /> 
                        <xsl:with-param name="data" select="$data"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprint" select="$thissprint"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprint[$sprintlocation]">
            <xsl:choose>
                <xsl:when test="contains($data,'velocity')"><xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points)" /></xsl:when>
                <xsl:otherwise><xsl:value-of select="$runningtotal - sum($doc//story/@points)" /></xsl:otherwise>
            </xsl:choose>            
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>