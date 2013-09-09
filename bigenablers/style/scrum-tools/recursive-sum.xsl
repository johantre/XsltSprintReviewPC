<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="fetch-thissprint.xsl"/>

    <xsl:template name="recursivesum" >
        <xsl:param name="sumtype" />
        <xsl:param name="sprints" />
        <xsl:param name="sprintdoc" />
        <xsl:param name="thissprintfolder" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprintfolder[$sprintlocation + 1]" >
            <xsl:call-template name="sumpoints" >
                <xsl:with-param name="sumtype" select="$sumtype"/>
                <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                <xsl:with-param name="runningtotal" select="$runningtotal"/>
            </xsl:call-template>
            <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprintfolder > $sprints/sprintfolder[$sprintlocation]" >
                    <xsl:call-template name="recursivesum">
                        <xsl:with-param name="sumtype" select="$sumtype"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="sprintdoc" select="document(concat('../../', $sprints/sprintfolder[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningtotal" ><xsl:call-template name="sumpoints" >
                                                                 <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                                                                 <xsl:with-param name="sumtype" select="$sumtype"/>
                                                                 <xsl:with-param name="runningtotal" select="$runningtotal"/>
                                                             </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="recursivesum">                                <!-- xml-doc from: $thissprintfolder iso $sprints/sprint[$sprintlocation + 1] -->
                        <xsl:with-param name="sumtype" select="$sumtype"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="sprintdoc" select="document(concat('../../', $thissprintfolder, '/sprint-review.xml'))" /> 
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprintfolder[$sprintlocation]">
            <xsl:call-template name="sumpoints" >
                <xsl:with-param name="sumtype" select="$sumtype"/>
                <xsl:with-param name="sprintdoc" select="$sprintdoc" />
                <xsl:with-param name="runningtotal" select="$runningtotal"/>
            </xsl:call-template>
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- sum of velocity points or commitment points? -->
    <xsl:template name="sumpoints" >
        <xsl:param name="sumtype" />
        <xsl:param name="sprintdoc" />
        <xsl:param name="runningtotal" />
        <xsl:choose>
            <xsl:when test="contains($sumtype,'velocity')">
                <xsl:call-template name="velocitysum">
                    <xsl:with-param name="sprintdoc" select="$sprintdoc"/>
                    <xsl:with-param name="runningtotal" select="$runningtotal"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="commitmentsum">
                    <xsl:with-param name="sprintdoc" select="$sprintdoc"/>
                    <xsl:with-param name="runningtotal" select="$runningtotal"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- the formula to the sum of points WITHIN THAT SPRINT(document) to determine the BURNED velocity: [running Total - recursion(sum(done) - sum(uncommitted)) ] -->
    <xsl:template name="velocitysum" >
        <xsl:param name="sprintdoc" />
        <xsl:param name="runningtotal" />
        <xsl:value-of select="$runningtotal - sum($sprintdoc//story[@state='story done']/@points) - sum($sprintdoc//story[@state='story uncommitted']/@points)" />
    </xsl:template>

    <!-- the formula to the sum of points WITHIN THAT SPRINT(document) to determine the BURNED commitment: [running Total - recursion(sum(all points) + sum(uncommitted)) ]-->
    <xsl:template name="commitmentsum" >
        <xsl:param name="sprintdoc" />
        <xsl:param name="runningtotal" />
        <xsl:value-of select="$runningtotal - sum($sprintdoc//story/@points) + sum($sprintdoc//story[@state='story uncommitted']/@points)" />
    </xsl:template>


</xsl:stylesheet>