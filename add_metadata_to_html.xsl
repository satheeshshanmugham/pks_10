<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd" exclude-result-prefixes="MadCap">

    <xsl:param name="deliverable_name" required="yes"/>
    <xsl:param name="filename_guid_prefix" required="yes"/>
    <xsl:param name="load_meta_file" select="document('metadata_resource.xml')"></xsl:param>

    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="yes"/>


    <xsl:variable name="variable_topictitle">
        <xsl:copy-of select="html/head/title"/>
    </xsl:variable>

    <xsl:variable name="variable_shortdesc">
        <xsl:choose>
            <xsl:when test="html/body/p[1]=''">
                <xsl:copy-of select="html/body/p[2]"></xsl:copy-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="html/body/p[1]"></xsl:copy-of>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:variable>

    <xsl:variable name="variable_guid">
        <xsl:variable name="full_path" select="document-uri()"/>
        <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
        <xsl:variable name="filename" select="substring-before($full_filename, '.')"/>
        <xsl:value-of select="concat($filename_guid_prefix, '-', $filename)"/>
    </xsl:variable>

    <xsl:template match="head/title"/>

    <xsl:template match="body">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="type" content="topic"/>
                <meta name="title" content="{$variable_topictitle}"/>
                <meta name="abstract" content=""/>
                <meta name="subject" content="{$load_meta_file//deliverable[@name=$deliverable_name]/publication_name}"/>
                <meta name="description" content="{$variable_shortdesc}"/>
                <meta name="keywords" content=""/>
                <meta name="guid">
                   <xsl:attribute name="content">                       
                       <!--<xsl:value-of select="$variable_guid"/>-->
                       <xsl:value-of select="replace($variable_guid, '%20', ' ')"/>
                   </xsl:attribute>
                </meta>
                <meta name="format" content="HTML5"/>
                <meta name="language" content="en"/>
                <meta name="author" content="ix-vmware"/>
                <meta name="last modified">
                    <xsl:attribute name="content">
                        <xsl:value-of select="format-dateTime(current-dateTime(), '[D01]/[M01]/[Y0001] [H01]:[m01]:[s01]')"/>
                    </xsl:attribute>
                </meta>
                <meta name="product">
                    <xsl:attribute name="content">
                        <xsl:value-of select="concat($load_meta_file//deliverable[@name=$deliverable_name]/product_name, ' ', $load_meta_file//deliverable[@name=$deliverable_name]/product_version)"/>
                    </xsl:attribute>
                </meta>
                <link rel="stylesheet" type="text/css" href="commonltr.css"/>
                <title><xsl:value-of select="$variable_topictitle"/></title>
            </head>
            <body>
                <main role="main">
                    <article role="article" aria-labelledby="{replace($variable_guid, '%20', ' ')}">
                        <xsl:copy-of select="node()|@*"/>
                    </article>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
