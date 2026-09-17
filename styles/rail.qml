<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="RuleRenderer" symbollevels="1" forceraster="0" enableorderby="0">
    <rules key="{e1a8b2c3-4d5e-6f7a-8b9c-0d1e2f3a4b5c}">
      <rule key="{11111111-2222-3333-4444-555555555555}" filter="&quot;railway&quot; = 'rail' OR &quot;railway&quot; IS NULL" symbol="0" label="Heavy Rail (Main Line &amp; Yards)"/>
      <rule key="{66666666-7777-8888-9999-000000000000}" filter="&quot;railway&quot; = 'light_rail'" symbol="1" label="Light Rail &amp; Metro Transit"/>
    </rules>
    <symbols>
      <!-- Symbol 0: Heavy Rail (Charcoal casing + dashed white track ties) -->
      <symbol type="line" name="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="line_color" value="45,45,48,255"/>
            <Option type="QString" name="line_style" value="solid"/>
            <Option type="QString" name="line_width" value="0.9"/>
            <Option type="QString" name="line_width_unit" value="MM"/>
          </Option>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="capstyle" value="flat"/>
            <Option type="QString" name="customdash" value="2;2"/>
            <Option type="QString" name="line_color" value="255,255,255,255"/>
            <Option type="QString" name="line_style" value="dash"/>
            <Option type="QString" name="line_width" value="0.5"/>
            <Option type="QString" name="line_width_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
      <!-- Symbol 1: Light Rail / Metro (Crimson transit line) -->
      <symbol type="line" name="1" alpha="1" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleLine" locked="0">
          <Option type="Map">
            <Option type="QString" name="capstyle" value="round"/>
            <Option type="QString" name="line_color" value="196,52,43,255"/>
            <Option type="QString" name="line_style" value="solid"/>
            <Option type="QString" name="line_width" value="0.75"/>
            <Option type="QString" name="line_width_unit" value="MM"/>
          </Option>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
</qgis>
