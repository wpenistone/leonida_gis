<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="singleSymbol" symbollevels="0" forceraster="0" enableorderby="0">
    <symbols>
      <symbol type="line" name="0" alpha="0.75" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="line_color" value="177,113,88,255"/>
            <Option type="QString" name="line_width" value="0.26"/>
            <Option type="QString" name="line_width_unit" value="MM"/>
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="joinstyle" value="round"/>
          </Option>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontFamily="Segoe UI" fontSize="7.5" fontItalic="0" fontBold="1" textColor="130,85,60,255" fieldName="format_number(&quot;elevation_m&quot;, 1) || ' m'" isExpression="1">
        <text-buffer bufferSize="0.75" bufferColor="255,255,255,230" bufferDraw="1" bufferOpacity="0.9"/>
      </text-style>
      <placement placement="2" priority="5" dist="0.0" linePlacementFlags="2" repeatDistance="120" repeatDistanceUnits="MM"/>
      <rendering scaleVisibility="1" scaleMin="0" scaleMax="1000" obstacle="0"/>
    </settings>
  </labeling>
</qgis>
