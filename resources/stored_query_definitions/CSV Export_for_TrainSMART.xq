declare module namespace tpl = "urn:hitrac.org.zw:stored_query:trainSMART_participant_list";

import module namespace csv = "http://basex.org/modules/csv";

declare element namespace csd = "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;


declare function tpl:get_current_deployment_facility($provider) {
  let $facs := $provider/csd:facilities/csd:facility
  let $start_dates := distinct-values($facs/csd:extension[@type='deployment_details' and @oid='2.25.62572576096234591446887698759906520253']/start_date)
  (:maybe no start_date data was uploaded yet:)
  let $fac:= if (count($start_dates) = 0) then
    $facs[1]
  else
    let $max_start_date := max($start_dates)
    return ($facs[ ./csd:extension[@type='deployment_details' and @oid='2.25.62572576096234591446887698759906520253' and ./start_date = $max_start_date]])[1]
   (:now have the most current facility (hopefully) :)
  let $fac_record := /csd:CSD/csd:facilityDirectory/csd:facility[@oid = $fac/@oid]
  
  return $fac_record
}

for $provider in /csd:CSD/csd:providerDirectory/csd:provider
   let $surname := ($provider/csd:demographic/csd:name/csd:surname)[1]
   let $forename := ($provider/csd:demographic/csd:name/csd:forename)[1]
   let $nationalId := string(($provider/csd:otherID[@assigningAuthorityName = "mohaffairs.gov"]/@code)[1])
   let $gender := $provider/csd:demographic/csd:gender
   let $professional_qualification := ($provider/csd:codedType/@code)[1]
   let $facility := tpl:get_current_deployment_facility($provider)
   let $facility_name := $facility/csd:primaryName


