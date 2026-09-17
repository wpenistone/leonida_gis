<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <pipe-data>
    <rasterrenderer type="singlebandpseudocolor" opacity="1" alphaBand="-1" band="1" classificationMin="0" classificationMax="65358">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Exact</statAccuracy>
        <cumulativeCutLower>0.0</cumulativeCutLower>
        <cumulativeCutUpper>1.0</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader colorRampType="INTERPOLATED" clip="0" classificationMode="2" minimumValue="0" maximumValue="65358" labelPrecision="1">
          <colorramptype>INTERPOLATED</colorramptype>
          <item value="0" color="#030b1e" alpha="255" label="Abyss (&lt; -600m)"/>
          <item value="12000" color="#0a2040" alpha="255" label="Deep Ocean Trench (-345m)"/>
          <item value="18000" color="#113661" alpha="255" label="Ocean Basin (-218m)"/>
          <item value="22000" color="#184e84" alpha="255" label="Lower Shelf Slope (-132m)"/>
          <item value="25000" color="#2269a8" alpha="255" label="Continental Shelf (-68m)"/>
          <item value="27000" color="#3187c8" alpha="255" label="Coastal Shelf (-25m)"/>
          <item value="28000" color="#4baae0" alpha="255" label="Shallow Shoals (-3.2m)"/>
          <item value="28140" color="#85d5f4" alpha="255" label="Nearshore Surf (-0.2m)"/>
          <item value="28150" color="#e8dc9b" alpha="255" label="Coastline / Sea Level (0.0m)"/>
          <item value="28193" color="#aed581" alpha="255" label="Coastal Plains &amp; Dunes (0.9m | Q5%)"/>
          <item value="28285" color="#8bc34a" alpha="255" label="Lowland Flats (2.9m | Q20%)"/>
          <item value="28386" color="#689f38" alpha="255" label="Floodplains &amp; Meadows (5.1m | Q30%)"/>
          <item value="28499" color="#4c8c2b" alpha="255" label="Riparian Terraces (7.5m | Q40%)"/>
          <item value="28779" color="#558b2f" alpha="255" label="Inland Plains (13.5m | Q50% Median)"/>
          <item value="29406" color="#7cb342" alpha="255" label="Undulating Savanna (27.0m | Q60%)"/>
          <item value="30104" color="#c0ca33" alpha="255" label="Warm Low Hills (42.0m | Q70%)"/>
          <item value="30615" color="#dce775" alpha="255" label="Foothill Slopes (53.0m | Q75%)"/>
          <item value="31343" color="#ffd54f" alpha="255" label="Highland Benches (68.7m | Q80%)"/>
          <item value="32347" color="#ffb74d" alpha="255" label="Plateau Terraces (90.2m | Q85%)"/>
          <item value="34051" color="#ff8a65" alpha="255" label="Mountain Escarpments (126.9m | Q90%)"/>
          <item value="38840" color="#d84315" alpha="255" label="Upper Escarpment (229.8m | Q95%)"/>
          <item value="42000" color="#a0320d" alpha="255" label="Subalpine Ridges (298.0m)"/>
          <item value="48000" color="#795548" alpha="255" label="Montane Crags (427.0m)"/>
          <item value="54000" color="#5d4037" alpha="255" label="Alpine Cliffs (556.0m)"/>
          <item value="60000" color="#78909c" alpha="255" label="Summit Rock &amp; Scree (685.0m)"/>
          <item value="65358" color="#f5f5f5" alpha="255" label="Mount Kalaga Summit (800.0m)"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation colorizeOn="0" colorizeRed="255" colorizeGreen="128" colorizeBlue="0" grayscaleMode="0" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe-data>
  <blendMode>0</blendMode>
</qgis>
