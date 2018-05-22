<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xhtml" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:param name="deliverable_name" required="yes"/>
    
    <xsl:param name="load_meta_file" select="document('metadata_resource.xml')"></xsl:param>
    
    <xsl:variable name="variable_guid">
        <xsl:variable name="full_path" select="document-uri()"/>
        <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
        <xsl:variable name="filename" select="substring-before($full_filename, '.')"/>
        <xsl:value-of select="$filename"/>
    </xsl:variable>
    
    <xsl:template match="/">
       
            <topic>             
                <type>topic</type>
                <subject><xsl:value-of select="html/head/meta[@name='keywords']/@content"/></subject>
                <title><xsl:value-of select="html/head/meta[@name='title']/@content"/></title>
                <abstract><xsl:value-of select="html/head/meta[@name='abstract']/@content"/></abstract>
                <description><xsl:value-of select="html/head/meta[@name='description']/@content"/></description>                
                <keywords><xsl:value-of select="html/head/meta[@name='keywords']/@content"/></keywords>
                <!--<guid><xsl:value-of select="$variable_guid"/></guid>-->
                <guid><xsl:value-of select="replace($variable_guid, '%20', ' ')"/></guid>
                <format>HTML5</format>
                <language>en</language>
                <last-modified><xsl:value-of select="html/head/meta[@name='last modified']/@content"/></last-modified>
                <author>ix-vmware</author>
                <product><xsl:value-of select="html/head/meta[@name='product']/@content"/></product>
            </topic>
        
    </xsl:template>
    
 </xsl:stylesheet>