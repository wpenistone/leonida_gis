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
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="Range"><config><Option type="Map"><Option type="bool" name="AllowNull" value="false"/><Option type="int" name="Max" value="2147483647"/><Option type="int" name="Min" value="1"/><Option type="int" name="Step" value="1"/></Option></config></editWidget>
    </field>
    <field name="ref_id" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="railway" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Heavy Rail (Main Line / Freight)" value="rail"/></Option>
              <Option type="Map"><Option type="QString" name="Light Rail / Tram" value="light_rail"/></Option>
              <Option type="Map"><Option type="QString" name="Subway / Metro" value="subway"/></Option>
              <Option type="Map"><Option type="QString" name="Monorail" value="monorail"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="service" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Mainline (None)" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Rail Yard (Storage/Switching)" value="yard"/></Option>
              <Option type="Map"><Option type="QString" name="Siding" value="siding"/></Option>
              <Option type="Map"><Option type="QString" name="Industrial Spur" value="spur"/></Option>
              <Option type="Map"><Option type="QString" name="Crossover" value="crossover"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="bridge" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None (At Grade)" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Bridge (yes)" value="yes"/></Option>
              <Option type="Map"><Option type="QString" name="Viaduct" value="viaduct"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tunnel" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None (At Grade)" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Tunnel (yes)" value="yes"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layer" configurationFlags="None">
      <editWidget type="Range"><config><Option type="Map"><Option type="bool" name="AllowNull" value="true"/><Option type="int" name="Max" value="5"/><Option type="int" name="Min" value="-5"/><Option type="int" name="Step" value="1"/></Option></config></editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name="Feature ID"/>
    <alias field="ref_id" index="1" name="Transit Ref ID (e.g. T_0001)"/>
    <alias field="railway" index="2" name="Railway Type"/>
    <alias field="name" index="3" name="Line / Corridor Name"/>
    <alias field="service" index="4" name="Track Service"/>
    <alias field="bridge" index="5" name="Bridge Structure"/>
    <alias field="tunnel" index="6" name="Tunnel Structure"/>
    <alias field="layer" index="7" name="Z-Level Stacking (-1 tunnel, 0 ground, 1 bridge)"/>
  </aliases>
  <defaults>
    <default field="id" expression="coalesce(maximum(&quot;id&quot;) + 1, count(1) + 1)" applyOnUpdate="0"/>
    <default field="ref_id" expression="'T_' || lpad(coalesce(maximum(to_int(replace(&quot;ref_id&quot;, 'T_', ''))) + 1, count(1) + 1), 4, '0')" applyOnUpdate="0"/>
    <default field="railway" expression="" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="service" expression="" applyOnUpdate="0"/>
    <default field="bridge" expression="" applyOnUpdate="0"/>
    <default field="tunnel" expression="" applyOnUpdate="0"/>
    <default field="layer" expression="CASE WHEN &quot;bridge&quot; IN ('yes', 'viaduct') THEN 1 WHEN &quot;tunnel&quot; IN ('yes') THEN -1 ELSE NULL END" applyOnUpdate="1"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="ref_id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="railway" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="name" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="service" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="bridge" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="tunnel" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="layer" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
  </constraints>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="id" editable="1"/>
    <field name="ref_id" editable="1"/>
    <field name="railway" editable="1"/>
    <field name="name" editable="1"/>
    <field name="service" editable="1"/>
    <field name="bridge" editable="1"/>
    <field name="tunnel" editable="1"/>
    <field name="layer" editable="1"/>
  </editable>
</qgis>
