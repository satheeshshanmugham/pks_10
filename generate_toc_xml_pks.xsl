<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="yes"/>

    <xsl:param name="deliverable_name" required="yes"/>
    <xsl:param name="filename_guid_prefix" required="yes"/>
    <xsl:param name="opening_page" required="yes"/>
    <xsl:param name="load_meta_file" select="document('metadata_resource.xml')"/>


    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">
<![CDATA[<?NLS TYPE="org.html5.toc"?>]]>
</xsl:text>
        <xsl:variable name="index_page"
            select="concat($filename_guid_prefix, '-', $opening_page)"/>
        <toc label="{$load_meta_file//deliverable[@name = $deliverable_name]/publication_name}"
            topic="{$index_page}">

            <xsl:apply-templates/>
            
        </toc>
    </xsl:template>



    <xsl:template match="li">
        <xsl:variable name="label_text" select="a"/>
        <xsl:variable name="variable_href">
            <xsl:variable name="full_path" select="a/@href"/>
            <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
            <xsl:variable name="filename" select="substring-before($full_filename, '.')"/>
            <xsl:value-of select="concat($filename_guid_prefix, '-', $filename, '.html')"/>
        </xsl:variable>

        <topic label="{normalize-space(replace($label_text, '&#xA;', ' '))}" href="{$variable_href}">
            <xsl:apply-templates/>
        </topic>

    </xsl:template>

    <xsl:template match="a"/>



</xsl:stylesheet>
