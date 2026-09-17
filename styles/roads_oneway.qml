<?xml version="1.0" ?>
<qgis version="3.34.0" styleCategories="AllStyleCategories">
  <renderer-v2 type="RuleRenderer" symbollevels="1" forceraster="0">
    <rules key="{osm_carto_roads_root}">
      <rule key="{rule_0}" symbol="0" label="Motorway (Freeway) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_1}" symbol="1" label="Motorway (Freeway) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_2}" symbol="2" label="Motorway (Freeway) [Bridge]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_3}" symbol="3" label="Motorway (Freeway) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_4}" symbol="4" label="Motorway (Freeway) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_5}" symbol="5" label="Motorway (Freeway) [Tunnel]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_6}" symbol="6" label="Motorway (Freeway) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_7}" symbol="7" label="Motorway (Freeway) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_8}" symbol="8" label="Motorway (Freeway)" filter="(&quot;highway&quot; = 'motorway' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_9}" symbol="9" label="Motorway (Freeway) (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_10}" symbol="10" label="Motorway (Freeway) (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_11}" symbol="11" label="Motorway (Freeway) (Link) [Bridge]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_12}" symbol="12" label="Motorway (Freeway) (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_13}" symbol="13" label="Motorway (Freeway) (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_14}" symbol="14" label="Motorway (Freeway) (Link) [Tunnel]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_15}" symbol="15" label="Motorway (Freeway) (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_16}" symbol="16" label="Motorway (Freeway) (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_17}" symbol="17" label="Motorway (Freeway) (Link)" filter="(&quot;highway&quot; = 'motorway_link' OR (&quot;highway&quot; = 'motorway' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_18}" symbol="18" label="Trunk (Expressway) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_19}" symbol="19" label="Trunk (Expressway) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_20}" symbol="20" label="Trunk (Expressway) [Bridge]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_21}" symbol="21" label="Trunk (Expressway) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_22}" symbol="22" label="Trunk (Expressway) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_23}" symbol="23" label="Trunk (Expressway) [Tunnel]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_24}" symbol="24" label="Trunk (Expressway) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_25}" symbol="25" label="Trunk (Expressway) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_26}" symbol="26" label="Trunk (Expressway)" filter="(&quot;highway&quot; = 'trunk' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_27}" symbol="27" label="Trunk (Expressway) (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_28}" symbol="28" label="Trunk (Expressway) (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_29}" symbol="29" label="Trunk (Expressway) (Link) [Bridge]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_30}" symbol="30" label="Trunk (Expressway) (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_31}" symbol="31" label="Trunk (Expressway) (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_32}" symbol="32" label="Trunk (Expressway) (Link) [Tunnel]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_33}" symbol="33" label="Trunk (Expressway) (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_34}" symbol="34" label="Trunk (Expressway) (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_35}" symbol="35" label="Trunk (Expressway) (Link)" filter="(&quot;highway&quot; = 'trunk_link' OR (&quot;highway&quot; = 'trunk' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_36}" symbol="36" label="Primary (Arterial) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_37}" symbol="37" label="Primary (Arterial) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_38}" symbol="38" label="Primary (Arterial) [Bridge]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_39}" symbol="39" label="Primary (Arterial) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_40}" symbol="40" label="Primary (Arterial) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_41}" symbol="41" label="Primary (Arterial) [Tunnel]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_42}" symbol="42" label="Primary (Arterial) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_43}" symbol="43" label="Primary (Arterial) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_44}" symbol="44" label="Primary (Arterial)" filter="(&quot;highway&quot; = 'primary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_45}" symbol="45" label="Primary (Arterial) (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_46}" symbol="46" label="Primary (Arterial) (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_47}" symbol="47" label="Primary (Arterial) (Link) [Bridge]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_48}" symbol="48" label="Primary (Arterial) (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_49}" symbol="49" label="Primary (Arterial) (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_50}" symbol="50" label="Primary (Arterial) (Link) [Tunnel]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_51}" symbol="51" label="Primary (Arterial) (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_52}" symbol="52" label="Primary (Arterial) (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_53}" symbol="53" label="Primary (Arterial) (Link)" filter="(&quot;highway&quot; = 'primary_link' OR (&quot;highway&quot; = 'primary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_54}" symbol="54" label="Secondary (Collector) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_55}" symbol="55" label="Secondary (Collector) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_56}" symbol="56" label="Secondary (Collector) [Bridge]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_57}" symbol="57" label="Secondary (Collector) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_58}" symbol="58" label="Secondary (Collector) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_59}" symbol="59" label="Secondary (Collector) [Tunnel]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_60}" symbol="60" label="Secondary (Collector) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_61}" symbol="61" label="Secondary (Collector) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_62}" symbol="62" label="Secondary (Collector)" filter="(&quot;highway&quot; = 'secondary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_63}" symbol="63" label="Secondary (Collector) (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_64}" symbol="64" label="Secondary (Collector) (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_65}" symbol="65" label="Secondary (Collector) (Link) [Bridge]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_66}" symbol="66" label="Secondary (Collector) (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_67}" symbol="67" label="Secondary (Collector) (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_68}" symbol="68" label="Secondary (Collector) (Link) [Tunnel]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_69}" symbol="69" label="Secondary (Collector) (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_70}" symbol="70" label="Secondary (Collector) (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_71}" symbol="71" label="Secondary (Collector) (Link)" filter="(&quot;highway&quot; = 'secondary_link' OR (&quot;highway&quot; = 'secondary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_72}" symbol="72" label="Tertiary (Sub-Collector) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_73}" symbol="73" label="Tertiary (Sub-Collector) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_74}" symbol="74" label="Tertiary (Sub-Collector) [Bridge]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_75}" symbol="75" label="Tertiary (Sub-Collector) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_76}" symbol="76" label="Tertiary (Sub-Collector) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_77}" symbol="77" label="Tertiary (Sub-Collector) [Tunnel]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_78}" symbol="78" label="Tertiary (Sub-Collector) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_79}" symbol="79" label="Tertiary (Sub-Collector) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_80}" symbol="80" label="Tertiary (Sub-Collector)" filter="(&quot;highway&quot; = 'tertiary' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_81}" symbol="81" label="Tertiary (Sub-Collector) (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_82}" symbol="82" label="Tertiary (Sub-Collector) (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_83}" symbol="83" label="Tertiary (Sub-Collector) (Link) [Bridge]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_84}" symbol="84" label="Tertiary (Sub-Collector) (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_85}" symbol="85" label="Tertiary (Sub-Collector) (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_86}" symbol="86" label="Tertiary (Sub-Collector) (Link) [Tunnel]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_87}" symbol="87" label="Tertiary (Sub-Collector) (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_88}" symbol="88" label="Tertiary (Sub-Collector) (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_89}" symbol="89" label="Tertiary (Sub-Collector) (Link)" filter="(&quot;highway&quot; = 'tertiary_link' OR (&quot;highway&quot; = 'tertiary' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_90}" symbol="90" label="Unclassified Road [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_91}" symbol="91" label="Unclassified Road [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_92}" symbol="92" label="Unclassified Road [Bridge]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_93}" symbol="93" label="Unclassified Road [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_94}" symbol="94" label="Unclassified Road [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_95}" symbol="95" label="Unclassified Road [Tunnel]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_96}" symbol="96" label="Unclassified Road [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_97}" symbol="97" label="Unclassified Road [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_98}" symbol="98" label="Unclassified Road" filter="(&quot;highway&quot; = 'unclassified' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_99}" symbol="99" label="Unclassified Road (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_100}" symbol="100" label="Unclassified Road (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_101}" symbol="101" label="Unclassified Road (Link) [Bridge]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_102}" symbol="102" label="Unclassified Road (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_103}" symbol="103" label="Unclassified Road (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_104}" symbol="104" label="Unclassified Road (Link) [Tunnel]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_105}" symbol="105" label="Unclassified Road (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_106}" symbol="106" label="Unclassified Road (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_107}" symbol="107" label="Unclassified Road (Link)" filter="(&quot;highway&quot; = 'unclassified_link' OR (&quot;highway&quot; = 'unclassified' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_108}" symbol="108" label="Residential Road [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_109}" symbol="109" label="Residential Road [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_110}" symbol="110" label="Residential Road [Bridge]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_111}" symbol="111" label="Residential Road [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_112}" symbol="112" label="Residential Road [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_113}" symbol="113" label="Residential Road [Tunnel]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_114}" symbol="114" label="Residential Road [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_115}" symbol="115" label="Residential Road [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_116}" symbol="116" label="Residential Road" filter="(&quot;highway&quot; = 'residential' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_117}" symbol="117" label="Residential Road (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_118}" symbol="118" label="Residential Road (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_119}" symbol="119" label="Residential Road (Link) [Bridge]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_120}" symbol="120" label="Residential Road (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_121}" symbol="121" label="Residential Road (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_122}" symbol="122" label="Residential Road (Link) [Tunnel]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_123}" symbol="123" label="Residential Road (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_124}" symbol="124" label="Residential Road (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_125}" symbol="125" label="Residential Road (Link)" filter="(&quot;highway&quot; = 'residential_link' OR (&quot;highway&quot; = 'residential' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_126}" symbol="126" label="Living Street [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_127}" symbol="127" label="Living Street [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_128}" symbol="128" label="Living Street [Bridge]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_129}" symbol="129" label="Living Street [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_130}" symbol="130" label="Living Street [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_131}" symbol="131" label="Living Street [Tunnel]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_132}" symbol="132" label="Living Street [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_133}" symbol="133" label="Living Street [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_134}" symbol="134" label="Living Street" filter="(&quot;highway&quot; = 'living_street' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_135}" symbol="135" label="Living Street (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_136}" symbol="136" label="Living Street (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_137}" symbol="137" label="Living Street (Link) [Bridge]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_138}" symbol="138" label="Living Street (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_139}" symbol="139" label="Living Street (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_140}" symbol="140" label="Living Street (Link) [Tunnel]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_141}" symbol="141" label="Living Street (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_142}" symbol="142" label="Living Street (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_143}" symbol="143" label="Living Street (Link)" filter="(&quot;highway&quot; = 'living_street_link' OR (&quot;highway&quot; = 'living_street' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_144}" symbol="144" label="Service Road [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_145}" symbol="145" label="Service Road [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_146}" symbol="146" label="Service Road [Bridge]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_147}" symbol="147" label="Service Road [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_148}" symbol="148" label="Service Road [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_149}" symbol="149" label="Service Road [Tunnel]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_150}" symbol="150" label="Service Road [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_151}" symbol="151" label="Service Road [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_152}" symbol="152" label="Service Road" filter="(&quot;highway&quot; = 'service' AND (&quot;link&quot; IS NULL OR &quot;link&quot; IN ('no', '0', 'false', ''))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_153}" symbol="153" label="Service Road (Link) [Bridge] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_154}" symbol="154" label="Service Road (Link) [Bridge] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_155}" symbol="155" label="Service Road (Link) [Bridge]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IN ('yes', '1', 'true', 1, 'viaduct')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_156}" symbol="156" label="Service Road (Link) [Tunnel] [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_157}" symbol="157" label="Service Road (Link) [Tunnel] [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_158}" symbol="158" label="Service Road (Link) [Tunnel]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;tunnel&quot; IN ('yes', '1', 'true', 1, 'culvert')) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_159}" symbol="159" label="Service Road (Link) [One-Way -&gt;]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_160}" symbol="160" label="Service Road (Link) [One-Way &lt;-]" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_161}" symbol="161" label="Service Road (Link)" filter="(&quot;highway&quot; = 'service_link' OR (&quot;highway&quot; = 'service' AND &quot;link&quot; IN ('yes', '1', 'true'))) AND (&quot;bridge&quot; IS NULL OR &quot;bridge&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;tunnel&quot; IS NULL OR &quot;tunnel&quot; IN ('no', '0', 'false', '', 0)) AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_162}" symbol="162" label="Track / Rural Dirt Path" filter="(&quot;highway&quot; = 'track') AND (&quot;oneway&quot; IS NULL OR &quot;oneway&quot; IN ('no', '0', 'false', '', 0))"/>
      <rule key="{rule_163}" symbol="163" label="Track / Rural Dirt Path [One-Way -&gt;]" filter="(&quot;highway&quot; = 'track') AND (&quot;oneway&quot; IN ('yes', '1', 'true', 1))"/>
      <rule key="{rule_164}" symbol="164" label="Track / Rural Dirt Path [One-Way &lt;-]" filter="(&quot;highway&quot; = 'track') AND (&quot;oneway&quot; IN ('-1', -1))"/>
      <rule key="{rule_165}" symbol="165" label="Pedestrian Street / Walkway" filter="&quot;highway&quot; = 'pedestrian'"/>
      <rule key="{rule_166}" symbol="166" label="Footway / Path / Trail" filter="&quot;highway&quot; IN ('footway', 'path', 'steps')"/>
      <rule key="{rule_167}" symbol="167" label="Cycleway / Bike Path" filter="&quot;highway&quot; = 'cycleway'"/>
      <rule key="{rule_168}" symbol="168" label="Other Road / Path" filter="ELSE"/>
    </rules>
    <symbols>
      <symbol type="line" name="0" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@0@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="1" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@1@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="2" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="3" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@3@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="4" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@4@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="5" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="6" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@6@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="7" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@7@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="8" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="9" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@9@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="10" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@10@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="11" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="12" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@12@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="13" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@13@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="14" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="15" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@15@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="16" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@16@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="17" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="220,42,103,255"/>
          <prop k="line_width" v="1.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="232,146,162,255"/>
          <prop k="line_width" v="1.00"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="18" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@18@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="19" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@19@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="20" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="21" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@21@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="22" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@22@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="23" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="24" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@24@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="25" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@25@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="26" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="27" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@27@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="28" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@28@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="29" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="30" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@30@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="31" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@31@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="32" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="33" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@33@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="34" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@34@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="35" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="200,78,47,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="249,178,156,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="36" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.10"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@36@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="37" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.10"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@37@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="38" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="2.10"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="39" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@39@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="40" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@40@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="41" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="42" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@42@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="43" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@43@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="44" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="1.15"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="45" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@45@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="46" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@46@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="47" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="48" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@48@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="49" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@49@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="50" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="51" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@51@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="52" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@52@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="53" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="160,107,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="252,214,164,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="54" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@54@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="55" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@55@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="56" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="57" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@57@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="58" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@58@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="59" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="60" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@60@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="61" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@61@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="62" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="63" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@63@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="64" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@64@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="65" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="66" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@66@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="67" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@67@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="68" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="69" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@69@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="70" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@70@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="71" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="112,125,5,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="247,250,191,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="72" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@72@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="73" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@73@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="74" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="75" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@75@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="76" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@76@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="77" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="78" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@78@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="79" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@79@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="80" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="81" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@81@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="82" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@82@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="83" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="84" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@84@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="85" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@85@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="86" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="87" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@87@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="88" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@88@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="89" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="143,143,143,255"/>
          <prop k="line_width" v="0.90"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="90" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@90@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="91" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@91@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="92" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="93" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@93@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="94" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@94@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="95" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="96" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@96@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="97" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@97@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="98" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="99" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@99@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="100" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@100@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="101" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="102" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@102@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="103" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@103@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="104" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="105" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@105@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="106" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@106@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="107" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="108" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@108@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="109" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@109@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="110" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="111" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@111@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="112" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@112@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="113" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="114" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@114@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="115" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@115@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="116" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="1.05"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="117" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@117@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="118" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@118@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="119" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.35"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="120" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@120@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="121" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@121@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="122" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="123" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@123@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="124" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@124@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="125" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.85"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.55"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="126" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.45"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@126@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="127" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.45"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@127@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="128" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.45"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="129" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@129@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="130" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@130@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="131" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="132" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@132@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="133" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@133@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="134" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.95"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.60"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="135" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@135@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="136" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@136@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="137" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="138" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@138@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="139" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@139@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="140" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="141" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@141@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="142" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@142@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="143" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="176,176,176,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="237,237,237,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="144" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@144@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="145" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@145@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="146" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.30"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="147" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@147@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="148" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@148@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="149" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="150" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@150@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="151" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@151@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="152" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.80"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.50"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="153" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@153@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="154" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@154@3" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="155" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,0,0,255"/>
          <prop k="line_width" v="1.20"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="miter"/>
        </layer>
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="square"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="156" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@156@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="157" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@157@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="158" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
          <prop k="customdash" v="4;2.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="159" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@159@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="160" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="3" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <symbol type="marker" name="@160@2" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="80,80,80,230"/>
              <prop k="outline_color" v="80,80,80,230"/>
              <prop k="size" v="2.2"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
              <prop k="joinstyle" v="round"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="161" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="207,207,207,255"/>
          <prop k="line_width" v="0.70"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.40"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="capstyle" v="round"/>
          <prop k="joinstyle" v="round"/>
        </layer>
      </symbol>
      <symbol type="line" name="162" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="153,102,0,255"/>
          <prop k="line_width" v="0.5"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="customdash" v="3.5;2.0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="capstyle" v="flat"/>
        </layer>
      </symbol>
      <symbol type="line" name="163" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="153,102,0,255"/>
          <prop k="line_width" v="0.5"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="customdash" v="3.5;2.0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="capstyle" v="flat"/>
        </layer>
        <layer pass="2" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <symbol type="marker" name="@163@1" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="153,102,0,255"/>
              <prop k="outline_color" v="153,102,0,255"/>
              <prop k="size" v="2.0"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="0"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="164" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="153,102,0,255"/>
          <prop k="line_width" v="0.5"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="customdash" v="3.5;2.0"/>
          <prop k="use_custom_dash" v="1"/>
          <prop k="capstyle" v="flat"/>
        </layer>
        <layer pass="2" class="MarkerLine" locked="0">
          <prop k="placement" v="interval"/>
          <prop k="interval" v="20"/>
          <prop k="interval_unit" v="MM"/>
          <prop k="rotate" v="1"/>
          <prop k="offset" v="0"/>
          <prop k="offset_unit" v="MM"/>
          <symbol type="marker" name="@164@1" alpha="1" force_rhr="0" clip_to_extent="1">
            <layer pass="0" class="SimpleMarker" locked="0">
              <prop k="name" v="filled_arrowhead"/>
              <prop k="color" v="153,102,0,255"/>
              <prop k="outline_color" v="153,102,0,255"/>
              <prop k="size" v="2.0"/>
              <prop k="size_unit" v="MM"/>
              <prop k="angle" v="180"/>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="line" name="165" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="177,177,184,255"/>
          <prop k="line_width" v="0.75"/>
          <prop k="line_width_unit" v="MM"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="221,221,232,255"/>
          <prop k="line_width" v="0.5"/>
          <prop k="line_width_unit" v="MM"/>
        </layer>
      </symbol>
      <symbol type="line" name="166" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="250,128,114,255"/>
          <prop k="line_width" v="0.45"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="customdash" v="1.5;1.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
      </symbol>
      <symbol type="line" name="167" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="0,136,204,255"/>
          <prop k="line_width" v="0.45"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="customdash" v="2.0;1.5"/>
          <prop k="use_custom_dash" v="1"/>
        </layer>
      </symbol>
      <symbol type="line" name="168" alpha="1" force_rhr="0" clip_to_extent="1">
        <layer pass="1" class="SimpleLine" locked="0">
          <prop k="line_color" v="190,190,190,255"/>
          <prop k="line_width" v="0.6"/>
          <prop k="line_width_unit" v="MM"/>
        </layer>
        <layer pass="2" class="SimpleLine" locked="0">
          <prop k="line_color" v="255,255,255,255"/>
          <prop k="line_width" v="0.4"/>
          <prop k="line_width_unit" v="MM"/>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="simple">
    <settings fieldName="name">
      <text-style fontFamily="Segoe UI" fontSize="8" fontSizeUnit="Point" textColor="51,51,51,255" isExpression="0">
        <text-buffer bufferDraw="1" bufferSize="0.8" bufferColor="255,255,255,230"/>
      </text-style>
      <placement placement="3" priority="5" dist="0" linePlacementFlags="2"/>
      <rendering scaleVisibility="1" scaleMin="1" scaleMax="35000" obstacle="0"/>
    </settings>
  </labeling>
  <fieldConfiguration>
    <field name="id" configurationFlags="None">
      <editWidget type="Range">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowNull" value="false"/>
            <Option type="int" name="Max" value="2147483647"/>
            <Option type="int" name="Min" value="1"/>
            <Option type="int" name="Step" value="1"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="ref_id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="highway" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Motorway (Freeway)" value="motorway"/></Option>
              <Option type="Map"><Option type="QString" name="Motorway Link (Ramp)" value="motorway_link"/></Option>
              <Option type="Map"><Option type="QString" name="Trunk (Expressway)" value="trunk"/></Option>
              <Option type="Map"><Option type="QString" name="Trunk Link (Ramp)" value="trunk_link"/></Option>
              <Option type="Map"><Option type="QString" name="Primary (Arterial)" value="primary"/></Option>
              <Option type="Map"><Option type="QString" name="Primary Link (Ramp)" value="primary_link"/></Option>
              <Option type="Map"><Option type="QString" name="Secondary (Collector)" value="secondary"/></Option>
              <Option type="Map"><Option type="QString" name="Secondary Link (Ramp)" value="secondary_link"/></Option>
              <Option type="Map"><Option type="QString" name="Tertiary (Local Arterial)" value="tertiary"/></Option>
              <Option type="Map"><Option type="QString" name="Tertiary Link (Ramp)" value="tertiary_link"/></Option>
              <Option type="Map"><Option type="QString" name="Residential (Neighborhood)" value="residential"/></Option>
              <Option type="Map"><Option type="QString" name="Living Street" value="living_street"/></Option>
              <Option type="Map"><Option type="QString" name="Unclassified (Rural Road)" value="unclassified"/></Option>
              <Option type="Map"><Option type="QString" name="Service (Alley, Parking, Driveway)" value="service"/></Option>
              <Option type="Map"><Option type="QString" name="Track (Dirt/Agricultural)" value="track"/></Option>
              <Option type="Map"><Option type="QString" name="Pedestrian (Walkway)" value="pedestrian"/></Option>
              <Option type="Map"><Option type="QString" name="Footway / Path / Trail" value="footway"/></Option>
              <Option type="Map"><Option type="QString" name="Cycleway (Bike Path)" value="cycleway"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="name" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="ref" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" name="IsMultiline" value="false"/>
            <Option type="bool" name="UseHtml" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="oneway" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Two-Way Traffic (no / null)" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Oneway Forward (v0 -> vn)" value="yes"/></Option>
              <Option type="Map"><Option type="QString" name="Oneway Reverse (vn -> v0)" value="-1"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="lanes" configurationFlags="None">
      <editWidget type="Range">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowNull" value="true"/>
            <Option type="int" name="Max" value="12"/>
            <Option type="int" name="Min" value="1"/>
            <Option type="int" name="Step" value="1"/>
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
              <Option type="Map"><Option type="QString" name="Culvert" value="culvert"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="surface" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Asphalt" value="asphalt"/></Option>
              <Option type="Map"><Option type="QString" name="Concrete" value="concrete"/></Option>
              <Option type="Map"><Option type="QString" name="Paved" value="paved"/></Option>
              <Option type="Map"><Option type="QString" name="Gravel" value="gravel"/></Option>
              <Option type="Map"><Option type="QString" name="Dirt / Ground" value="dirt"/></Option>
              <Option type="Map"><Option type="QString" name="Sand" value="sand"/></Option>
              <Option type="Map"><Option type="QString" name="Unpaved" value="unpaved"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="maxspeed" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="Unspecified" value=""/></Option>
              <Option type="Map"><Option type="QString" name="15 mph" value="15"/></Option>
              <Option type="Map"><Option type="QString" name="20 mph" value="20"/></Option>
              <Option type="Map"><Option type="QString" name="25 mph" value="25"/></Option>
              <Option type="Map"><Option type="QString" name="30 mph" value="30"/></Option>
              <Option type="Map"><Option type="QString" name="35 mph" value="35"/></Option>
              <Option type="Map"><Option type="QString" name="40 mph" value="40"/></Option>
              <Option type="Map"><Option type="QString" name="45 mph" value="45"/></Option>
              <Option type="Map"><Option type="QString" name="50 mph" value="50"/></Option>
              <Option type="Map"><Option type="QString" name="55 mph" value="55"/></Option>
              <Option type="Map"><Option type="QString" name="65 mph" value="65"/></Option>
              <Option type="Map"><Option type="QString" name="70 mph" value="70"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="layer" configurationFlags="None">
      <editWidget type="Range">
        <config>
          <Option type="Map">
            <Option type="bool" name="AllowNull" value="false"/>
            <Option type="int" name="Max" value="5"/>
            <Option type="int" name="Min" value="-5"/>
            <Option type="int" name="Step" value="1"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="junction" configurationFlags="None">
      <editWidget type="ValueMap">
        <config>
          <Option type="Map">
            <Option type="List" name="map">
              <Option type="Map"><Option type="QString" name="None (Standard Way)" value=""/></Option>
              <Option type="Map"><Option type="QString" name="Roundabout (One-Way Loop)" value="roundabout"/></Option>
              <Option type="Map"><Option type="QString" name="Circular Junction" value="circular"/></Option>
            </Option>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" index="0" name="Feature ID"/>
    <alias field="ref_id" index="1" name="Road Ref ID (e.g. R_0190)"/>
    <alias field="highway" index="2" name="Highway Classification"/>
    <alias field="name" index="3" name="Street / Road Name"/>
    <alias field="ref" index="4" name="Route Reference (e.g. US 1, I-95)"/>
    <alias field="oneway" index="5" name="One-Way Direction"/>
    <alias field="lanes" index="6" name="Lane Count"/>
    <alias field="bridge" index="7" name="Bridge Structure"/>
    <alias field="tunnel" index="8" name="Tunnel Structure"/>
    <alias field="surface" index="9" name="Surface Material"/>
    <alias field="maxspeed" index="10" name="Speed Limit (mph)"/>
    <alias field="layer" index="11" name="Z-Level Stacking (-1 tunnel, 0 ground, 1 bridge)"/>
    <alias field="junction" index="12" name="Junction Geometry"/>
  </aliases>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="id" editable="1"/>
    <field name="ref_id" editable="1"/>
    <field name="highway" editable="1"/>
    <field name="name" editable="1"/>
    <field name="ref" editable="1"/>
    <field name="oneway" editable="1"/>
    <field name="lanes" editable="1"/>
    <field name="bridge" editable="1"/>
    <field name="tunnel" editable="1"/>
    <field name="surface" editable="1"/>
    <field name="maxspeed" editable="1"/>
    <field name="layer" editable="1"/>
    <field name="junction" editable="1"/>
  </editable>
  <defaults>
    <default field="id" expression="coalesce(maximum(&quot;id&quot;) + 1, count(1) + 1)" applyOnUpdate="0"/>
    <default field="ref_id" expression="'R_' || lpad(coalesce(maximum(to_int(replace(&quot;ref_id&quot;, 'R_', ''))) + 1, count(1) + 1), 4, '0')" applyOnUpdate="0"/>
    <default field="highway" expression="" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="ref" expression="" applyOnUpdate="0"/>
    <default field="oneway" expression="" applyOnUpdate="0"/>
    <default field="lanes" expression="" applyOnUpdate="0"/>
    <default field="bridge" expression="" applyOnUpdate="0"/>
    <default field="tunnel" expression="" applyOnUpdate="0"/>
    <default field="surface" expression="" applyOnUpdate="0"/>
    <default field="maxspeed" expression="" applyOnUpdate="0"/>
    <default field="layer" expression="CASE WHEN &quot;bridge&quot; IN ('yes', 'viaduct') THEN 1 WHEN &quot;tunnel&quot; IN ('yes', 'culvert') THEN -1 ELSE NULL END" applyOnUpdate="1"/>
    <default field="junction" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="ref_id" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="highway" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="name" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="ref" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="oneway" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="lanes" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="bridge" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="tunnel" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="surface" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="maxspeed" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="layer" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="junction" constraints="0" exp_strength="0" notnull_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="ref_id"/>
    <constraint desc="" exp="" field="highway"/>
    <constraint desc="" exp="" field="name"/>
    <constraint desc="" exp="" field="ref"/>
    <constraint desc="" exp="" field="oneway"/>
    <constraint desc="" exp="" field="lanes"/>
    <constraint desc="" exp="" field="bridge"/>
    <constraint desc="" exp="" field="tunnel"/>
    <constraint desc="" exp="" field="surface"/>
    <constraint desc="" exp="" field="maxspeed"/>
    <constraint desc="" exp="" field="layer"/>
    <constraint desc="" exp="" field="junction"/>
  </constraintExpressions>
</qgis>