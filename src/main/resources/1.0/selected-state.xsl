<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xsams="http://vamdc.org/xml/xsams/1.0">
        
  <!-- Display rules for molecular states in the case-by-case framework. -->
  <xsl:include href="cbc.xsl"/>
  
  <xsl:include href="sources.xsl"/>
  
  <xsl:include href="species-name.xsl"/>
    
  <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
  
  <xsl:param name="id"/>
  <xsl:param name="css-location"/>
    
  <xsl:template match="xsams:XSAMSData">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
        <title>Single-state view of XSAMS</title>
        <link rel="stylesheet" type="text/css">
          <xsl:attribute name="href"><xsl:value-of select="$css-location"/></xsl:attribute>
        </link>
      </head>
      <body>
        <h1>Single-state view of XSAMS</h1>
        <p>
          <xsl:call-template name="query-source"><xsl:with-param name="source" select="xsams:Sources/xsams:Source[1]"/></xsl:call-template>
        </p>
        <xsl:apply-templates select="xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState[@stateID=$id]"/>
        <xsl:apply-templates select="xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState[@stateID=$id]"/>
      </body>
    </html>
  </xsl:template>
    
    <xsl:template match="xsams:MolecularState">
      <h2>Species</h2>
      <p>
        <xsl:text>InChI=</xsl:text>
        <xsl:value-of select="../xsams:MolecularChemicalSpecies/xsams:InChI"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="../xsams:MolecularChemicalSpecies/xsams:InChIKey"/>
        <xsl:text>)</xsl:text>
      </p>
      <p>
        <xsl:text>Structural formula: </xsl:text>
        <xsl:call-template name="molecule">
          <xsl:with-param name="molecule" select=".."/>
        </xsl:call-template>
      </p>
      <p>
        <xsl:text>Stoichiometric formula: </xsl:text>
        <xsl:value-of select="../xsams:MolecularChemicalSpecies/xsams:StoichiometricFormula"/>
      </p>
      <p>
        <xsl:text>Chemical name: </xsl:text>
        <xsl:value-of select="../xsams:MolecularChemicalSpecies/xsams:ChemicalName/xsams:Value"/>
      </p>
      <p>
        <xsl:variable name="nisturl">http://webbook.nist.gov/cgi/cbook.cgi?Units=SI&amp;InChI=<xsl:value-of select="../xsams:MolecularChemicalSpecies/xsams:InChIKey"/></xsl:variable>
        <a href="{$nisturl}">Information from NIST chemical web-book.</a>
      </p>
      
      <h2>State</h2>
      <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xsams:AtomicState">
      <xsl:if test="@stateID=$id">
        <h2>Species</h2>
        <p>
          <xsl:call-template name="atomic-ion">
            <xsl:with-param name="ion" select=".."/>
          </xsl:call-template>
        </p>
        <p>
          <xsl:value-of select="../xsams:InChI"/>
          <xsl:text> (</xsl:text>
          <xsl:value-of select="../xsams:InChIKey"/>
          <xsl:text>)</xsl:text>
        </p>
        <p>
          <xsl:text>Ion charge: </xsl:text>
          <xsl:value-of select="../xsams:IonCharge"/>
        </p>
        <p>
          <xsl:text> Nuclear spin: </xsl:text>
          <xsl:value-of select="../../xsams:IsotopeParameters/xsams:NuclearSpin"/>
        </p>
        <h2>State</h2>
        <p>
          <xsl:text>State description: </xsl:text>
          <xsl:value-of select="xsams:Description"/>
        </p>
        <xsl:apply-templates/>
      </xsl:if>
    </xsl:template>
    
    <xsl:template match="xsams:StateEnergy">
        <p>
            <xsl:text>Energy above ground state: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:IonizationEnergy">
        <p>
            <xsl:text>Ionization energy: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:LandeFactor">
        <p>
            <xsl:text>Lande factor: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:QuantumDefect">
        <p>
            <xsl:text>Quantum defect: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:Lifetime">
        <p>
            <xsl:text>Lifetime: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:Polarizability">
        <p>
            <xsl:text>Polarizability: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:StatisticalWeight">
        <p>
            <xsl:text>Statistical weight: </xsl:text>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:HyperfineConstantA">
        <p>
            <xsl:text>Hyperfine constant A: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:HyperfineConstantB">
        <p>
            <xsl:text>Hyperfine constant B: </xsl:text>
            <xsl:call-template name="quantity-with-unit">
                <xsl:with-param name="quantity" select="."/>
            </xsl:call-template>
        </p>
    </xsl:template>
    
  <xsl:template match="xsams:AtomicQuantumNumbers">
    <p>
      <xsl:text>Quantum numbers for entire state: </xsl:text>
      <xsl:for-each select="xsams:TotalAngularMomentum"><i>J</i><xsl:text> = </xsl:text><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:Kappa"><i>&#954;</i><xsl:text> = </xsl:text><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:Parity"><xsl:text>parity = </xsl:text><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:HyperfineMomentum"><i>F</i><xsl:text> = </xsl:text><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:MagneticQuantumNumber"><i>m</i><xsl:text> = </xsl:text><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
    </p>  
  </xsl:template>
  
    
  <xsl:template match="xsams:AtomicComposition/xsams:Component">
    <p>
      <xsl:text>Electronic composition: </xsl:text>
      <xsl:for-each select="xsams:Configuration/xsams:ConfigurationLabel"><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:Configuration/xsams:AtomicCore/xsams:ElementCore"><xsl:text>[</xsl:text><xsl:value-of select="."/><xsl:text>] </xsl:text></xsl:for-each>
      <xsl:for-each select="xsams:Configuration/xsams:Shells/xsams:Shell">
        <xsl:value-of select="xsams:PrincipalQuantumNumber"/>
        <xsl:choose>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=0"><xsl:text>s</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=1"><xsl:text>p</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=2"><xsl:text>d</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=3"><xsl:text>f</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=4"><xsl:text>g</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=5"><xsl:text>h</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=6"><xsl:text>i</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=7"><xsl:text>k</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=8"><xsl:text>l</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=9"><xsl:text>m</xsl:text></xsl:when>
          <xsl:when test="xsams:OrbitalAngularMomentum/xsams:Value=10"><xsl:text>n</xsl:text></xsl:when>
        </xsl:choose>
        <sup><xsl:value-of select="xsams:NumberOfElectrons"/></sup>
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </p>
    <p>
      <xsl:text>Coupling term:</xsl:text>
      <xsl:for-each select="xsams:Term/xsams:LS">
        <xsl:text> </xsl:text><i>LS</i><xsl:text>: </xsl:text>
        <sup><xsl:value-of select="(xsams:S*2)+1"/></sup>
        <xsl:choose>
          <xsl:when test="xsams:L/xsams:Value=0"><xsl:text>S</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=1"><xsl:text>P</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=2"><xsl:text>D</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=3"><xsl:text>F</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=4"><xsl:text>G</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=5"><xsl:text>H</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=6"><xsl:text>I</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=7"><xsl:text>K</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=8"><xsl:text>L</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=9"><xsl:text>M</xsl:text></xsl:when>
          <xsl:when test="xsams:L/xsams:Value=10"><xsl:text>N</xsl:text></xsl:when>
        </xsl:choose>
        <xsl:if test="../../../../xsams:AtomicQuantumNumbers/xsams:Parity='odd'">
          <xsl:text>&#176;</xsl:text>
        </xsl:if>
        <sub><xsl:value-of select="../../../../xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum"/></sub>
      </xsl:for-each>
      <xsl:for-each select="xsams:Term/xsams:jj">
        <xsl:text> </xsl:text><i>jj</i><xsl:text>: </xsl:text>
        <xsl:text>(</xsl:text>
        <xsl:for-each select="xsams:j">
          <xsl:value-of select="."/>
          <xsl:if test="not(position()=last())">
            <xsl:text>,</xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
        <xsl:if test="../../../../xsams:AtomicQuantumNumbers/xsams:Parity='odd'">
          <xsl:text>&#176;</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="xsams:Term/xsams:J1J2">
        <i><xsl:text> J</xsl:text><sub>1</sub><xsl:text>J</xsl:text><sub>2</sub></i><xsl:text>: </xsl:text>
        <xsl:text>(</xsl:text>
        <xsl:for-each select="xsams:j">
          <xsl:value-of select="."/>
          <xsl:if test="not(position()=last())">
            <xsl:text>,</xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
        <xsl:if test="../../../../xsams:AtomicQuantumNumbers/xsams:Parity='odd'">
          <xsl:text>&#176;</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="xsams:Term/xsams:jK">
        <i><xsl:text> jK</xsl:text></i><xsl:text>: </xsl:text>
        <sup><xsl:value-of select="(2*xsams:S2)+1"/></sup>
        <xsl:text>[</xsl:text><xsl:value-of select="xsams:K"/><xsl:text>]</xsl:text>
        <xsl:if test="../../../../xsams:AtomicQuantumNumbers/xsams:Parity='odd'">
          <xsl:text>&#176;</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="xsams:Term/xsams:LK">
        <i><xsl:text> LK</xsl:text></i><xsl:text>: </xsl:text>
        <sup><xsl:value-of select="(2*xsams:S2)+1"/></sup>
        <xsl:text>[</xsl:text><xsl:value-of select="xsams:K"/><xsl:text>]</xsl:text>
        <xsl:if test="../../../../xsams:AtomicQuantumNumbers/xsams:Parity='odd'">
          <xsl:text>&#176;</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </p>
  </xsl:template>
    
    <xsl:template match="xsams:TotalStatisticalWeight">
        <p>
            <xsl:text>Total statistical weight: </xsl:text>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:NuclearStatisticalWeight">
        <p>
            <xsl:text>Nuclear statistical weight: </xsl:text>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="xsams:NuclearSpinIsomer">
        <p>
            <xsl:text>Nuclear-spin isomer: </xsl:text>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
  <!-- These templates write the enclosing paragraph and legend for the case descriptions.
       The actual QNs are written out by templates in cbc.xsl. -->
  <xsl:template match="xsams:Case[@caseID='nltcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/nltcs-1.0.html">closed-shell, non-linear, triatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='ltcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/ltcs-1.0.html">closed-shell, linear, triatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='dcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/dcs-1.0.html">closed-shell, diatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='hunda']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/hunda-1.0.html">open-shell, Hund's case (a) molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='hundb']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/hundb-1.0.html">open-shell, Hund's case (b) molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
    
  <xsl:template match="xsams:Case[@caseID='stcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/stcs-1.0.html">closed-shell, symmetric top molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
    
  <xsl:template match="xsams:Case[@caseID='lpcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/lpcs-1.0.html">closed-shell, linear, polyatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
    
  <xsl:template match="xsams:Case[@caseID='asymcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/asymcs-1.0.html">closed-shell, asymmetric-top molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='asymos']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/asymos-1.0.html">open-shell, symmetric-top molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='sphcs']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/sphcs-1.0.html">closed-shell, spherical-top molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='sphos']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/sphos-1.0.html">open-shell, spherical-top molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='ltos']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/ltos-1.0.html">open-shell, linear, triatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='lpos']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/lpos-1.0.html">open-shell, linear, polyatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="xsams:Case[@caseID='nltos']">
    <p>
      <xsl:text>Quantum description of state as </xsl:text>
      <a href="http://www.vamdc.eu/documents/cbc-1.0/lpos-1.0.html">open-shell, non-linear, triatomic molecule</a>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
    
  <xsl:template match="xsams:PartitionFunction">
    <p>
      <xsl:text>Partitionfunction: &#xa;</xsl:text>
      <xsl:text>T: </xsl:text>
      <xsl:value-of select="xsams:T/xsams:DataList"/>
      <xsl:text>&#xa;Q: </xsl:text>
      <xsl:value-of select="xsams:Q/xsams:DataList"/>
      <xsl:text>&#xa;</xsl:text>
    </p>
  </xsl:template>
    
    
    <xsl:template name="quantity-with-unit">
        <xsl:param name="quantity"/>
        <xsl:value-of select="xsams:Value"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="xsams:Value/@units"/>
    </xsl:template>
    
    <xsl:template match="@*|text()"/>
    
</xsl:stylesheet>
