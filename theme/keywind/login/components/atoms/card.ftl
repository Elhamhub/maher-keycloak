<#macro kw content="" footer="" header="">
  <div class="bg-none md:bg-white px-7 md:p-[4.5rem] md:pt-8 md:pb-10 md:rounded-xxl card-auth">
    <div class="relative z-10 space-y-6">
      <#if header?has_content>
        <div class="space-y-4">
          ${header}
        </div>
      </#if>
      <#if content?has_content>
        <div class="space-y-4">
          ${content}
        </div>
      </#if>
      <#if footer?has_content>
        <div class="space-y-4">
          ${footer}
        </div>
      </#if>
    </div>
  </div>
</#macro>
