import module namespace dxf = "http://dhis2.org/schema/dxf/1.0" ;



<svs:ValueSet  xmlns="urn:ihe:iti:svs:2008" xmlns:svs="urn:ihe:iti:svs:2008" id="2.25.62572576096234591446887698759906520253.1" version="2013.07.01" displayName="Dhis Facilities">
    <svs:ConceptList> 
      { 
      for $orgUnit in /dxf:dxf/dxf:organisationUnits/dxf:organisationUnit
      let $displayName:=$orgUnit/dxf:name/text()
      let $uid:=$orgUnit/dxf:uid/text()
      let $level := dxf:orgunit_get_level(/,$orgUnit)
      where (($level = 4) or ($level = 5))
      return 
        <svs:Concept code="{$uid}" displayName="{$displayName}" codeSystem="dhis.mohcc.gov.zw"></svs:Concept>
	
      }
    </svs:ConceptList>
</svs:ValueSet>


