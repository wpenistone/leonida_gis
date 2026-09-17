<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="categorizedSymbol" attr="restriction" symbollevels="0" forceraster="0" enableorderby="0">
    <categories>
      <category symbol="0" value="no_left_turn" label="No Left Turn" render="true"/>
      <category symbol="1" value="no_right_turn" label="No Right Turn" render="true"/>
      <category symbol="2" value="no_u_turn" label="No U-Turn" render="true"/>
      <category symbol="3" value="only_straight_on" label="Straight On Only" render="true"/>
    </categories>
    <symbols>
      <symbol type="marker" name="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" name="color" value="230,30,30,255"/>
            <Option type="QString" name="name" value="circle"/>
            <Option type="QString" name="outline_color" value="255,255,255,255"/>
            <Option type="QString" name="outline_width" value="0.6"/>
            <Option type="QString" name="size" value="4.5"/>
            <Option type="QString" name="size_unit" value="MM"/>
          </Option>
        </layer>
        <layer pass="1" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" name="color" value="255,255,255,255"/>
            <Option type="QString" name="name" value="cross"/>
            <Option type="QString" name="outline_color" value="255,255,255,255"/>
            <Option type="QString" name="outline_width" value="0.7"/>
            <Option type="QString" name="size" value="2.5"/>
            <Option type="QString" name="size_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
      <symbol type="marker" name="1" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" name="color" value="230,30,30,255"/>
            <Option type="QString" name="name" value="circle"/>
            <Option type="QString" name="outline_color" value="255,255,255,255"/>
            <Option type="QString" name="outline_width" value="0.6"/>
            <Option type="QString" name="size" value="4.5"/>
            <Option type="QString" name="size_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
      <symbol type="marker" name="2" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" name="color" value="200,20,20,255"/>
            <Option type="QString" name="name" value="circle"/>
            <Option type="QString" name="outline_color" value="255,255,255,255"/>
            <Option type="QString" name="outline_width" value="0.6"/>
            <Option type="QString" name="size" value="4.5"/>
            <Option type="QString" name="size_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
      <symbol type="marker" name="3" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" name="color" value="30,140,240,255"/>
            <Option type="QString" name="name" value="circle"/>
            <Option type="QString" name="outline_color" value="255,255,255,255"/>
            <Option type="QString" name="outline_width" value="0.6"/>
            <Option type="QString" name="size" value="4.5"/>
            <Option type="QString" name="size_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontFamily="Segoe UI" fontSize="7.5" fontItalic="0" fontBold="1" textColor="200,20,20,255">
        <text-buffer bufferSize="0.8" bufferColor="255,255,255,240" bufferDraw="1"/>
      </text-style>
      <placement placement="1" priority="7" dist="1.5"/>
    </settings>
  </labeling>
</qgis>
