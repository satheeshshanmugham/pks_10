<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:param name="deliverable_name" required="yes"/>
    <xsl:param name="filename_guid_prefix" required="yes"/>
    <xsl:param name="load_meta_file" select="document('metadata_resource.xml')"/>

    <xsl:template match="div[@class = 'nav-content']">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
        <html>
            <head>
                <meta charset="UTF-8"/>
                <meta name="type" content="concept"/>
                <meta name="title" content="Index"/>
                <meta name="abstract"
                    content="{$load_meta_file//deliverable[@name=$deliverable_name]/publication_name}"/>
                <meta name="subject"
                    content="{$load_meta_file//deliverable[@name=$deliverable_name]/publication_name}"/>
                <meta name="description"
                    content="{$load_meta_file//deliverable[@name=$deliverable_name]/publication_name}"/>
                <meta name="keywords"
                    content="{$load_meta_file//deliverable[@name=$deliverable_name]/publication_name}"/>
                <meta name="guid">
                    <xsl:attribute name="content">
                        <xsl:value-of select="concat($filename_guid_prefix, '-', 'INDEX')"/>
                    </xsl:attribute>
                </meta>
                <meta name="format" content="HTML5"/>
                <meta name="language" content="en"/>
                <meta name="author" content="ix-vmware"/>
                <meta name="last modified">
                    <xsl:attribute name="content">
                        <xsl:value-of
                            select="format-dateTime(current-dateTime(), '[D01]/[M01]/[Y0001] [H01]:[m01]:[s01]')"
                        />
                    </xsl:attribute>
                </meta>
                <meta name="product">
                    <xsl:attribute name="content">
                        <xsl:value-of
                            select="concat($load_meta_file//deliverable[@name = $deliverable_name]/product_name, $load_meta_file//deliverable[@name = $deliverable_name]/product_version)"
                        />
                    </xsl:attribute>
                </meta>
                <link rel="stylesheet" type="text/css" href="commonltr.css"/>
                <title>Index</title>
            </head>
            <body>
                <nav>
                    <p>
                        <xsl:value-of
                            select="format-dateTime(current-dateTime(), '[D01]/[M01]/[Y0001] [H01]:[m01]:[s01]')"
                        />
                    </p>
                    <xsl:apply-templates/>
                </nav>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="ul">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>


    <xsl:template match="li">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


    <xsl:template match="a">
        <xsl:variable name="label_text" select="."/>
        <xsl:variable name="variable_href">
            <xsl:variable name="full_path" select="@href"/>
            <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
            <xsl:variable name="filename" select="substring-before($full_filename, '.')"/>
            <xsl:value-of select="concat('GUID-PKS10', '-', $filename, '.html')"/>
        </xsl:variable>
        <a href="{$variable_href}">
            <xsl:value-of select="$label_text"/>
        </a>

    </xsl:template>





</xsl:stylesheet>
