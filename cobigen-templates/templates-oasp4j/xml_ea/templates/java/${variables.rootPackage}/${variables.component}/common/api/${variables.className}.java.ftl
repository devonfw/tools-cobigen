<#ftl ns_prefixes={"xmi":"http://schema.omg.org/spec/XMI/2.1", "uml":"http://schema.omg.org/spec/UML/2.1"}>
<#include '/functions.ftl'>
<#compress>
<#assign name = elemDoc["self::node()/@name"]>

<#list connectors as connector>
    <#assign source = connector["source"]>
    <#assign target = connector["target"]> 
    ${OaspUtil.resolveConnectorsContent(source, target, name)}
</#list>

package ${variables.rootPackage}.${variables.component}.common.api;

import ${variables.rootPackage}.general.common.api.ApplicationEntity;

public interface ${name} extends ApplicationEntity {

${OaspUtil.generateConnectorsVariablesMethodsText(false,false)}

<#list elemDoc["./ownedAttribute"] as attribute>
  <#if (attribute["@name"])??>
    <#if (attribute["type/@xmi:idref"]) == "EAJava_int">
    public Integer get${attribute["@name"]?cap_first}();
    
    public void set${attribute["@name"]?cap_first}(Integer ${attribute["@name"]});
    <#else>    
    public ${(attribute["type/@xmi:idref"]?replace("EAJava_",""))?cap_first} get${attribute["@name"]?capitalize}();
    
    public void set${attribute["@name"]?cap_first}(${(attribute["type/@xmi:idref"]?replace("EAJava_",""))?capitalize});
    </#if>
  </#if>
</#list>
}
</#compress>
