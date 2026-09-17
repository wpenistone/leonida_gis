<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="RuleRenderer" symbollevels="0" forceraster="0" enableorderby="0">
    <rules key="{waterways_rules}">
      <!-- Forward Flow: Directional Arrow -->
      <rule key="{rule_fwd}" symbol="0" filter="&quot;flow_direction&quot; = 'forward'" label="Flow: Forward (Downstream)"/>
      <!-- Backward Flow: Reverse Arrow -->
      <rule key="{rule_bwd}" symbol="1" filter="&quot;flow_direction&quot; = 'backward'" label="Flow: Backward"/>
      <!-- Reversible / Either Flow: Tidal Canal / Lagoon -->
      <rule key="{rule_either}" symbol="2" filter="&quot;flow_direction&quot; = 'either'" label="Flow: Reversible (Tidal / Either)"/>
      <!-- No Flow (Default): Stagnant Channel / Canal / Pond Link -->
      <rule key="{rule_noflow}" symbol="3" filter="&quot;flow_direction&quot; = 'no' OR &quot;flow_direction&quot; IS NULL" label="Flow: None (Stagnant / No Flow)"/>
    </rules>
    <symbols>
      <symbol type="line" name="0" alpha="0.9" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="line_color" value="2,136,209,255"/>
            <Option type="QString" name="line_width" value="0.75"/>
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="joinstyle" value="round"/>
          </Option>
        </layer>
        <layer pass="1" class="MarkerLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="interval" value="25"/>
            <Option type="QString" name="interval_unit" value="MM"/>
            <Option type="QString" name="placement" value="interval"/>
            <Option type="QString" name="rotate" value="1"/>
          </Option>
          <symbol type="marker" name="@0@1" alpha="0.9" clip_to_extent="1" force_rhr="0">
            <layer pass="0" class="SimpleMarker" locked="0">
              <Option type="Map">
                <Option type="QString" name="color" value="2,80,140,255"/>
                <Option type="QString" name="name" value="arrowhead"/>
                <Option type="QString" name="outline_color" value="255,255,255,255"/>
                <Option type="QString" name="outline_width" value="0.2"/>
                <Option type="QString" name="size" value="2.5"/>
              </Option>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="1" alpha="0.9" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="line_color" value="2,136,209,255"/>
            <Option type="QString" name="line_width" value="0.75"/>
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="joinstyle" value="round"/>
          </Option>
        </layer>
      </symbol>
      <symbol type="line" name="2" alpha="0.85" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="line_color" value="0,172,193,255"/>
            <Option type="QString" name="line_width" value="0.65"/>
            <Option type="QString" name="line_style" value="dash"/>
          </Option>
        </layer>
      </symbol>
      <symbol type="line" name="3" alpha="0.85" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="line_color" value="33,150,243,255"/>
            <Option type="QString" name="line_width" value="0.6"/>
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="joinstyle" value="round"/>
          </Option>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontFamily="Segoe UI" fontSize="7.5" fontItalic="1" fontBold="1" textColor="2,80,140,255">
        <text-buffer bufferSize="0.6" bufferColor="255,255,255,220" bufferDraw="1"/>
      </text-style>
      <placement placement="2" priority="5" dist="0.5" linePlacementFlags="2"/>
      <rendering scaleVisibility="1" scaleMin="1" scaleMax="60000" obstacle="0"/>
    </settings>
  </labeling>
</qgis>
