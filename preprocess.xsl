<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:strip-space elements="*"/>    
    <xsl:output method="xhtml" indent="yes" />
    
    <xsl:template match="node()|@*">        
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>        
    </xsl:template>
    
    <xsl:variable name="get_title">
        <xsl:variable name="full_text" select="html/body/p[contains(., 'title:')]"/>
        <xsl:variable name="title_chunk" select="substring-before($full_text, ' owner:')"/>
        <xsl:variable name="title_actual" select="substring-after($title_chunk, 'title: ')"/>
        <xsl:value-of select="$title_actual"/>
    </xsl:variable>
        
    
    
    <xsl:template match="html/head/title">
        <xsl:element name="title">
            <xsl:value-of select="$get_title"/>
        </xsl:element>
        
    </xsl:template>
    <xsl:template match="p[contains(., 'title:')]"></xsl:template>
    <xsl:template match="p[contains(., 'modified_date')]"></xsl:template>
    
    
    
    
    
</xsl:stylesheet>