module namespace page = 'http://basex.org/modules/web-page';

import module namespace csd_dm = "https://github.com/his-interop/openinfoman/csd_dm" at "../repo/csd_document_manager.xqm";
import module namespace csd_webconf =  "https://github.com/his-interop/openinfoman/csd_webconf" at "../repo/csd_webapp_config.xqm";
import module namespace csd_lsc = "https://github.com/his-interop/openinfoman/csd_lsc" at "../repo/csd_local_services_cache.xqm";


declare   namespace   csd = "urn:ihe:iti:csd:2013";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare updating
  %rest:path("/CSD/push/{$name}/pushRequest/update")
  %rest:consumes("application/xml", "text/xml", "multipart/form-data")  
  %rest:POST("{$pushRequest}")
  function page:push_updating($name,$pushRequest) 
{ 
if (csd_dm:document_source_exists($csd_webconf:db,$name)) then 
 let $cache_doc := csd_lsc:get_cache($csd_webconf:db,$name)
 return (csd_lsc:refresh_doc($cache_doc ,$pushRequest/pushRequest))
else
  (:need appropriate error handling:)
  ()

};


declare
  %rest:path("/CSD/push")
  %rest:GET
  %output:method("xhtml")
  function page:push_home() 
{ 
let $response := page:push_home_content()
return page:wrapper($response)
};


declare function page:wrapper($response) {
 <html>
  <head>

    <link href="{$csd_webconf:baseurl}static/bootstrap/css/bootstrap.css" rel="stylesheet"/>
    <link href="{$csd_webconf:baseurl}static/bootstrap/css/bootstrap-theme.css" rel="stylesheet"/>
    

    <script src="https://code.jquery.com/jquery.js"/>
    <script src="{$csd_webconf:baseurl}static/bootstrap/js/bootstrap.min.js"/>

    <script src="https://code.jquery.com/jquery.js"/>
    <script src="{$csd_webconf:baseurl}static/bootstrap/js/bootstrap.min.js"/>

  </head>
  <body>  
    <div class="navbar navbar-inverse navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="{$csd_webconf:baseurl}CSD">OpenInfoMan</a>
        </div>
      </div>
    </div>
    <div class='container'>
      {$response}
    </div>
  </body>
 </html>
};


declare function page:push_home_content() {
<div>
    <h2>Care Services Push Requests (Home)</h2>
    <div>Content to be added later</div>
  </div>
};




