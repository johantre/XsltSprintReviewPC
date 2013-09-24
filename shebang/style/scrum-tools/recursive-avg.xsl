<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="recursiveavg" >
        <xsl:param name="sprints" />
        <xsl:param name="sprintdoc" />
        <xsl:param name="thissprintfolder" />
        <xsl:param name="runningPredTotal" />
        <xsl:param name="runningcount" />
        <xsl:param name="sprintlocation" /> 

        <xsl:choose>
        <xsl:when test="$sprints/sprint[$sprintlocation + 1]" >
            <xsl:variable name="runningSumPredict">
                <xsl:call-template name="sumPred" >
                    <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                    <xsl:with-param name="runningPredTotal" select="$runningPredTotal"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$runningSumPredict div $runningcount" />
            <xsl:value-of select="','" />            
            <xsl:choose>
                <xsl:when test="$thissprintfolder > $sprints/sprint[$sprintlocation]" >
                    <xsl:call-template name="recursiveavg">
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="sprintdoc" select="document(concat('../../', $sprints/sprint[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningPredTotal" ><xsl:call-template name="sumPred" >
                                                                     <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                                                                     <xsl:with-param name="runningPredTotal" select="$runningPredTotal"/>
                                                                 </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="runningcount" select="$runningcount + 1"/>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprint[$sprintlocation]">
            <xsl:variable name="runningSumPredict">
                <xsl:call-template name="sumPred" >
                    <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                    <xsl:with-param name="runningPredTotal" select="$runningPredTotal"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$runningSumPredict div $runningcount" />
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- sum of velocity points or commitment points? -->
    <xsl:template name="sumPred" >
        <xsl:param name="sprintdoc" />
        <xsl:param name="runningPredTotal" />
        
        <xsl:value-of select="$runningPredTotal + (sum($sprintdoc//story[not(@state='story not-done')]/@points) div sum($sprintdoc//story[not(@state='story uncommitted')]/@points))" />
    </xsl:template>


</xsl:stylesheet>