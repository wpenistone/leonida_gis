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
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="Range"><config><Option type="Map"><Option type="bool" name="AllowNull" value="false"/><Option type="int" name="Max" value="2147483647"/><Option type="int" name="Min" value="1"/><Option type="int" name="Step" value="1"/></Option></config></editWidget>
    </field>
    <field name="type" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="restriction" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="No Left Turn (no_left_turn)" value="no_left_turn"/></Option>
              <Option type="Map"><Option type="QString" name="No Right Turn (no_right_turn)" value="no_right_turn"/></Option>
              <Option type="Map"><Option type="QString" name="No U-Turn (no_u_turn)" value="no_u_turn"/></Option>
              <Option type="Map"><Option type="QString" name="No Straight On (no_straight_on)" value="no_straight_on"/></Option>
              <Option type="Map"><Option type="QString" name="Only Straight On (only_straight_on)" value="only_straight_on"/></Option>
              <Option type="Map"><Option type="QString" name="Only Left Turn (only_left_turn)" value="only_left_turn"/></Option>
              <Option type="Map"><Option type="QString" name="Only Right Turn (only_right_turn)" value="only_right_turn"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="from_way" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="to_way" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name="Feature ID"/>
    <alias field="type" index="1" name="Relation Type (restriction)"/>
    <alias field="restriction" index="2" name="Turn Restriction Type"/>
    <alias field="from_way" index="3" name="Incoming Road Ref ID (e.g. R_0012)"/>
    <alias field="to_way" index="4" name="Target Road Ref ID (e.g. R_0015)"/>
  </aliases>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="id" editable="1"/>
    <field name="type" editable="1"/>
    <field name="restriction" editable="1"/>
    <field name="from_way" editable="1"/>
    <field name="to_way" editable="1"/>
  </editable>
</qgis>
