<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"    
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:strip-space elements="*"/>    
    <xsl:output method="xhtml" indent="yes" />
    
    <xsl:param name="filename_guid_prefix" required="yes"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="a[@href]">
        <xsl:choose>
            <xsl:when test="contains(@href, 'http')">
                <xsl:variable name="xref_text">
                    <xsl:variable name="validate_text" select="."/>
                    <xsl:value-of select="$validate_text"/>
                </xsl:variable>
                
                <a class="xref">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:attribute>
                    
                    <xsl:value-of select="$xref_text"></xsl:value-of>
                </a>  
                
            </xsl:when>
            <xsl:when test="contains(@href, '.html')">
                <xsl:variable name="xref_text">
                    <xsl:variable name="validate_text" select="."/>
                    <xsl:value-of select="$validate_text"/>
                </xsl:variable>
                
                <xsl:variable name="variable_guid">
                    <xsl:variable name="full_path" select="@href"/>
                    <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
                    <!--<xsl:variable name="filename" select="substring-before($full_filename, '.htm')"/>-->
                    <!--<xsl:value-of select="concat($filename_guid_prefix, '-', $filename, '.html')"/>-->
                    <xsl:value-of select="concat($filename_guid_prefix, '-', $full_filename)"/>
                </xsl:variable>
                
                <!--<xsl:variable name="variable_guid">
                    <xsl:variable name="full_path" select="@href"/>
                    <xsl:variable name="full_filename" select="tokenize($full_path, '/')[last()]"/>
                    <xsl:variable name="filename" select="substring-before($full_filename, '.htm')"/>
                    <xsl:value-of select="concat('GUID-PKS10', '-', $filename, '.html')"/>                    
                </xsl:variable>-->
                
                <a class="xref">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$variable_guid"/>
                    </xsl:attribute>
                    
                    <xsl:value-of select="$xref_text"></xsl:value-of>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="xref_text">
                    <xsl:variable name="validate_text" select="."/>
                    <xsl:value-of select="$validate_text"/>
                </xsl:variable>
                <a class="xref">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@href"/>
                    </xsl:attribute>
                    
                    <xsl:value-of select="$xref_text"></xsl:value-of>
                </a>  
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Code to fix incorrect image tags in MD -->
    
    <!--<xsl:template match="em">
        <xsl:value-of select="concat('_', . , '_')"/>
    </xsl:template>-->
    
    <xsl:template match="p[contains(., '.png') and contains(., 'image_tag')]">
        
        <xsl:variable name="variable_image_filename">        
            <xsl:variable name="full_path">
                <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:variable name="filename_chunk1" select="substring-before($full_path, '&quot;)')"/>            
            <xsl:variable name="filename" select="substring-after($filename_chunk1, 'image_tag(&quot;')"/>
            <xsl:value-of select="concat('images/', $filename)"/>                    
        </xsl:variable>
        
        <xsl:variable name="image_alt_text">
            <xsl:variable name="temp" select="substring-after($variable_image_filename, 'images/')"/>
            <xsl:value-of select="substring-before($temp, '.png')"/>
        </xsl:variable>
        
        <xsl:variable name="image_style">
            <xsl:variable name="image_dimension">
                <xsl:value-of select="@style"/>
            </xsl:variable>
            <xsl:value-of select="$image_dimension"/>
        </xsl:variable>
        
        <img class="image" src="{$variable_image_filename}" alt="{$image_alt_text}"></img>        
    </xsl:template>
    
    <xsl:template match="table">
        <table class="table">
            <colgroup>
                <xsl:for-each select="col">
                    <col><xsl:apply-templates select="node()"></xsl:apply-templates></col>
                </xsl:for-each>
            </colgroup>
            <xsl:apply-templates select="node() except col"></xsl:apply-templates>
        </table>        
    </xsl:template>
    
    <xsl:template match="table/thead">
        <thead class="thead"><xsl:apply-templates select="node()"></xsl:apply-templates></thead>
    </xsl:template>
    
    <xsl:template match="table/thead/tr">
        <tr class="row"><xsl:apply-templates select="node()"></xsl:apply-templates></tr>
    </xsl:template>
    
    <xsl:template match="table/thead/tr/th">
        <th class="entry"><xsl:apply-templates select="node()|@colspan | @rowspan"></xsl:apply-templates></th>
    </xsl:template>
    
    <xsl:template match="table/tbody">
        <tbody class="tbody"><xsl:apply-templates select="node()"></xsl:apply-templates></tbody>
    </xsl:template>
    
    <xsl:template match="table/tbody/tr">
        <tr class="row"><xsl:apply-templates select="node()"></xsl:apply-templates></tr>
    </xsl:template>
    
    <!-- Code to transform code elements -->
    
    <xsl:template match="code">
        <code class="ph codeph vm-code-block prettyprint"><xsl:apply-templates select="node()"></xsl:apply-templates></code>
    </xsl:template>
    
    <xsl:template match="pre | div[@class='terminal']" >
        <div>
            <pre class="pre codeblock vm-code-block prettyprint">
            <xsl:apply-templates select="node()"></xsl:apply-templates>
        </pre>
        </div>
    </xsl:template>
    
    <!--<xsl:template match="html/body/main/article/br[1]"></xsl:template>
    <xsl:template match="html/body/main/article/br[2]"></xsl:template>-->
    
    <!-- Code to remove br tags -->
    <xsl:template match="br[parent::article [node()]]"></xsl:template>
    <xsl:template match="li/br"></xsl:template>
    
    <!-- USE THIS :- Code to remove empty line breaks inside the elements -->
    
   <!-- <xsl:template match="pre/text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>-->
    
    
    
    <!-- Alternate Code to remove empty line breaks inside the elements -->
    
    <!--<xsl:template match="*/text()[normalize-space()]">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>    
    <xsl:template match="*/text()[not(normalize-space())]" />-->   
    
    
</xsl:stylesheet>