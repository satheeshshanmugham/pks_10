<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >
    
    <xsl:param name="deliverable_name" required="yes"/>
    
    <xsl:param name="load_meta_file" select="document('metadata_resource.xml')"></xsl:param>
    <xsl:param name="load_merged_meta_file" select="document('metadata_info_temp.xml')"></xsl:param>
    
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="yes"/>
    
    
    
    <xsl:template match="/">
        <publication>                      
            <publication-name><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/publication_name"/></publication-name>
            <product-name><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/product_name"/></product-name>
            <publication-cms-title><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/publication_cms_title"/></publication-cms-title>
            <product-version><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/product_version"/></product-version>
            <publication-version>1</publication-version>
            <publication-version-comments></publication-version-comments>
            <language>en</language>
            <publication-guid><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/publication_guid"/></publication-guid>
            <publication-milestone>GA</publication-milestone>
            <publication-keywords></publication-keywords>
            <publication-output-type>HTML5</publication-output-type>
            <publication-date><xsl:value-of  select="format-dateTime(current-dateTime(), '[D01]/[M01]/[Y0001] [H01]:[m01]:[s01]')"/></publication-date>            
            <output-file-name><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/output_file_name_html"/></output-file-name>
            <publication-author>ix-vmware</publication-author>
            <content-source>publication</content-source>
            <pdflink><xsl:value-of select="$load_meta_file//deliverable[@name=$deliverable_name]/output_file_name_pdf"/></pdflink>
            <wordlink></wordlink>
           
                <xsl:copy-of select="node()"/>
            
        </publication>
    </xsl:template> 
    
</xsl:stylesheet>