<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="singleSymbol" symbollevels="0" forceraster="0" enableorderby="0">
    <symbols>
      <symbol type="fill" name="0" alpha="0.3" clip_to_extent="1" force_rhr="0">
        <layer pass="0" class="SimpleFill" locked="0">
          <Option type="Map">
            <Option type="QString" name="border_width_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="color" value="100,165,215,255"/>
            <Option type="QString" name="joinstyle" value="bevel"/>
            <Option type="QString" name="offset" value="0,0"/>
            <Option type="QString" name="outline_color" value="60,110,160,255"/>
            <Option type="QString" name="outline_style" value="dash"/>
            <Option type="QString" name="outline_width" value="0.5"/>
            <Option type="QString" name="outline_width_unit" value="MM"/>
            <Option type="QString" name="style" value="solid"/>
          </Option>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontFamily="Segoe UI" fontSize="9" fontItalic="1" fontBold="1" textColor="40,80,120,255">
        <text-buffer bufferSize="1.2" bufferColor="255,255,255,220" bufferDraw="1"/>
      </text-style>
      <placement placement="0" priority="4" dist="0"/>
    </settings>
  </labeling>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="Range"><config><Option type="Map"><Option type="bool" name="AllowNull" value="false"/><Option type="int" name="Max" value="2147483647"/><Option type="int" name="Min" value="1"/><Option type="int" name="Step" value="1"/></Option></config></editWidget>
    </field>
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="natural" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Water Body (water)" value="water"/></Option>
              <Option type="Map"><Option type="QString" name="Coastline / Bay (bay)" value="bay"/></Option>
              <Option type="Map"><Option type="QString" name="Wetland" value="wetland"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="water" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Lake" value="lake"/></Option>
              <Option type="Map"><Option type="QString" name="Pond" value="pond"/></Option>
              <Option type="Map"><Option type="QString" name="River" value="river"/></Option>
              <Option type="Map"><Option type="QString" name="Canal" value="canal"/></Option>
              <Option type="Map"><Option type="QString" name="Sea" value="sea"/></Option>
              <Option type="Map"><Option type="QString" name="Lagoon" value="lagoon"/></Option>
              <Option type="Map"><Option type="QString" name="Reservoir" value="reservoir"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tidal" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="No" value="no"/></Option>
              <Option type="Map"><Option type="QString" name="Yes" value="yes"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layer" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="-1 (Subsurface)" value="-1"/></Option>
              <Option type="Map"><Option type="QString" name="0 (Surface)" value="0"/></Option>
              <Option type="Map"><Option type="QString" name="1 (Elevated)" value="1"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name="ID"/>
    <alias field="name" index="1" name="Name"/>
    <alias field="natural" index="2" name="Natural"/>
    <alias field="water" index="3" name="Water"/>
    <alias field="tidal" index="4" name="Tidal"/>
    <alias field="layer" index="5" name="Layer"/>
  </aliases>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="id" editable="1"/>
    <field name="name" editable="1"/>
    <field name="natural" editable="1"/>
    <field name="water" editable="1"/>
    <field name="tidal" editable="1"/>
  </editable>
</qgis>
