<?xml version="1.0" ?>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="RuleRenderer" symbollevels="0" forceraster="0" enableorderby="0">
    <rules key="{areas_root_rule}">
      <rule key="{area_rule_0}" symbol="0" label="Water" filter="&quot;natural&quot; = 'water' OR &quot;water&quot; = 'lake' OR &quot;water&quot; = 'pond' OR &quot;water&quot; = 'reservoir' OR &quot;landuse&quot; = 'reservoir' OR &quot;landuse&quot; = 'basin'"/>
      <rule key="{area_rule_1}" symbol="1" label="Wetland / Marsh" filter="&quot;natural&quot; = 'wetland'"/>
      <rule key="{area_rule_2}" symbol="2" label="Beach / Sand" filter="&quot;natural&quot; = 'beach' OR &quot;natural&quot; = 'sand'"/>
      <rule key="{area_rule_3}" symbol="3" label="Bare Rock / Scree" filter="&quot;natural&quot; = 'bare_rock' OR &quot;natural&quot; = 'scree'"/>
      <rule key="{area_rule_4}" symbol="4" label="Forest / Wood" filter="&quot;landuse&quot; = 'forest' OR &quot;natural&quot; = 'wood'"/>
      <rule key="{area_rule_5}" symbol="5" label="Scrub / Bush" filter="&quot;natural&quot; = 'scrub'"/>
      <rule key="{area_rule_6}" symbol="6" label="Heathland" filter="&quot;natural&quot; = 'heath'"/>
      <rule key="{area_rule_7}" symbol="7" label="Grassland / Grass / Meadow" filter="&quot;landuse&quot; = 'grass' OR &quot;landuse&quot; = 'meadow' OR &quot;natural&quot; = 'grassland'"/>
      <rule key="{area_rule_8}" symbol="8" label="Farmland / Cropland" filter="&quot;landuse&quot; = 'farmland' OR &quot;landuse&quot; = 'farm' OR &quot;landuse&quot; = 'orchard' OR &quot;landuse&quot; = 'vineyard'"/>
      <rule key="{area_rule_9}" symbol="9" label="Farmyard" filter="&quot;landuse&quot; = 'farmyard'"/>
      <rule key="{area_rule_10}" symbol="10" label="Park / Recreation Ground" filter="&quot;leisure&quot; = 'park' OR &quot;landuse&quot; = 'recreation_ground' OR &quot;landuse&quot; = 'village_green'"/>
      <rule key="{area_rule_11}" symbol="11" label="Garden" filter="&quot;leisure&quot; = 'garden'"/>
      <rule key="{area_rule_12}" symbol="12" label="Golf Course" filter="&quot;leisure&quot; = 'golf_course'"/>
      <rule key="{area_rule_13}" symbol="13" label="Sports Pitch / Track" filter="&quot;leisure&quot; = 'pitch' OR &quot;leisure&quot; = 'track'"/>
      <rule key="{area_rule_14}" symbol="14" label="Sports Centre / Stadium" filter="&quot;leisure&quot; = 'sports_centre' OR &quot;leisure&quot; = 'stadium'"/>
      <rule key="{area_rule_15}" symbol="15" label="Marina" filter="&quot;leisure&quot; = 'marina'"/>
      <rule key="{area_rule_16}" symbol="16" label="Nature Reserve / Protected Area" filter="&quot;leisure&quot; = 'nature_reserve' OR &quot;boundary&quot; = 'protected_area' OR &quot;boundary&quot; = 'national_park'"/>
      <rule key="{area_rule_17}" symbol="17" label="Residential Area" filter="&quot;landuse&quot; = 'residential'"/>
      <rule key="{area_rule_18}" symbol="18" label="Commercial / Retail Area" filter="&quot;landuse&quot; = 'commercial' OR &quot;landuse&quot; = 'retail'"/>
      <rule key="{area_rule_19}" symbol="19" label="Industrial Area" filter="&quot;landuse&quot; = 'industrial' OR &quot;landuse&quot; = 'railway'"/>
      <rule key="{area_rule_20}" symbol="20" label="Construction Site" filter="&quot;landuse&quot; = 'construction'"/>
      <rule key="{area_rule_21}" symbol="21" label="Quarry / Landfill" filter="&quot;landuse&quot; = 'quarry' OR &quot;landuse&quot; = 'landfill'"/>
      <rule key="{area_rule_22}" symbol="22" label="Cemetery" filter="&quot;landuse&quot; = 'cemetery' OR &quot;amenity&quot; = 'grave_yard'"/>
      <rule key="{area_rule_23}" symbol="23" label="Parking Area" filter="&quot;amenity&quot; = 'parking' OR &quot;parking&quot; = 'surface'"/>
      <rule key="{area_rule_24}" symbol="24" label="School / University Campus" filter="&quot;amenity&quot; = 'school' OR &quot;amenity&quot; = 'college' OR &quot;amenity&quot; = 'university'"/>
      <rule key="{area_rule_25}" symbol="25" label="Hospital / Healthcare" filter="&quot;amenity&quot; = 'hospital' OR &quot;amenity&quot; = 'clinic'"/>
      <rule key="{area_rule_26}" symbol="26" label="Prison / Correctional Facility" filter="&quot;amenity&quot; = 'prison'"/>
      <rule key="{area_rule_27}" symbol="27" label="Place of Worship" filter="&quot;amenity&quot; = 'place_of_worship'"/>
      <rule key="{area_rule_28}" symbol="28" label="Aerodrome / Airport Perimeter" filter="&quot;aeroway&quot; = 'aerodrome'"/>
      <rule key="{area_rule_29}" symbol="29" label="Airport Apron" filter="&quot;aeroway&quot; = 'apron'"/>
      <rule key="{area_rule_30}" symbol="30" label="Runway / Taxiway Surface" filter="&quot;aeroway&quot; = 'runway' OR &quot;aeroway&quot; = 'taxiway'"/>
      <rule key="{area_rule_31}" symbol="31" label="Airport Terminal" filter="&quot;aeroway&quot; = 'terminal' OR (&quot;building&quot; = 'terminal')"/>
      <rule key="{area_rule_32}" symbol="32" label="Helipad" filter="&quot;aeroway&quot; = 'helipad'"/>
      <rule key="{area_rule_33}" symbol="33" label="Military Zone / Base" filter="&quot;landuse&quot; = 'military' OR &quot;military&quot; IS NOT NULL"/>
      <rule key="{area_rule_34}" symbol="34" label="Building Footprint" filter="&quot;building&quot; IS NOT NULL AND &quot;building&quot; != 'no'"/>
      <rule key="{area_rule_35}" symbol="35" label="Other Area"/>
    </rules>
    <symbols>
      <symbol type="fill" name="0" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="170,211,223,255"/>
          <prop k="outline_color" v="154,195,207,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="1" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="181,208,208,255"/>
          <prop k="outline_color" v="165,192,192,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="2" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="255,241,186,255"/>
          <prop k="outline_color" v="239,225,170,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="3" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="222,222,222,255"/>
          <prop k="outline_color" v="206,206,206,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="4" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="173,209,158,255"/>
          <prop k="outline_color" v="157,193,142,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="5" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="181,227,181,255"/>
          <prop k="outline_color" v="165,211,165,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="6" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="214,217,159,255"/>
          <prop k="outline_color" v="198,201,143,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="7" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="205,235,176,255"/>
          <prop k="outline_color" v="189,219,160,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="8" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="238,240,213,255"/>
          <prop k="outline_color" v="222,223,197,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="9" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="237,212,194,255"/>
          <prop k="outline_color" v="221,196,178,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="10" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="200,250,204,255"/>
          <prop k="outline_color" v="168,218,172,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="11" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="207,236,168,255"/>
          <prop k="outline_color" v="191,220,152,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="12" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="181,227,181,255"/>
          <prop k="outline_color" v="165,211,165,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="13" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="138,211,166,255"/>
          <prop k="outline_color" v="122,195,150,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="14" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="51,204,153,255"/>
          <prop k="outline_color" v="35,188,137,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="15" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="181,214,230,255"/>
          <prop k="outline_color" v="165,198,214,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="16" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="171,222,150,60"/>
          <prop k="outline_color" v="155,206,134,255"/>
          <prop k="outline_width" v="0.6"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="dash"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="17" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="223,209,198,255"/>
          <prop k="outline_color" v="207,193,182,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="18" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="255,208,203,255"/>
          <prop k="outline_color" v="240,184,178,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="19" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="223,209,214,255"/>
          <prop k="outline_color" v="207,193,198,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="20" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="199,199,180,255"/>
          <prop k="outline_color" v="183,183,164,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="dash"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="21" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="196,194,194,255"/>
          <prop k="outline_color" v="180,178,178,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="22" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="170,203,175,255"/>
          <prop k="outline_color" v="154,187,159,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="23" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="247,235,210,255"/>
          <prop k="outline_color" v="208,196,171,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="24" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="240,240,216,255"/>
          <prop k="outline_color" v="223,223,200,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="25" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="255,218,216,255"/>
          <prop k="outline_color" v="239,202,204,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="26" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="234,224,208,255"/>
          <prop k="outline_color" v="218,208,192,255"/>
          <prop k="outline_width" v="0.4"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="27" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="205,200,184,255"/>
          <prop k="outline_color" v="189,184,168,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="28" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="233,231,226,255"/>
          <prop k="outline_color" v="217,215,210,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="29" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="218,218,224,255"/>
          <prop k="outline_color" v="202,202,207,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="30" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="187,187,187,255"/>
          <prop k="outline_color" v="170,170,170,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="31" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="204,153,255,255"/>
          <prop k="outline_color" v="188,137,239,255"/>
          <prop k="outline_width" v="0.4"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="32" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="233,231,226,255"/>
          <prop k="outline_color" v="187,187,187,255"/>
          <prop k="outline_width" v="0.3"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="33" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="245,213,213,200"/>
          <prop k="outline_color" v="220,42,103,255"/>
          <prop k="outline_width" v="0.5"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="dash"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="34" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="217,208,201,255"/>
          <prop k="outline_color" v="188,169,160,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
      <symbol type="fill" name="35" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleFill" locked="0">
          <prop k="color" v="224,224,224,180"/>
          <prop k="outline_color" v="192,192,192,255"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="outline_style" v="solid"/>
          <prop k="style" v="solid"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings fieldName="name">
      <text-style fontFamily="Segoe UI" fontSize="8" fontSizeUnit="Point" textColor="80,80,80,255" isExpression="0">
        <text-buffer bufferDraw="1" bufferSize="1.0" bufferColor="255,255,255,230"/>
      </text-style>
      <placement placement="0" priority="5" dist="0" centroidWhole="1"/>
      <rendering scaleVisibility="1" scaleMin="1" scaleMax="40000" obstacle="0"/>
    </settings>
  </labeling>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="Range"><config><Option type="Map"><Option type="bool" name="AllowNull" value="false"/><Option type="int" name="Max" value="2147483647"/><Option type="int" name="Min" value="1"/><Option type="int" name="Step" value="1"/></Option></config></editWidget>
    </field>
    <field name="ref_id" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit"><config><Option type="Map"><Option type="bool" name="IsMultiline" value="false"/><Option type="bool" name="UseHtml" value="false"/></Option></config></editWidget>
    </field>
    <field name="landuse" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None / Unset" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Commercial" value="commercial"/></Option>
              <Option type="Map"><Option type="QString" name="Residential" value="residential"/></Option>
              <Option type="Map"><Option type="QString" name="Industrial" value="industrial"/></Option>
              <Option type="Map"><Option type="QString" name="Retail" value="retail"/></Option>
              <Option type="Map"><Option type="QString" name="Harbour / Port" value="harbour"/></Option>
              <Option type="Map"><Option type="QString" name="Military" value="military"/></Option>
              <Option type="Map"><Option type="QString" name="Forest / Woods" value="forest"/></Option>
              <Option type="Map"><Option type="QString" name="Grass / Meadow" value="grass"/></Option>
              <Option type="Map"><Option type="QString" name="Farmland / Agricultural" value="farmland"/></Option>
              <Option type="Map"><Option type="QString" name="Cemetery" value="cemetery"/></Option>
              <Option type="Map"><Option type="QString" name="Construction" value="construction"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="leisure" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None / Unset" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Park" value="park"/></Option>
              <Option type="Map"><Option type="QString" name="Golf Course" value="golf_course"/></Option>
              <Option type="Map"><Option type="QString" name="Pitch / Sports Field" value="pitch"/></Option>
              <Option type="Map"><Option type="QString" name="Stadium" value="stadium"/></Option>
              <Option type="Map"><Option type="QString" name="Marina" value="marina"/></Option>
              <Option type="Map"><Option type="QString" name="Nature Reserve" value="nature_reserve"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="aeroway" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None / Unset" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Aerodrome / Airport" value="aerodrome"/></Option>
              <Option type="Map"><Option type="QString" name="Helipad" value="helipad"/></Option>
              <Option type="Map"><Option type="QString" name="Terminal" value="terminal"/></Option>
              <Option type="Map"><Option type="QString" name="Apron" value="apron"/></Option>
              <Option type="Map"><Option type="QString" name="Runway" value="runway"/></Option>
              <Option type="Map"><Option type="QString" name="Taxiway" value="taxiway"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="amenity" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None / Unset" value=""/></Option>
              <Option type="Map"><Option type="QString" name="University / College" value="university"/></Option>
              <Option type="Map"><Option type="QString" name="School" value="school"/></Option>
              <Option type="Map"><Option type="QString" name="Hospital" value="hospital"/></Option>
              <Option type="Map"><Option type="QString" name="Parking" value="parking"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name="Feature ID"/>
    <alias field="ref_id" index="1" name="Area Ref ID (e.g. A_0001)"/>
    <alias field="name" index="2" name="Area / Facility Name"/>
    <alias field="landuse" index="3" name="Landuse Zoning"/>
    <alias field="leisure" index="4" name="Leisure / Recreation"/>
    <alias field="aeroway" index="5" name="Aviation / Aeroway"/>
    <alias field="amenity" index="6" name="Civic Amenity"/>
  </aliases>
  <defaults>
    <default field="id" expression="coalesce(maximum(&quot;id&quot;) + 1, count(1) + 1)" applyOnUpdate="0"/>
    <default field="ref_id" expression="'A_' || lpad(coalesce(maximum(to_int(replace(&quot;ref_id&quot;, 'A_', ''))) + 1, count(1) + 1), 4, '0')" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="landuse" expression="" applyOnUpdate="0"/>
    <default field="leisure" expression="" applyOnUpdate="0"/>
    <default field="aeroway" expression="" applyOnUpdate="0"/>
    <default field="amenity" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="ref_id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="name" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="landuse" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="leisure" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="aeroway" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="amenity" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
  </constraints>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="id" editable="1"/>
    <field name="ref_id" editable="1"/>
    <field name="name" editable="1"/>
    <field name="landuse" editable="1"/>
    <field name="leisure" editable="1"/>
    <field name="aeroway" editable="1"/>
    <field name="amenity" editable="1"/>
  </editable>
</qgis>