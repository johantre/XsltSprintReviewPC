<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="fetch-thissprint.xsl"/>

    <xsl:template name="recursivesum" >
        <xsl:param name="doc" />
        <xsl:param name="data" />
        <xsl:param name="sprints" />
        <xsl:param name="thissprintfolder" />
        <xsl:param name="runningtotal" />
        <xsl:param name="sprintlocation" />

        <xsl:choose>
        <xsl:when test="$sprints/sprint[$sprintlocation + 1]" >
            <xsl:choose>
                <xsl:when test="contains($data,'velocity')">
                    <xsl:call-template name="velocitysum">
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                        <xsl:with-param name="doc" select="$doc"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="commitmentsum">
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                        <xsl:with-param name="doc" select="$doc"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>            
            <xsl:value-of select="','" />
            <xsl:choose>
                <xsl:when test="$thissprintfolder > $sprints/sprint[$sprintlocation]" >
                    <xsl:call-template name="recursivesum">
                        <xsl:with-param name="doc" select="document(concat('../../', $sprints/sprint[$sprintlocation + 1], '/sprint-review.xml'))" />
                        <xsl:with-param name="data" select="$data"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningtotal" >
                            <xsl:choose>
                                <xsl:when test="contains($data,'velocity')">
                                    <xsl:call-template name="velocitysum">
                                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                                        <xsl:with-param name="doc" select="$doc"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="commitmentsum">
                                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                                        <xsl:with-param name="doc" select="$doc"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" />
                    </xsl:call-template>            
                </xsl:when>
                <xsl:otherwise> <!-- continue recursion, but take : --> 
                    <xsl:call-template name="recursivesum">                                <!-- xml-doc from: $thissprintfolder iso $sprints/sprint[$sprintlocation + 1] -->
                        <xsl:with-param name="doc" select="document(concat('../../', $thissprintfolder, '/sprint-review.xml'))" /> 
                        <xsl:with-param name="data" select="$data"/>
                        <xsl:with-param name="sprints" select="$sprints" />
                        <xsl:with-param name="thissprintfolder" select="$thissprintfolder"/>
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>          <!-- running total = fixed through coming recursions -->
                        <xsl:with-param name="sprintlocation" select="$sprintlocation + 1" /> <!-- continue counting, till the end -->
                    </xsl:call-template>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$sprints/sprint[$sprintlocation]">
            <xsl:choose>
                <xsl:when test="contains($data,'velocity')">
                    <xsl:call-template name="velocitysum">
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                        <xsl:with-param name="doc" select="$doc"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="commitmentsum">
                        <xsl:with-param name="runningtotal" select="$runningtotal"/>
                        <xsl:with-param name="doc" select="$doc"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>            
            <xsl:value-of select="','" />
        </xsl:when>
        <xsl:otherwise>failure!!</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="velocitysum" >
        <xsl:param name="runningtotal" />
        <xsl:param name="doc" />
        <xsl:value-of select="$runningtotal - sum($doc//story[@state='story done']/@points) - sum($doc//story[@state='story uncommitted']/@points)" />
    </xsl:template>

    <xsl:template name="commitmentsum" >
        <xsl:param name="runningtotal" />
        <xsl:param name="doc" />
        <xsl:value-of select="$runningtotal - sum($doc//story/@points) + sum($doc//story[@state='story uncommitted']/@points)" />
    </xsl:template>


</xsl:stylesheet>