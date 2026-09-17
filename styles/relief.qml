<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <pipe-data>
    <rasterrenderer type="multibandcolor" opacity="0.60" alphaBand="-1" blueBand="3" greenBand="2" redBand="1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>MinMax</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <redContrastEnhancement>
        <minValue>20</minValue>
        <maxValue>250</maxValue>
        <algorithm>StretchToMinimumMaximum</algorithm>
      </redContrastEnhancement>
      <greenContrastEnhancement>
        <minValue>40</minValue>
        <maxValue>250</maxValue>
        <algorithm>StretchToMinimumMaximum</algorithm>
      </greenContrastEnhancement>
      <blueContrastEnhancement>
        <minValue>25</minValue>
        <maxValue>250</maxValue>
        <algorithm>StretchToMinimumMaximum</algorithm>
      </blueContrastEnhancement>
    </rasterrenderer>
    <brightnesscontrast brightness="5" contrast="15" gamma="1.05"/>
    <huesaturation colorizeOn="0" colorizeRed="255" colorizeGreen="128" colorizeBlue="0" grayscaleMode="0" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe-data>
  <blendMode>5</blendMode>
</qgis>
