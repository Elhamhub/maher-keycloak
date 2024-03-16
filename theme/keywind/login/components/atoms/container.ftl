<#import "/assets/icons/question-circle.ftl" as questionCircle>
<#macro kw>
  <div class="max-w-md space-y-6 w-full my-auto">
    <#nested>
  </div>
  
  <div class="container mt-auto relative">
    <div class="footer flex justify-between py-5 px-3">
      <p class="m-0 text-secondary-500 text-sm">Copy Rights</p>
      <a class="m-0 text-secondary-500 hover:text-secondary-600 text-sm flex items-center content-center" href="#" target="_blank"><@questionCircle.kw /><span class="ms-2">Help</span></a>
    </div>
  </div>
</#macro>
